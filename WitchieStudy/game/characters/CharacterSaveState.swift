struct CharacterSaveState: Codable {
    let id: String
    let moduleData: [String: AnyCodable]
}
