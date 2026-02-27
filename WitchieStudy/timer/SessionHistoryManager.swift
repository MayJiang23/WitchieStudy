import Foundation
import SwiftData
import _SwiftData_SwiftUI

class SessionHistoryManager {
    var modelContext: ModelContext

    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func addSession(type: SessionType, duration: TimeInterval, dateCompleted: Date, notes: String) {
        let session = PastSession(type: type, duration : duration, dateCompleted: dateCompleted, notes: notes)
        modelContext.insert(session)
    }
    
    func editSessionNote(id: PersistentIdentifier, newNotes: String) {
        let descriptor = FetchDescriptor<PastSession>(
            predicate: #Predicate { $0.id == id }
        )
        
        if let session = try? modelContext.fetch(descriptor).first {
            session.notes = newNotes
        }
    }
    
    func fetchPastSessions(type: SessionType?) -> Array<PastSession> {
        var descriptor = FetchDescriptor<PastSession>()
        
        if let type {
            let typeId = type.id
            descriptor = FetchDescriptor<PastSession>(
                predicate: #Predicate { $0.type.id == typeId }
            )
        }
        
        if let sessions = try? modelContext.fetch(descriptor) {
            return sessions
        }
        return []
    }
    
    private func deleteAll() {
        do {
            try modelContext.delete(model: PastSession.self)
        } catch {
        }
    }
}

