///
/// LiveSessionManager
///
/// - Property:
///     - modelContext
///     - isActive: If a timer is counting down
///     - secondsRemain: A copy of the time remain
///     - currentSession
///     - historyManager: Adds finished session to the history
///     - sessionTypeManager: Gets session type for session configuration.
///
import Foundation
import Combine
import SwiftData

@Observable
class LiveSessionManager {
    private var cancellables = Set<AnyCancellable>()
    
    var modelContext: ModelContext
    var isActive: Bool = false
    var secondsRemain: Int = 1500
    var currentSession: ProductivitySession!
    
    var timer: SessionTimer = SessionTimer()
    var historyManager: SessionHistoryManager
    var sessionTypeManager: SessionTypeManager
    
    
    init(history: SessionHistoryManager, sessionTypes: SessionTypeManager, modelContext: ModelContext) {
        self.historyManager = history
        self.sessionTypeManager = sessionTypes
        self.modelContext = modelContext
        
        timer.$secondsRemain
            .receive(on: RunLoop.main)
            .sink {
                self.secondsRemain = $0
                self.currentSession.secondsRemain = $0
                self.save()
            }
            .store(in: &cancellables)
        
        fetchLiveSession()
    }
    
    func editSession(type: SessionType, durationInSeconds: Int) {
        currentSession.set(startTime: nil, type: type, durationInSeconds: durationInSeconds, secondsRemain: durationInSeconds)
        timer.setTimer(newTime: durationInSeconds)
        secondsRemain = durationInSeconds
        save()
    }
    
    func start() {
        print("Test")
        currentSession.set(startTime: Date.now, type: nil, durationInSeconds: nil, secondsRemain: secondsRemain)
        isActive = true
        timer.resume()
    }
    
    func pauseTimer() {
        isActive = false
        timer.pause()
    }
    
    func resetTimer() {
        timer.setTimer(newTime: currentSession.durationInSeconds)
    }
    
    func finish() {
        pauseTimer()
        
        let actualTimeSpent = Double(currentSession.durationInSeconds - secondsRemain)
        resetTimer()
        
        if actualTimeSpent < 60 { return }
        
        historyManager.addSession(type: currentSession.type, duration: actualTimeSpent, dateCompleted: Date.now, notes: "A productivy time had passed...")
        
        secondsRemain = currentSession.durationInSeconds
    }
    
    private func fetchLiveSession() {
        let descriptor = FetchDescriptor<ProductivitySession>()
        
        do {
            let sessions = try modelContext.fetch(descriptor)
            print(sessions)
            if let existingSession = sessions.first {
                print("Found a session: ", existingSession)
                currentSession = existingSession
                timer.setTimer(newTime: existingSession.durationInSeconds)
                self.secondsRemain = currentSession.secondsRemain
            } else {
                let newSession = ProductivitySession(startTime: Date.now, durationInSeconds: 1500, type: SessionType(title: "Work"), secondsRemain: 1500)
                print("Insert new one")
                modelContext.insert(newSession)
                save()
                currentSession = newSession
                secondsRemain = currentSession.secondsRemain
            }
        } catch {
            print("Fetch failed: \(error.localizedDescription)")
        }
    }
    
    private func save() {
        try? modelContext.save()
    }
    
    
}
