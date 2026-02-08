//
//  PastSession.swift
//  WithieStudy
//
//
import SwiftData
import Foundation

@Model
class PastSession: Identifiable {
    var id: UUID
    var type: SessionType
    var duration: TimeInterval
    var dateCompleted: Date
    var notes: String
    
    init(type: SessionType, duration: TimeInterval, dateCompleted: Date, notes: String = "Time flies by...")
    {
        self.id = UUID()
        self.type = type
        self.duration = duration
        self.dateCompleted = dateCompleted
        self.notes = notes
    }
}

