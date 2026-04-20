import SwiftData
import Foundation

enum ItemSource {
    case loot(sessionID: UUID?)
    case gift(sender: String)
    case shop(price: Int)
    case quest(questName: String)
}
/**
@Observable
class AcquisitionCoordinator {
    private var inventory: InventoryManager
    private var sessionManager: LiveSessionManager
    
    init(inventory: InventoryManager, session: LiveSessionManager) {
        self.inventory = inventory
        self.sessionManager = session
    }

    func add(_ item: InventoryItem, source: ItemSource) {
        inventory.addItem(item)
        recordAcquisition(item, from: source)
    }
    
    private func recordAcquisition(_ item: InventoryItem, from source: ItemSource) {
        
    }
}
 */
