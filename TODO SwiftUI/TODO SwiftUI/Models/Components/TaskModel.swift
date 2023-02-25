//
//  TaskModel.swift
//  TODO SwiftUI
//
//  Created by Melis on 30. 1. 2023..
//

import Foundation


struct tasks:Identifiable,Hashable{
    let taskName:String
    let taskTime:String
    var hide:Bool=false
    let id=UUID()
    
    init(taskName: String, taskTime: String) {
        self.taskName = taskName
        self.taskTime = taskTime
    }
}
