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
    
    init(startTime: Date, durationInSeconds: Int, type: SessionType) {
        self.id = UUID()
        self.type = type
        self.durationInSeconds = durationInSeconds
        self.startTime = startTime
    }
    
    func set(startTime: Date?, type: SessionType?, durationInSeconds: Int?) {
        if let startTime = startTime {
            self.startTime = startTime
        }
        if let type = type {
            self.type = type
        }
        if let durationInSeconds = durationInSeconds {
            self.durationInSeconds = durationInSeconds
        }
        
    }
}

