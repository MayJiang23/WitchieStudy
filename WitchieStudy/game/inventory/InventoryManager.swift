import Foundation
import SwiftData
import Combine

@Observable
@MainActor
class InventoryManager {
    private var cancellables = Set<AnyCancellable>()
    
    var inv: Inventory!

    init() {
        self.fetchInventory()
        
        EventBus.shared.subscribe(to: ItemReportSummaryEvent.self, perform: onSummary)
            .store(in: &cancellables)
    }
    
    func onSummary(_ event: ItemReportSummaryEvent) {
        if let items = event.getData(Any.self) {
            addItems(items: items)
        }
    }
    
    func addItems(to entityId: UUID, items: [InventoryItem]) {
        for item in items {
            if let index = inv.slots.firstIndex(where: { $0?.itemDef.id == item.itemDef.id }) {
                addItem(item: item, index: index)
            } else {
                addItemToFirstEmptySlot(item)
            }
        }
    }

    func moveItem(from index: Int, to destinationIndex: Int) {
        let draggedItem = inv.slots[index]
        let targetItem = inv.slots[destinationIndex]

        inv.slots[destinationIndex] = draggedItem
        inv.slots[index] = targetItem
        
        Task {
            await DataCoordinator.shared.save()
        }
    }
    
    func addItem(item: InventoryItem, index: Int? = nil) {
        if (index != nil) {
            if var invItem = inv.slots[index!] {
                if item.itemDef.stackable {
                    if item.itemDef.maxStack <= (invItem.quantity + item.quantity) {
                            invItem.quantity = invItem.quantity + item.quantity
                            Task {
                                await DataCoordinator.shared.save()
                            }
                            return
                    } else {
                        let extra = abs(invItem.quantity + item.quantity - item.itemDef.maxStack)
                        var copy = item
                        copy.quantity = extra
                        addItemToFirstEmptySlot(copy)
                        return
                    }
                }
            } else {
                inv.slots[index!] = item
                Task {
                    await DataCoordinator.shared.save()
                }
                return
            }
        }
        addItemToFirstEmptySlot(item)
    }
    
    private func addItemToFirstEmptySlot(_ item: InventoryItem) {
        if let emptyIndex = inv.slots.firstIndex(where: { $0 == nil }) {
            inv.slots[emptyIndex] = item
            Task {
                await DataCoordinator.shared.save()
            }
        } else {
            print("Inventory is full!")
        }
    }
    
    private func fetchInventory() {
        let descriptor = FetchDescriptor<Inventory>()
        
        Task {
            self.inv = await DataCoordinator.shared.getOrCreate(descriptor, onCreate: Inventory.createDefault).first
        }
    }
}
