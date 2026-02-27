import Foundation
import SwiftData

class SessionTypeManager {
    var modelContext: ModelContext
    
    var allTypes: Array<SessionType> {
        let descriptor = FetchDescriptor<SessionType>()
        let types = try! modelContext.fetch(descriptor)
        return types
    }
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func addType(title: String, themeAction: ThemeAction) -> Bool {
        let predicate = #Predicate<SessionType> {
            $0.title == title
        }
        
        if !hasType(predicate: predicate) {
            let newType = SessionType(title: title, themeAction: themeAction)
            modelContext.insert(newType)
            try? modelContext.save()
            return true
        }
        return false
    }
    
    func removeType(id: PersistentIdentifier) {
        let predicate = #Predicate<SessionType> {
            $0.id == id
        }
        
        if hasType(predicate: predicate) {
            try? modelContext.delete(model: SessionType.self, where: predicate)
            try? modelContext.save()
        }
    }
    
    func hasType(predicate: Predicate<SessionType>) -> Bool {
        let descriptor = FetchDescriptor<SessionType>(
            predicate: predicate
        )
        
        return ((try? modelContext.fetchCount(descriptor)) != 0)
    }
    
    private func deleteAll() {
        do {
            try modelContext.delete(model: SessionType.self)
            try? modelContext.save()
        } catch {
        }
    }

}

