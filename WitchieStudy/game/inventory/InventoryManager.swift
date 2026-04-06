import Foundation
import SwiftData
import Combine

@Observable
class InventoryManager {
    var modelContext: ModelContext

    var inv: Inventory!

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        let newinv = self.fetchInventory()
        
        if newinv != nil {
            self.inv = newinv
        }
    }

    func moveItem(from index: Int, to destinationIndex: Int) {
        let draggedItem = inv.slots[index]
        let targetItem = inv.slots[destinationIndex]

        inv.slots[destinationIndex] = draggedItem
        inv.slots[index] = targetItem
        
        save()
    }
    
    func addItem(item: InventoryItem, index: Int? = nil) {
        if index != nil {
            
        } else {
            addItemToFirstEmptySlot(item)
        }
    }
    
    private func addItemToFirstEmptySlot(_ item: InventoryItem) {
        if let emptyIndex = inv.slots.firstIndex(where: { $0 == nil }) {
            inv.slots[emptyIndex] = item
            save()
        } else {
            print("Inventory is full!")
        }
    }
    
    private func fetchInventory() -> Inventory? {
        let descriptor = FetchDescriptor<Inventory>()
        
        do {
            let sessions = try modelContext.fetch(descriptor)
            print(sessions)
            if let inv = sessions.first {
                print("found")
                return inv
            }
            return nil
        } catch {
            print("Fetch failed: \(error.localizedDescription)")
            return nil
        }
    }
    
    private func save() {
        try? modelContext.save()
    }
    
    private func deleteAll() {
        do {
            try modelContext.delete(model: ProductivitySession.self)
        } catch {
        }
    }
}
