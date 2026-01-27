//
//  SessionType.swift
//  WithieStudy
//
//
import Foundation
import SwiftData

@Model
class SessionType {
    var id : UUID
    var title: String
    //var themeAnimation: ThemeAnimation
    
    init(title: String) {
        self.id = UUID()
        self.title = title
    }
}

