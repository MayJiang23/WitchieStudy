import SwiftData
import Foundation

class InventoryInitializer {
    static func initialize(container: ModelContainer) {
        let context = container.mainContext
        let descriptor = FetchDescriptor<Inventory>()
        
        if let count = try? context.fetchCount(descriptor), count == 0 {
            var slots = Array<InventoryItem?>(repeating: nil, count: 15)
            slots[1] = InventoryItem(id: UUID(), name: "Shield", icon: "shield.fill")
            slots[2] = InventoryItem(id: UUID(), name: "Potion", icon: "flask.fill")
            let inv = Inventory(slots: slots)
            print(inv.slots)
            context.insert(inv)
            try? context.save()
        }
    
    }
}
