protocol ReportableEvent: AppEvent {
    associatedtype ReportData
    func getReport(_ config: Any?) -> ReportData?
}
