protocol ItemFoundEvent: ItemEvent where AppData == (String, [InventoryItem])  {
    var items: [InventoryItem] { set get }
    var targetId: String { set get }
}
