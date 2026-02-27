import SwiftUI
import SwiftData

@main
struct WithieStudyApp: App  {
    let container: ModelContainer
    init() {
        do {
            container = try ModelContainer(for:  ProductivitySession.self, SessionType.self)
            SessionInitializer.initialize(container: container)
        } catch {
            fatalError("Failed to initialize SwiftData")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .background(Color("AccentColor"))
        }
        .modelContainer(for: [PastSession.self, SessionType.self, ProductivitySession.self])
    }
}
