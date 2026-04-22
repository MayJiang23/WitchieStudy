import Foundation
import SwiftData

/// Holds the item names that a character prefers to receive as gifts.
/// Preferred items yield a bonus XP multiplier when gifted.
@Model
class GiftModule: Module {
    var moduleKey: String = "gifts"

    /// Item names this character considers a preferred gift.
    var preferences: [ItemDef]
    init(preferences: [ItemDef]) {
        self.preferences = preferences
    }
}
