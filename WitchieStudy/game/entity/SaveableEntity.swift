protocol SaveableEntity {
    var entityId: String { get }
    func captureSnapshot() -> AnyCodable
}
