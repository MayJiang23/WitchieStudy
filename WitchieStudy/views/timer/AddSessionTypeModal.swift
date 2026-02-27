import SwiftUI

struct AddSessionTypeModal: View {
    @Bindable var manager: LiveSessionManager
    @Environment(\.dismiss) var dismiss
    @State var newSessionType: String = ""
    @State var selectedAction: ThemeAction = .study


    var body: some View {
        NavigationStack {
            VStack {
                Text("Add Session Type")
                TextField("", text: $newSessionType)
                ThemeActionSection(selectedAction: $selectedAction)
            }
            .toolbar {
                ToolbarItem(placement: .destructiveAction) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                    .help("Cancel")
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        let result = manager.sessionTypeManager.addType(title: newSessionType, themeAction: selectedAction)
                        if result == true {
                            print("Added type correctly")
                            dismiss()
                        } else {
                            print("Type title already exists, please choose another title.")
                        }
                    } label: {
                        Image(systemName: "checkmark")
                    }
                    .help("Confirm")
                    .keyboardShortcut(.defaultAction)
                    .disabled(newSessionType.isEmpty)
                }
            }
        }
        .frame(width: 200, height: 200, alignment: .center)
        .padding(10)
    }
}

struct ThemeActionSection: View {
    @Binding var selectedAction: ThemeAction

    var body: some View {
        Text("Tag")
        HStack {
            ForEach(ThemeAction.allCases, id: \.self) { (action: ThemeAction) in
                Button {
                    self.selectedAction = action
                } label: {
                    HStack {
                        Text(action.rawValue)
                            .foregroundStyle(.primary)
                        if selectedAction == action {
                            
                        }
                    }
                }
                .background(selectedAction == action ? Color("AccentColor"): Color.clear)
                .dynamicTypeSize(.xSmall)
            }
        }
    }
}
