struct ItemLootedEvent: ItemFoundEvent {
    internal var items: [InventoryItem]
    internal var targetId: String
    
    init(items: [InventoryItem], targetId: String) {
        self.items = items
        self.targetId = targetId
    }
    
    func getData(_ config: Any?) -> (String, Array<InventoryItem>)? {
        return (self.targetId, self.items)
    }
}
