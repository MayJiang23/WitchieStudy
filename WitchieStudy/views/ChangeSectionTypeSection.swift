import SwiftUI


struct ChangeSectionTypeSection: View {
    @Environment(\.dismiss) var dismiss
    @Bindable var manager: LiveSessionManager
    
    var body: some View {
        Section("Change Session Type") {
            let allTypes = manager.sessionTypeManager.allTypes
            let currentType = manager.currentSession.type

            ForEach(allTypes) { type in
                Button {
                    manager.editSession(type: type, durationInSeconds: nil)
                    dismiss()
                } label: {
                    HStack {
                        Text(type.title)
                            .foregroundStyle(.primary)
                        Spacer()
                        if currentType == type {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
        }    }
}
