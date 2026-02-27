import Foundation

enum StatType: String, Codable, CaseIterable, Identifiable {
    case int = "Resonance"
    case cha = "Composure"
    case wis = "Knowledge"
    case con = "Tenacity"
    case str = "Potency"
    case dex = "Finesse"
    
    var id: String { self.rawValue }
}
