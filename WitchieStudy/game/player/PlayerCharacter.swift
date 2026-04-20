import Foundation
import SwiftData

@Model
class PlayerCharacter: Identifiable {
    var id: UUID
    var name: String
    var currency: Int

    var statsRaw: [String: Int]

    var equippedOutfitRaw: [String: String]

    init(
        name: String = "Apprentice",
        currency: Int = 0,
        statsRaw: [String: Int]? = nil,
        equippedOutfitRaw: [String: String] = [:]
    ) {
        self.id = UUID()
        self.name = name
        self.currency = currency
        self.equippedOutfitRaw = equippedOutfitRaw

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
