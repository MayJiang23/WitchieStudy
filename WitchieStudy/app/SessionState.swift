import SwiftData

class SessionState {
    var sessionManager: LiveSessionManager
    var report: SessionReportManager

    var modelContext: ModelContext
    
    init(_ modelContext: ModelContext) {
        self.modelContext = modelContext
        self.sessionManager = LiveSessionManager(
            history: SessionHistoryManager(modelContext: modelContext),
            sessionTypes: SessionTypeManager(modelContext: modelContext),
            modelContext: modelContext
        )
        self.report = SessionReportManager(modelContext: modelContext, nil)
        
    }

}
