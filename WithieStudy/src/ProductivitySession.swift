//
//  ProductivitySession.swift
//  WithieStudy
//
//
import Foundation
import SwiftData

@Model
class ProductivitySession {
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
    
    func set_startTime(startTime: Date) {
        self.startTime = startTime
    }
}

