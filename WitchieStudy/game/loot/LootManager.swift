import SwiftUI
import UniformTypeIdentifiers

struct LootManager {
    private var lastLootTimestamp: TimeInterval = 0
    private let lootInterval: TimeInterval = 120 //@TODO: Change to be more dynamic
        
    //@TODO: Change the loot chance to be more dynamic
    let lootChance: Double = 0.4
    
    //@TODO: Change the pool of possible loot to be more dynamic. E.G., based on the current schedule of the player.
    //@TODO: Rely on loot table instead of just item pool
    let possibleItems = [
        InventoryItem(id: UUID(), name: "Magic Potion", icon: "flask.fill"),
        InventoryItem(id: UUID(), name: "Steel Shield", icon: "shield.fill"),
        InventoryItem(id: UUID(), name: "Gold Coin", icon: "bitcoinsign.circle")
    ]

    init() {
        EventBus.shared.subscribe(to: SessionPulseEvent, perform: <#T##(T) -> Void#>)
    }
    
    mutating func onPulse(_ event: SessionPulseEvent) {
        let elapsedTime = Double(event.seconds)
        if elapsedTime + self.lastLootTimestamp < lootInterval {
            attemptLoot()
        } else {
            self.lastLootTimestamp = elapsedTime + self.lastLootTimestamp
        }
    }
    
    private func attemptLoot(_ targetId: String = "player") {
        let roll = Double.random(in: 0...1)
            
        if roll <= lootChance {
            if let newItem = possibleItems.randomElement() {
                EventBus.shared.publish(ItemFoundEvent(items: [newItem], targetId: targetId))
            }
        }
    }
}

self.sessionManager.onTick = { [weak self] in
    if let item = self?.loot.attemptLoot() {
        self?.inventory.addItem(item: item)
        
        let event = ItemFoundEvent(items: [item])
        self?.report.addEvents(events: [event])
    }
}

self.sessionManager.onFinish = { [weak self] actualTimeSpent, sessionType in
            guard let self = self else { return }
            
            // Award currency: 1 coin per minute spent
            let minutesSpent = Int(actualTimeSpent / 60)
            let currencyEarned = max(minutesSpent, 1)
            self.player.addCurrency(currencyEarned)
            
            // Award stat increase based on session type's theme action
            let statType = sessionType.themeAction.statType
            let statGain = max(minutesSpent / 5, 1)
            self.player.increaseStat(statType, by: statGain)
        }
