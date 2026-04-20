struct ItemFoundEvent: ItemEvent {
    var items: Array<InventoryItem>
    
    init(items: Array<InventoryItem>) {
        self.items = items
    }
    
    func getReportString() -> String {
        let formatted = items.compactMap {$0.name}
        return "Found items: " + formatted.joined(separator: ",")
    }
}
