//
//  TaskDTO.swift
//  ToDoListApp
//
//  Created by Khalida Aliyeva on 27.12.24.
//

import Foundation
import RealmSwift

protocol TaskModelProtocol {
    var titleOfTask: String {get}
    var exercise: String {get}
}

class TaskDTO: Object {
    @Persisted var title: String
    @Persisted var task: String
}

extension TaskDTO: TaskModelProtocol {
    var titleOfTask: String {
        title
    }
    
    var exercise: String {
        task
    }
}
