//
//  SessionManager.swift
//  WithieStudy
//
//

import Foundation

class SessionHistoryManager {
    var sessionLogs: [PastSession] = []
    
    func addSession(type: SessionType, duration: TimeInterval, dateCompleted: Date, notes: String) {
        let session = PastSession(type: type, duration : duration, dateCompleted: dateCompleted, notes: notes)
        sessionLogs.append(session)
    }
    
    func editSessionNote(id: UUID, newNotes: String) {
        if let index = sessionLogs.firstIndex(where: { $0.id == id }) {
            sessionLogs[index].notes = newNotes
        }
    }
}
