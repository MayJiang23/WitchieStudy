//
//  ProductivitySession.swift
//  WithieStudy
//
//
import Foundation
import SwiftData

@Model
class ProductivitySession: Identifiable {
    var id: UUID
    var startTime: Date
    var durationInSeconds: Int
    var type: SessionType
    var secondsRemain: Int
    var lastHeartbeat: Date?
    var started: Bool = false
    
    init(startTime: Date, durationInSeconds: Int, type: SessionType, secondsRemain: Int) {
        self.id = UUID()
        self.type = type
        self.durationInSeconds = durationInSeconds
        self.startTime = startTime
        self.secondsRemain = secondsRemain
        self.lastHeartbeat = startTime
    }
    
    func set(startTime: Date?, type: SessionType?, durationInSeconds: Int?, secondsRemain: Int?, lastHeartbeat: Date?) {
        if let startTime = startTime {
            self.startTime = startTime
        }
        if let type = type {
            self.type = type
        }
        if let durationInSeconds = durationInSeconds {
            self.durationInSeconds = durationInSeconds
        }
        if let secondsRemain = secondsRemain {
            self.secondsRemain = secondsRemain
        }
        if let lastHeartbeat = lastHeartbeat {
            self.lastHeartbeat = lastHeartbeat
        }
    }
}

