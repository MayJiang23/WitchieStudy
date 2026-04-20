import Foundation

/// Holds the static identity data for a character: display name, lore description,
/// and the asset name used to look up their portrait image.
struct IdentityModule: Module {
    let moduleKey: String = "identity"
    let name: String
    let description: String
    let portraitImageName: String
}
