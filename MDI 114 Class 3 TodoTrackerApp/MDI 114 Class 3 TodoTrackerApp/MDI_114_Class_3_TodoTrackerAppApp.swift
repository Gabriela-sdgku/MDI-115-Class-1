//
//  MDI_114_Class_3_TodoTrackerAppApp.swift
//  MDI 114 Class 3 TodoTrackerApp
//
//  Created by SDGKU on 04/11/25.
//

import SwiftUI

@main
struct MDI_114_Class_3_TodoTrackerAppApp: App {
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
