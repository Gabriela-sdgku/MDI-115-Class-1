//
//  ProfileView.swift
//  MDI 114 Class 3 TodoTrackerApp
//
//  Created by SDGKU on 04/11/25.
//

import SwiftUI

struct ProfileView: View {
    
    var appAccentColor: Color
    
    @AppStorage("profileName") private var profileName = "UserName"
    
    @AppStorage("profileTitle") private var profileTitle = "Professor"

    @AppStorage("isDarkMode") private var isDarkMode = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    
                    Image(systemName: "person.crop.circle")
                        .font(.system(size: 120))
                        .foregroundStyle(appAccentColor)
                        .shadow(color: appAccentColor.opacity(0.3), radius: 10, y: 5)
                        .padding(.top, 40)
                    
                    VStack(spacing: 4) {
                        TextField("Your Name", text: $profileName)
                            .font(.largeTitle.weight(.bold))
                            .multilineTextAlignment(.center)
                        

                        TextField("Your Title", text: $profileTitle)
                            .font(.title3)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.bottom, 20)
                    
                    List {
                        Section("Preferences") {

                            Toggle(isOn: $isDarkMode) {
                                Label("Dark Mode", systemImage: isDarkMode ? "moon.fill" : "sun.max.fill")
                            }
                            
                            Label("Settings", systemImage: "gear")
                            Label("Notifications", systemImage: "bell.badge.fill")
                        }
                        
                        Section("Account") {
                            Label("Sign Out", systemImage: "arrow.right.to.line.circle.fill")
                                .foregroundStyle(.red)
                        }
                    }
                    .listStyle(.insetGrouped)
                    .scrollDisabled(true)
                    .frame(height: 280)

                }
                .frame(maxWidth: .infinity)
            }
            .navigationTitle("My Profile")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color(.systemGroupedBackground))
        }
    }
}
