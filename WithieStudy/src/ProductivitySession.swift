//
//  ProductivitySession.swift
//  WithieStudy
//
//
import Foundation

struct ProductivitySession {
    let id = UUID()
    var startTime: Date
    var durationInSeconds: Int
    var type: SessionType
}

