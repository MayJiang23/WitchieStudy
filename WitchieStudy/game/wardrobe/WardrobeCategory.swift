import Foundation

enum WardrobeCategory: String, CaseIterable {
    case tops = "Tops"
    case bottoms = "Bottoms"
    case accessories = "Accessories"
    case fronthair = "Front Hairs"
    case backhair = "Back Hairs"
    case eyes = "Eyes"
    case mouth = "Mouth"
    case body = "Body"
}

struct ClothingItem: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let category: WardrobeCategory
    let imageName: String
    
    let price: Int
    var isUnlocked: Bool = false
}
