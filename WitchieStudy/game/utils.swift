struct AnyCodable: Codable {
    let value: Encodable & Decodable

    init(_ value: Encodable & Decodable) {
        self.value = value
    }

    func encode(to encoder: Encoder) throws {
        try value.encode(to: encoder)
    }

    init(from decoder: Decoder) throws {
        // Note: Decoding back from JSON into 'any Codable' is complex.
        // For now, we focus on the Saving (Encoding) part.
        fatalError("Decoding any Codable requires a specific strategy.")
    }
}
