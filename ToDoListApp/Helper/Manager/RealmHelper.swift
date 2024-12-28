//
//  RealmHelper.swift
//  ToDoListApp
//
//  Created by Khalida Aliyeva on 27.12.24.
//

import Foundation
import RealmSwift

class RealmHelper {
    
    let realm = try! Realm()
    
    func findPath() {
        if let url = realm.configuration.fileURL {
            print(url)
        }
    }
    
    func updateTask(index: Int, text: String) {
        let taskList = fetchTasks()

        do {
            try realm.write {
                taskList[index].task = text
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func saveTask(dtoModel: TaskDTO) {
        do {
            try realm.write {
                realm.add(dtoModel)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchTasks() -> Results<TaskDTO> {
        let taskList = realm.objects(TaskDTO.self)
        return taskList
    }
    
    func fetchImportantTasks() -> Results<ImportantDTO> {
        let taskList = realm.objects(ImportantDTO.self)
        return taskList
    }
    
    func saveImportantTask(dtoModel: ImportantDTO) {
        do {
            try realm.write {
                realm.add(dtoModel)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteTask(index: Int) {
        let taskList = fetchTasks()

        do {
            try realm.write {
                realm.delete(taskList[index])
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteImportantTask(index: Int) {
        let taskList = fetchTasks()

        do {
            try realm.write {
                realm.delete(taskList[index])
            }
            
        } catch {
            print(error.localizedDescription)
        }
    }
}
