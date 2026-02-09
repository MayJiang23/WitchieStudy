//
//  ThemeAnimation.swift
//  WithieStudy
//
//
import Foundation

class ThemeAction: Identifiable {
    var id: UUID
    var statType: StatType
    
    init(statType: StatType) {
        self.id = UUID()
        self.statType = statType
    }
}

