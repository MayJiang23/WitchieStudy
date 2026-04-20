protocol ItemEvent: ReportableEvent {
    var items: Array<InventoryItem> { get set }
}

extension ItemEvent {
    func getReportData(_ config: Any) -> Any {
        return items
    }
}
