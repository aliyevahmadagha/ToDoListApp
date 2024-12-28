//
//  HomeModel.swift
//  ToDoListApp
//
//  Created by Khalida Aliyeva on 26.12.24.
//

import Foundation

protocol HomeModelProtocol {
    var imageTitle: String {get}
    var labelTitle: String {get}
}

struct HomeModel {
    var imageName: String
    var labelText: String
}

extension HomeModel: HomeModelProtocol {
    var imageTitle: String {
        imageName
    }
    
    var labelTitle: String {
        labelText
    }
}
