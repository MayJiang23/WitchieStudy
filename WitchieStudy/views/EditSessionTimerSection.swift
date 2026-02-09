import SwiftUI

struct EditSessionTimerSection: View {
    @Bindable var manager: LiveSessionManager
    
    var body: some View {
        Section("Edit Duration") {
            HStack {
                Stepper(value: Binding(
                    get: { manager.secondsRemain / 3600 },
                    set: { newHours in
                        let minutes = (manager.secondsRemain % 3600) / 60
                        manager.secondsRemain = (newHours * 3600) + (minutes * 60)
                    }
                ), in: 0...23) {
                    HStack {
                        Text("Hours")
                        Spacer()
                        Text("\(manager.secondsRemain / 3600)")
                            .monospacedDigit()
                            .foregroundStyle(.secondary)
                    }
                }
                
                Stepper(value: Binding(
                    get: { (manager.secondsRemain % 3600) / 60 },
                    set: { newMinutes in
                        let hours = manager.secondsRemain / 3600
                        manager.secondsRemain = (hours * 3600) + (newMinutes * 60)
                    }
                ), in: 0...59) {
                    HStack {
                        Text("Minutes")
                        Spacer()
                        Text("\((manager.secondsRemain % 3600) / 60)")
                            .monospacedDigit()
                            .foregroundStyle(.secondary)
                    }
                }
            }
            
        }
    }
}
