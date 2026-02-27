//
//  TimerDisplay.swift
//  WitchieStudy
//
//  Created by Pitten Pant on 2/8/26.
//
import SwiftUI

struct TimerDisplay: View {
    @Bindable var manager: LiveSessionManager
    
    @State private var showSessionEdit = false
    
    var body: some View {
        VStack(spacing: 40) {
            Text(manager.currentSession.type.title)
                .font(.headline)
                
            ZStack {
                Circle().stroke(Color.gray.opacity(0.2), lineWidth: 20)
                Circle()
                    .trim(from: 0, to: CGFloat(manager.secondsRemain) / 1500)
                    .stroke(Color.blue, style: StrokeStyle(lineWidth: 20, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .animation(.easeInOut, value: manager.secondsRemain)
                    
                Text(manager.timeFormatted)
                        .font(.system(size: 60, weight: .bold, design: .monospaced))
            }
            .frame(width: 250, height: 250)
            .onTapGesture {
                if !manager.isActive {
                    showSessionEdit = true
                }
            }
            .sheet(isPresented: $showSessionEdit) {
                EditLiveSessionModal(manager: manager)
            }
        }
    }
}
