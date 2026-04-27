import Foundation
import SwiftData

/// Holds the static identity data for a character: display name, lore description,
/// and the asset name used to look up their portrait image.

class IdentityModule: Module {
    var moduleKey: String = "identity"
    var name: String
    var fullName: String
    var desc: String
    
    
    init(name: String, description: String, fullName: String) {
        self.name = name
        self.fullName = fullName
        self.desc = description
    }
}
