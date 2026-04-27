import Foundation
import SwiftData


@Model
class PlayerCharacter {
    @Relationship(deleteRule: .cascade) var core: SaveableEntity
    
    init(core: SaveableEntity) {
        self.core = core
    }
}
