//
//  WithieStudyApp.swift
//  WithieStudy
//
//  Created by Pitten Pant on 1/26/26.
//

import SwiftUI
import SwiftData

@main
struct WithieStudyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [PastSession.self, SessionType.self])
    }
}
