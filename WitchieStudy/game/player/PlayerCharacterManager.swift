import Foundation
import SwiftData

@Observable
class PlayerCharacterManager {
    var modelContext: ModelContext
    var player: PlayerCharacter!

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        if let existing = fetchPlayer() {
            self.player = existing
        } else {
            let defaultPlayer = PlayerCharacter(name: "Apprentice", currency: 0)
            modelContext.insert(defaultPlayer)
            try? modelContext.save()
            self.player = defaultPlayer
        }
    }

    func addCurrency(_ amount: Int) {
        player.currency += amount
        save()
    }

    func spendCurrency(_ amount: Int) -> Bool {
        guard player.currency >= amount else { return false }
        player.currency -= amount
        save()
        return true
    }

    func increaseStat(_ stat: StatType, by amount: Int) {
        let current = player.getStat(stat)
        player.setStat(stat, value: current + amount)
        save()
    }

    func getStatValue(_ stat: StatType) -> Int {
        return player.getStat(stat)
    }

    func equipItem(_ item: ClothingItem) {
        player.setEquipped(item.category, itemName: item.name)
        save()
    }

    func unequipItem(_ category: WardrobeCategory) {
        player.setEquipped(category, itemName: nil)
        save()
    }

    private func fetchPlayer() -> PlayerCharacter? {
        let descriptor = FetchDescriptor<PlayerCharacter>()
        do {
            let results = try modelContext.fetch(descriptor)
            if let existing = results.first {
                return existing
            }
            return nil
        } catch {
            print("Fetch PlayerCharacter failed: \(error.localizedDescription)")
            return nil
        }
    }

    private func save() {
        try? modelContext.save()
    }
}
