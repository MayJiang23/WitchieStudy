import Foundation
import SwiftData

@Model
class PlayerCharacter: Identifiable {
    var id: UUID
    var modules: [String: Module] = [:]

    init() {
        self.id = UUID()
        
        if let statsRaw = statsRaw {
            self.statsRaw = statsRaw
        } else {
            var defaults: [String: Int] = [:]
            for stat in StatType.allCases {
                defaults[stat.rawValue] = 0
            }
            self.statsRaw = defaults
        }
    }

    func get() -> Module {
        
    }

    func getStat(_ stat: StatType) -> Int {
        return statsRaw[stat.rawValue] ?? 0
    }

    func setStat(_ stat: StatType, value: Int) {
        statsRaw[stat.rawValue] = value
    }

    func getEquipped(_ category: WardrobeCategory) -> String? {
        return equippedOutfitRaw[category.rawValue]
    }

    func setEquipped(_ category: WardrobeCategory, itemName: String?) {
        if let itemName = itemName {
            equippedOutfitRaw[category.rawValue] = itemName
        } else {
            equippedOutfitRaw.removeValue(forKey: category.rawValue)
        }
    }
}
