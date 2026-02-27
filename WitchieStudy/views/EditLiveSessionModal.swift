import SwiftUI

struct EditLiveSessionModal: View {
    @Bindable var manager: LiveSessionManager
    @Environment(\.dismiss) var dismiss

    var body: some View {
      
        NavigationStack {
            Form {
                VStack {
                    EditSessionTimerSection(manager: manager)
                    ChangeSectionTypeSection(manager: manager)
                }
            }
            .navigationTitle("Edit Session")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
}
