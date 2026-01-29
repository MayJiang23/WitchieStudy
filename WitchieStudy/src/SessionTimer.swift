//
//  SessionTimer.swift
//  WithieStudy
//
//
import Foundation
import Combine

class SessionTimer {
    @Published var secondsRemain: Int = 1500
    private var timer: Timer?
    
    var isActive = false
    var timeFormatted: String {
        let minutes = self.secondsRemain / 60
        let seconds = self.secondsRemain % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func resume() {
        isActive = true
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if self.secondsRemain > 0 {
                self.secondsRemain -= 1
            } else {
                self.finish()
            }
        }
    }
    
    func pause() {
        isActive = false
        timer?.invalidate()
    }
    
    func setTimer(newTime: Int) {
        secondsRemain = newTime
    }
    
    func finish() {
        pause()
    }
}


