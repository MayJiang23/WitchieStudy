import Combine
import SwiftData

@Observable
class AppState {
    var sessionManager: LiveSessionManager
    var inventory: InventoryManager
    //var stats: StatManager
    var loot: LootManager
    
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
        
        self.setupInternalConnections()
    }
    
    private func setupInternalConnections() {
        sessionManager.onTick = { [weak self] in
            self?.loot.attemptLoot()
        }
    }
}
