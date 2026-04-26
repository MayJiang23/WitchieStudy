import Foundation
import SwiftData

@Model
class GiftModule: Module {
    var moduleKey: String = "gifts"

    var likes: GiftPreference
    var hates: GiftPreference

    init(likes: GiftPreference, hates: GiftPreference) {
        self.likes = likes
        self.hates = hates
    }
}
