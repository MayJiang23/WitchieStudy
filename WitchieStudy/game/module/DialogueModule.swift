import Foundation

/// Holds tier-indexed dialogue lines for a character.
/// Lines are keyed by tier index string (e.g. "0", "1", "2", "3")
/// so new tiers can be added to the data source without touching this type.
struct DialogueModule: Module {
    let moduleKey: String = "dialogue"

    /// Dialogue lines keyed by tier index string.
    let lines: [String: [String]]

    /// Returns the dialogue lines for the given relationship tier index,
    /// falling back to an empty array if no lines are defined for that tier.
    func linesForTier(_ tierIndex: Int) -> [String] {
        return lines[String(tierIndex)] ?? []
    }
}
