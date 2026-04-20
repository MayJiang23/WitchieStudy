import Combine
import SwiftData

@Observable
class AppState {
    var sessionManager: LiveSessionManager
    var inventory: InventoryManager
    //var stats: StatManager
    var loot: LootManager
    var report: SessionReportManager
    
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
        
        self.setupInternalConnections()
    }
    
    private func setupInternalConnections() {
        self.sessionManager.onTick = { [weak self] in
            if let item = self?.loot.attemptLoot() {
                self?.inventory.addItem(item: item)
                self?.report.addItem(item: item, source: ItemSource.loot(sessionID: nil))
            }
        }
    }
}
