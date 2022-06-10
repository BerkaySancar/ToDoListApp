//
//  ToDoViewModel.swift
//  ToDoListApp
//
//  Created by Berkay Sancar on 6.06.2022.
//
import Foundation

class ToDoViewModel {
    
    var items: [ToDoModel] = [] {
        didSet {
            saveToDo()
        }
    }
    
    init() {
        getItems()
    }
    
    func getItems() {
        guard
            let data = UserDefaults.standard.data(forKey: "ToDoList"),
            let savedToDos = try? JSONDecoder().decode([ToDoModel].self, from: data)
        else { return }
        
        self.items = savedToDos
    }
    
    func addToDo(title: String, date: String, description: String) {
        let newToDo = ToDoModel(title: title, date: date, description: description, isCompleted: false)
        items.append(newToDo)
    
    }
    // incele detailsVC de kullanabilirsin...
    func updateToDo(item: ToDoModel) {
        if let index = items.firstIndex(where: {$0.title == item.title}) {
            items[index] = item.updateCompletion()
        }
    }
    func saveToDo() {
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: "ToDoList")
        }
    }
    
}
