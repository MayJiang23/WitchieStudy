import SwiftUI
import SwiftData
import Combine

@main
struct WithieStudyApp: App  {
    let container: ModelContainer
    @State private var appState: AppEngine
    
    init() {
        do {
            PlayerCharacterInitializer.initialize(container: container)
            
            _appState = State(initialValue: AppEngine(modelContext: container.mainContext))
        } catch {
            fatalError("Failed to initialize SwiftData")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .background(Color("AccentColor"))
                .environment(appState)
        }
        .modelContainer(for: [PastSession.self, SessionType.self, ProductivitySession.self, Inventory.self, PlayerCharacter.self, RelationshipState.self])
    }
}
