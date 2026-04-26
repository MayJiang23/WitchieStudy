struct ItemReportSummaryEvent: ReportableEvent {
    typealias ReportData = Any
    typealias AppData = [InventoryItem]
    
    internal var items: [InventoryItem]

    func getData(_ config: Any?) -> [InventoryItem]? {
        return items
    }
    
    func getReport(_ config: Any?) -> ReportData? {
        return nil
    }
}
