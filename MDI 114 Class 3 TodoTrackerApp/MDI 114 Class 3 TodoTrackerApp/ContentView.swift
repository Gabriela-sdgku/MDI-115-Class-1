//
//  ContentView.swift
//  MDI 114 Class 3 TodoTrackerApp
//
//  Created by SDGKU on 04/11/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selection: SidebarSelection? = nil
    @State private var taskGroups: [TaskGroup] = []
    @State private var columnVisibility: NavigationSplitViewVisibility = .all
    @State private var isManagingGroups = false
    @Environment(\.scenePhase) var scenePhase
    @AppStorage("profileName") private var profileName = "Default Profile"
    
    private var appAccentColor = Color.cyan
    private let taskGroupsKey = "taskGroupsData"
    
    var body: some View {
        
        NavigationSplitView(columnVisibility: $columnVisibility) {
            
            List(selection: $selection) {
                Section {
                    ForEach(taskGroups) { group in
                        NavigationLink(value: SidebarSelection.group(group.id)) {
                            Label(group.title, systemImage: group.symbolName)
                                .padding(.vertical, 4)
                        }
                        .contextMenu {
                            Button("Delete", role: .destructive) {
                                deleteGroup(group)
                            }
                        }
                    }
                } header: {
                    Text("My Tasks")
                        .font(.headline)
                        .foregroundStyle(appAccentColor)
                }

                
                Section("Account") {
                    NavigationLink(value: SidebarSelection.profile) {
                        Label(profileName, systemImage: "person.crop.circle")
                            .padding(.vertical, 4)
                    }
                }
            }
            .listStyle(.sidebar)
            .navigationTitle("My TODO Tracker")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        isManagingGroups = true
                    } label: {
                        Image(systemName: "plus")
                            .font(.headline.weight(.bold))
                            .foregroundStyle(appAccentColor)
                            .padding(6)
                            .background(appAccentColor.opacity(0.15))
                            .clipShape(Circle())
                    }
                }
            }
            
        } detail: {
            
            switch selection {
                
            case .group(let groupID):
                if let index = taskGroups.firstIndex(where: { $0.id == groupID }) {
                    TaskGroupDetailView(group: $taskGroups[index], appAccentColor: appAccentColor)
                } else {
                    ContentUnavailableView(
                        "Group Deleted",
                        systemImage: "nosign",
                        description: Text("The selected group no longer exists. Please select another one."))
                    .foregroundStyle(.secondary)
                }
                
            case .profile:
                ProfileView(appAccentColor: appAccentColor)
                
            case nil:
                ContentUnavailableView(
                    "Welcome",
                    systemImage:"checklist.unchecked",
                    description: Text("Select a group from the side bar to get started"))
                .foregroundStyle(.secondary)
            }
        }
        .sheet(isPresented: $isManagingGroups) {
            ManageGroupsView(groups: $taskGroups, appAccentColor: appAccentColor)
        }
        .tint(appAccentColor)
        .onAppear {
            loadTaskGroups()
        }
        
        .onChange(of: scenePhase) {oldPhase, newPhase in
            switch newPhase {
            case .active:
                print("App is running right now")
                
            case .inactive:
                print("App became inactive")
                
            case .background:
                print("App is in background mode")
                saveTasksGroups()
                
            @unknown default:
                print("Unkown scene")
            }
            
        }
    }
    
    private func deleteGroup(_ group: TaskGroup) {
        if selection == .group(group.id) {
            selection = nil
        }
        taskGroups.removeAll { $0.id == group.id }
    }
    
    private func loadTaskGroups() {
        if let data = UserDefaults.standard.data(forKey: taskGroupsKey) {
            if let decodedGroups = try? JSONDecoder().decode([TaskGroup].self, from: data) {
                self.taskGroups = decodedGroups
                print("Successfully loaded task groups")
                
                if selection == nil, let firstGroup = taskGroups.first {
                    selection = .group(firstGroup.id)
                }
                return
            }
        }
        print("No saved data found")
        self.taskGroups = []
        if let firstGroup = taskGroups.first {
            selection = .group(firstGroup.id
            )
        }
    }
    
    private func saveTasksGroups() {
        if let encodedData = try? JSONEncoder().encode(taskGroups) {
            UserDefaults.standard.set(encodedData, forKey: taskGroupsKey)
            print("Succesfully saved task groups")
            
        } else {
            print("Failed to save groups")
        }
    }
}

//var sampleTaskGroups: [TaskGroup] = [
//    TaskGroup(title: "Homework SDGKU", symbolName: "books.vertical.fill", tasks: [
//        TaskItem(title: "Upload Assigment to Canvas", isCompleted: false),
//        TaskItem(title: "Implement Login View", isCompleted: false)
//    ]),
//    TaskGroup(title: "House Groceries", symbolName: "house.fill", tasks: [
//        TaskItem(title: "Go groceries shopping", isCompleted: true),
//        TaskItem(title: "Buy milk", isCompleted: false),
//        TaskItem(title: "Buy eggs", isCompleted: false)
//    ])
//]
