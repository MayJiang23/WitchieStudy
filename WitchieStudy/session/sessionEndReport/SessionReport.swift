import Foundation
import SwiftData

@Model
class SessionReport: Identifiable {
    var activityName: String
    var durationMinutes: Int
    
    var statChange: Int
    var characterName: String
    var characterQuote: String
    var itemsFound: [InventoryItem]
    
    init(activityName: String, durationMinutes: Int, statChange: Int, characterName: String, characterQuote: String, itemsFound: [InventoryItem]) {
        self.activityName = activityName
        self.durationMinutes = durationMinutes
        
        self.statChange = statChange
        self.characterName = characterName
        self.characterQuote = characterQuote
        self.itemsFound = itemsFound
    }
}
