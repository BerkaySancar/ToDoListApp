//
//  TaskModel.swift
//  ToDoListApp
//
//  Created by Berkay Sancar on 3.06.2022.
//

import Foundation

struct ToDoModel: Codable {
    
    var title: String = ""
    var date: String = ""
    var description: String = ""
    var isCompleted: Bool
    
    init(title: String, date: String, description: String, isCompleted: Bool) {
        self.title = title
        self.date = date
        self.description = description
        self.isCompleted = isCompleted
    }
    
    func updateCompletion() -> ToDoModel {
        return ToDoModel(title: title, date: date, description: description, isCompleted: !isCompleted)
    }
}
