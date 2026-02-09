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
    
    func resume() {
        isActive = true
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if self.secondsRemain > 0 {
                self.secondsRemain -= 1
            } else {
                self.pause()
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
}


