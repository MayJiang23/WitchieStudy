import Foundation

struct GiftEvent: RelationEvent {
    var targetId: String
    var amount: Int
    var items: [InventoryItem]
    var tierUp: Bool
    var newTierTitle: String?

    func getReportData(_ config: Any) -> Any {
        return (targetId, amount, tierUp, newTierTitle ?? "")
    }
}
