//
//  Goal.swift
//  Encore
//
//  Created by Katselenbogen, Igor on 2020/12/26.
//

import Foundation

class Goal {
    var goalId: Int
    var name: String
    var isAchieved: Bool
    
    init(goalId: Int, name: String, isAchieved: Bool) {
        self.goalId = goalId
        self.name = name
        self.isAchieved = isAchieved
    }
    
    func changeStatus() {
        isAchieved = !isAchieved
    }
}

struct GoalPart {
    var goalId: Int
    var text: String
    var isFirstPart: Bool
}
