import SwiftUI
import SwiftData

struct TimerView: View {
    @Environment(AppState.self) var appState
    var body: some View {
        VStack {
            AnimationPanel()
            LiveSessionView(manager: appState.sessionManager)
        }
    }
}

