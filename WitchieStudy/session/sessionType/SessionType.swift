import Foundation
import SwiftData

@Model
class SessionType: Identifiable {
    @Attribute var title: String
    @Relationship(deleteRule: .cascade, inverse: \PastSession.type) var sessions: [PastSession]? = []
    
    var themeAction: ThemeAction
    
    init(title: String, themeAction: ThemeAction) {
        self.title = title
        self.themeAction = themeAction
    }
}

