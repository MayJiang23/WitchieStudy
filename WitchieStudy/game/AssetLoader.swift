import Foundation

struct AssetLoader {
    static func loadJson<T: Decodable>(filename: String, as type: T.Type = T.self) -> T? {
        let nameOnly = (filename as NSString).lastPathComponent
        
        guard let url = Bundle.main.url(forResource: nameOnly, withExtension: "json") else {
            print("App literally cannot find any file named \(nameOnly).json")
            return nil
        }
        
        //print("Success! Bundle found file at: \(url.path)")
        
        let data = try? Data(contentsOf: url)
        return try? JSONDecoder().decode(T.self, from: data!)
    }
}
