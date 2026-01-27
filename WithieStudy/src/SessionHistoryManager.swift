//
//  SessionManager.swift
//  WithieStudy
//
//
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
    
    func editSessionNote(id: UUID, newNotes: String) {
        let descriptor = FetchDescriptor<PastSession>(
            predicate: #Predicate { $0.id == id }
        )
        
        if let session = try? modelContext.fetch(descriptor).first {
            session.notes = newNotes
        }
    }
}

