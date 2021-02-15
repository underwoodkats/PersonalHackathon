//
//  Session.swift
//  Encore
//
//  Created by Katselenbogen, Igor on 2020/12/24.
//

import Foundation

// TODO: Level 3 - Make Focused Work counter automatic 1/2, 1/3 etc.

struct Session {
    var stages: [Stage]
}

struct Sessions {
    static let miniSession: Session = Session(stages: [
        Stage(name: "Focused Work 1/3", durationInSeconds: 45*60, stageType: .focusedWork),
        Stage(name: "Active Break", durationInSeconds: 15*60, stageType: .activeBreak),
        Stage(name: "Focused Work 2/3", durationInSeconds: 60*60, stageType: .focusedWork),
        Stage(name: "Small Meal Break", durationInSeconds: 20*60, stageType: .mealBreak),
        Stage(name: "Focused Work 3/3", durationInSeconds: 60*60, stageType: .focusedWork),
    ])
    
    static let halfDaySession: Session = Session(stages: [
        Stage(name: "Focused Work 1/4", durationInSeconds: 45*60, stageType: .focusedWork),
        Stage(name: "Meal Break", durationInSeconds: 50*60, stageType: .mealBreak),
        Stage(name: "Stretching", durationInSeconds: 10*60, stageType: .stretching),
        Stage(name: "Focused Work 2/4", durationInSeconds: 90*60, stageType: .focusedWork),
        Stage(name: "Active Break", durationInSeconds: 20*60, stageType: .activeBreak),
        Stage(name: "Focused Work 3/4", durationInSeconds: 90*60, stageType: .focusedWork),
        Stage(name: "Meditation", durationInSeconds: 10*60, stageType: .meditation),
        Stage(name: "Active Break", durationInSeconds: 10*60, stageType: .activeBreak),
        Stage(name: "Focused Work 4/4", durationInSeconds: 45*60, stageType: .focusedWork),
    ])
    
    static let fullDaySession: Session = Session(stages: [
        Stage(name: "Focused Work 1/6", durationInSeconds: 90*60, stageType: .focusedWork),
        Stage(name: "Active Break", durationInSeconds: 15*60, stageType: .activeBreak),
        Stage(name: "Focused Work 2/6", durationInSeconds: 45*60, stageType: .focusedWork),
        Stage(name: "Meal Break", durationInSeconds: 50*60, stageType: .mealBreak),
        Stage(name: "Stretching", durationInSeconds: 10*60, stageType: .stretching),
        Stage(name: "Focused Work 3/6", durationInSeconds: 90*60, stageType: .focusedWork),
        Stage(name: "Active Break", durationInSeconds: 20*60, stageType: .activeBreak),
        Stage(name: "Focused Work 4/6", durationInSeconds: 90*60, stageType: .focusedWork),
        Stage(name: "Meditation", durationInSeconds: 10*60, stageType: .meditation),
        Stage(name: "Active Break", durationInSeconds: 10*60, stageType: .activeBreak),
        Stage(name: "Focused Work 5/6", durationInSeconds: 90*60, stageType: .focusedWork),
        Stage(name: "Meal Break", durationInSeconds: 50*60, stageType: .mealBreak),
        Stage(name: "Stretching", durationInSeconds: 10*60, stageType: .stretching),
        Stage(name: "Focused Work 6/6", durationInSeconds: 90*60, stageType: .focusedWork),
    ])
}
