import Foundation
import SwiftData

/// Holds the static identity data for a character: display name, lore description,
/// and the asset name used to look up their portrait image.

@Model
class IdentityModule: Module {
    var moduleKey: String = "identity"
    var name: String
    var desc: String
    var portraitImageName: String
    
    init(name: String, description: String, portraitImageName: String) {
        self.name = name
        self.desc = description
        self.portraitImageName = portraitImageName
    }
}
