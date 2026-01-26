//
//  PastSession.swift
//  WithieStudy
//
//
import Foundation

struct PastSession: Identifiable {
    let id = UUID()
    let type: SessionType
    let duration: TimeInterval
    let dateCompleted: Date
    var notes: String = "When focused, time flies by fast..."
}
