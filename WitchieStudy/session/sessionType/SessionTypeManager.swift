import Foundation
import SwiftData

class SessionTypeManager {
    var allTypes: Array<SessionType>
    
    init() {
        self.fetchTypes()
    }
    
    func addType(title: String, themeAction: ThemeAction) {
        let predicate = #Predicate<SessionType> {
            $0.title == title
        }
        
        if !hasType(predicate: predicate) {
            let newType = SessionType(title: title, themeAction: themeAction)
            
            Task {
                await DataCoordinator.shared.insert([newType])
                await DataCoordinator.shared.save()
            }
        }
    }
    
    func removeType(id: PersistentIdentifier) {
        let predicate = #Predicate<SessionType> {
            $0.id == id
        }
        let descriptor = FetchDescriptor<SessionType>(predicate: predicate)
        
        Task {
            await
            DataCoordinator.shared.delete(type: SessionType.self, descriptor: descriptor)
        }
    }
    
    func hasType(predicate: Predicate<SessionType>) -> Bool {
        let descriptor = FetchDescriptor<SessionType>(
            predicate: predicate
        )
        Task {
            let result = await DataCoordinator.shared.get(descriptor) != nil
            return result
        }
        return false
    }
    
    private func fetchTypes() {
        Task {
            let descriptor = FetchDescriptor<SessionType>()
        
            let types = await DataCoordinator.shared.getOrCreate(descriptor, onCreate: SessionType.createDefault)
            
            self.allTypes = types
        }
    }
}

