import Foundation
import SwiftData

/// Holds the static identity data for a character: display name, lore description,
/// and the asset name used to look up their portrait image.

@Model
class StatModule: Module {
    var moduleKey: String = "stat"
    var values: [StatType: Int]
    
    init(values: [StatType: Int]) {
        self.values = values
    }
    
    private func fetchStat() -> StatModule {
        
    }
}

extension StatModule {
    static func createDefault() -> StatModule {
        return StatModule(values: [
            StatType.int: 0,
            StatType.cha: 0,
            StatType.wis: 0,
            StatType.con: 0,
            StatType.str: 0,
            StatType.dex: 0
        ])
    }
}
