//
//  SessionTypeManager.swift
//  WithieStudy
//
//
import Foundation
import SwiftData

class SessionTypeManager {
    var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    var sessionTypes: [SessionType] = [
        SessionType(title: "Study"),
        SessionType(title: "Work")
    ]
    
    func addType(name: String) -> Void {
        if !hasType(name: name) {
            sessionTypes.append(SessionType(title: name))
        }
    }
    
    func removeType(idx: Int) -> Void {
        sessionTypes.remove(at: idx)
    }
    
    func hasType(name: String) -> Bool {
        return sessionTypes.contains { $0.title == name }
    }
}

