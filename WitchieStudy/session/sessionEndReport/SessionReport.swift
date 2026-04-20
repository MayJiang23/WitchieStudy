import Foundation
import SwiftData

@Model
class SessionReport: Identifiable {
    var activityName: String
    var durationMinutes: Int
    var events: Array<ReportableEvent>
    
    init(activityName: String, durationMinutes: Int, evnts: Array<ReportableEvent> = []) {
        self.activityName = activityName
        self.durationMinutes = durationMinutes
        
        self.events = events
    }
    
    func addEvents(_ events: Array<ReportableEvent>) {
        self.events = self.events + events
    }
    
}
