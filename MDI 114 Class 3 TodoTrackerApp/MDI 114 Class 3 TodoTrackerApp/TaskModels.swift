//
//  TaskModels.swift
//  TodoAppTask
//
//  Created by SDGKU on 01/11/25.
//

import Foundation
struct TaskItem: Identifiable, Hashable, Codable {
    let id: UUID
    var title: String
    var isCompleted: Bool = false
    
    init(id: UUID = UUID(), title: String, isCompleted: Bool = false) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
}

struct TaskGroup: Identifiable, Hashable, Codable {
    let id: UUID
    var title: String
    var symbolName: String
    var tasks: [TaskItem]
    
    init(id: UUID = UUID(), title:String, symbolName:String, tasks:[TaskItem]) {
        self.id = id
        self.title = title
        self.symbolName = symbolName
        self.tasks = tasks
    }
}

enum SidebarSelection: Hashable {
    case group(TaskGroup.ID)
    case profile
}
