import Foundation

enum ThemeAction: String, Codable, CaseIterable, Identifiable {
    case work = "Work"
    case study = "Study"
    case exercise = "Exercise"
    
    var statType: StatType {
        switch self {
        case .work: return .con
        case .study: return .wis
        case .exercise: return .str
        }
    }
    var id: String { self.rawValue }
}

