import SwiftData
import Foundation

class SessionInitializer {
    
    static func initialize(container: ModelContainer) {
        bootstrapSessionType(container: container)
        bootstrapLiveSession(container: container)
    }
    
    private static func bootstrapLiveSession(container: ModelContainer) {
        let context = container.mainContext
        let descriptor = FetchDescriptor<ProductivitySession>()
        
        if let count = try? context.fetchCount(descriptor), count == 0 {
            
            if let initialType = getSessionType(container: container) {
                let initialSession = ProductivitySession(
                    startTime: Date.now,
                    durationInSeconds: 1500,
                    type: initialType,
                    secondsRemain: 1500
                )
                context.insert(initialSession)
                try? context.save()
            }
        }
    }
    
    private static func bootstrapSessionType(container: ModelContainer) {
        let context = container.mainContext
        let descriptor = FetchDescriptor<SessionType>()
        if let count = try? context.fetchCount(descriptor), count == 0 {
            let initialType = SessionType(title: "Study", themeAction: ThemeAction.study)
            context.insert(initialType)
        }
    }
    
    private static func getSessionType(container: ModelContainer) -> SessionType? {
        let context = container.mainContext
        let descriptor = FetchDescriptor<SessionType>()
        
        if let type = try? context.fetch(descriptor).first {
            return type
        }
        return nil
    }
}
