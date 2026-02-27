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

@MainActor
@Observable
class LiveSessionManager {
    private var cancellables = Set<AnyCancellable>()
    
    var modelContext: ModelContext
    var isActive: Bool = false
    var secondsRemain: Int = 1500
    var currentSession: ProductivitySession!
    var lastHeartbeat: Date?
    
    var timer: SessionTimer = SessionTimer()
    var historyManager: SessionHistoryManager
    var sessionTypeManager: SessionTypeManager
    
    var timeFormatted: String {
        let minutes = self.secondsRemain / 60
        let seconds = self.secondsRemain % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    
    init(history: SessionHistoryManager, sessionTypes: SessionTypeManager, modelContext: ModelContext) {
        self.historyManager = history
        self.sessionTypeManager = sessionTypes
        self.modelContext = modelContext
        self.fetchLiveSession()
        self.timer.$secondsRemain
            .receive(on: RunLoop.main)
            .sink { [weak self] newValue in
                guard let self = self else { return }
                self.secondsRemain = newValue
                self.currentSession.secondsRemain = newValue
                self.currentSession.lastHeartbeat = Date.now
            }
            .store(in: &cancellables)
    }
    
    func editSession(type: SessionType?, durationInSeconds: Int?) {
        if let type {
            currentSession.set(startTime: nil, type: type, durationInSeconds: nil, secondsRemain: nil, lastHeartbeat: nil)
        }
        
        if let durationInSeconds {
            currentSession.set(startTime: nil, type: nil, durationInSeconds: durationInSeconds, secondsRemain: durationInSeconds, lastHeartbeat: nil)
            timer.setTimer(newTime: durationInSeconds)
            secondsRemain = durationInSeconds
        }
        save()
    }
    
    func start() {
        currentSession.set(startTime: Date.now, type: nil, durationInSeconds: nil, secondsRemain: secondsRemain, lastHeartbeat: Date.now)
        isActive = true
        currentSession.started = true
        timer.resume()
        save()
    }
    
    func resume() {
        isActive = true
        timer.resume()
    }
    
    func pause() {
        isActive = false
        timer.pause()
        save()
    }
    
    func resetTimer() {
        timer.setTimer(newTime: currentSession.durationInSeconds)
    }
    
    func finish() {
        pause()
        isActive = false
        let actualTimeSpent = Double(currentSession.durationInSeconds - secondsRemain)
        resetTimer()
        currentSession.started = false
        if actualTimeSpent < 60 { return }
        
        historyManager.addSession(type: currentSession.type, duration: actualTimeSpent, dateCompleted: Date.now, notes: "A productivy time had passed...")
        
        secondsRemain = currentSession.durationInSeconds
    }
    
    func handleAppExit() {
        print("Should be triggered here")
        currentSession.secondsRemain = self.secondsRemain
        currentSession.lastHeartbeat = Date.now
        save()
    }
    
    private func fetchLiveSession() {
        let descriptor = FetchDescriptor<ProductivitySession>()
        
        do {
            let sessions = try modelContext.fetch(descriptor)
            if let existingSession = sessions.first {
                self.currentSession = existingSession
                
                self.timer.setTimer(newTime: existingSession.secondsRemain)
                self.secondsRemain = currentSession.secondsRemain
            }
        } catch {
            print("Fetch failed: \(error.localizedDescription)")
        }
    }
    
    private func save() {
        try? modelContext.save()
    }
}
