protocol ReportableEvent {
    func getReportData(_ config: Any) -> Any
}

extension ReportableEvent {
    func getReportData(_ config: Any) -> Any {
        print("Does not implement getReportData.")
    }
}
