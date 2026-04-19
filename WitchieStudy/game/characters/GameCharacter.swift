import Foundation

struct GameCharacter: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    
    var relationProfile: RelationProfile
}
