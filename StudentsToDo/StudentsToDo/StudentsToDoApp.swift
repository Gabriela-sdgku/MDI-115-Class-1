//
//  StudentsToDoApp.swift
//  StudentsToDo
//
//  Created by Gabriela Sanchez on 10/11/25.
//

import SwiftUI

@main
struct StudentsToDoApp: App {
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
