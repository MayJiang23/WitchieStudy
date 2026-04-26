protocol ItemEvent: AppEvent {
    var items: [InventoryItem] { get set }
}
