//
//  ImportantDTO.swift
//  ToDoListApp
//
//  Created by Khalida Aliyeva on 28.12.24.
//

import Foundation
import RealmSwift

protocol TaskImportantProtocol {
    var title: String {get}
    var task: String {get}
}

class ImportantDTO: Object {
    @Persisted var importantTitle: String
    @Persisted var importantTask: String
    
}

extension ImportantDTO: TaskImportantProtocol {
    var task: String {
        importantTask
    }
    
    var title: String {
        importantTitle
    }
}
