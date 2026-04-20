import Foundation

/// Holds the item names that a character prefers to receive as gifts.
/// Preferred items yield a bonus XP multiplier when gifted.
struct GiftModule: Module {
    let moduleKey: String = "gifts"

    /// Item names this character considers a preferred gift.
    let preferences: [String]
}
