protocol RelationEvent: ReportableEvent {
    var targetId: String { get set }
    var amount: Int { get set }
}


extension RelationEvent {
    func getReportData(_ config: Any?) -> (String, Int)? {
        return (self.targetId, self.amount)
    }
}
