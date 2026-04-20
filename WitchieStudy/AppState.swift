import Combine
import SwiftData

@Observable
class AppState {
    var sessionManager: LiveSessionManager
    var inventory: InventoryManager
    //var stats: StatManager
    var loot: LootManager
    var report: SessionReportManager
    var player: PlayerCharacterManager
    var relations: RelationshipManager
    var characterRegistry: CharacterRegistry
    var wardrobe: WardrobeManager
    
    var modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        
        let newInventory = InventoryManager(modelContext: modelContext)
        self.inventory = newInventory
        self.sessionManager = LiveSessionManager(
            history: SessionHistoryManager(modelContext: modelContext),
            sessionTypes: SessionTypeManager(modelContext: modelContext),
            modelContext: modelContext
        )
        self.loot = LootManager(inventory: newInventory)
        self.report = SessionReportManager(modelContext: modelContext, nil)
        self.player = PlayerCharacterManager(modelContext: modelContext)
        self.characterRegistry = CharacterRegistry()
        self.relations = RelationshipManager(modelContext: modelContext, registry: self.characterRegistry)
        self.wardrobe = WardrobeManager()
        self.wardrobe.playerManager = self.player
        
        self.setupInternalConnections()
    }
    
    private func setupInternalConnections() {
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
    }
    
    
}
