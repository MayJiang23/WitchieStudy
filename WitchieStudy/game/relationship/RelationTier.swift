import Foundation

struct RelationTier: Codable {
    let id: UUID
    let title: String
    let threshold: Int
    let description: String
}
