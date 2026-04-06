import SwiftUI
import SwiftData

struct LiveSessionView: View {
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.modelContext) var modelContext
    @Bindable var manager: LiveSessionManager

    var body: some View {
        Group {
            TimerDisplay(manager: manager)
                    
            HStack(spacing: 30) {
                if manager.isActive {
                    Button("Pause") { manager.pause() }
                    Button("Stop") { manager.finish() }
                    .tint(.red)
                } else if manager.currentSession.started {
                    Button("Resume") { manager.resume() }
                    Button("Stop") { manager.finish() }
                    .tint(.red)
                } else {
                    Button("Start") { manager.start() }
                }
            }
        }
        .onChange(of: scenePhase) { _, newPhase in
            if newPhase == .background || newPhase == .inactive {
                manager.handleAppExit()
            }
        }
    }
}
