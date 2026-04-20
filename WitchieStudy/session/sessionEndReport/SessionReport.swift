import Foundation
import SwiftData

@Model
class SessionReport: Identifiable {
    var activityName: String
    var durationMinutes: Int
    @Transient var events: [any ReportableEvent] = []
    
    init(activityName: String, durationMinutes: Int, events: [any ReportableEvent] = []) {
        self.activityName = activityName
        self.durationMinutes = durationMinutes
        
        self.events = events
    }
    
    func addEvents(_ events: [any ReportableEvent]) {
        self.events = self.events + events
    }
    
}
