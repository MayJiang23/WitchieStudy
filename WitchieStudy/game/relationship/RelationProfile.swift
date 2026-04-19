import Foundation

struct RelationProfile: Codable {
    let tiers: [RelationTier]
    var currentTier: Int
    
    func tier() -> RelationTier {
        return tiers[currentTier]
    }
    
    mutating func nextTier(for xp: Int) {
        if tiers[currentTier].threshold < xp {
            self.currentTier = currentTier < tiers.count ? currentTier + 1 : currentTier
        }
    }
}
