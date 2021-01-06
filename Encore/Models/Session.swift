//
//  Session.swift
//  Encore
//
//  Created by Katselenbogen, Igor on 2020/12/24.
//

import Foundation

// TODO: Level 1 - Make hints for each stages
// TODO: Level 3 - Make Focused Work counter automatic 1/2, 1/3 etc.

struct Session {
    var stages: [Stage]
}

struct Sessions {
    static let miniSession: Session = Session(stages: [
        Stage(name: "Focused Work 1/3", durationInSeconds: 45*60),
        Stage(name: "Active Break", durationInSeconds: 15*60),
        Stage(name: "Focused Work 2/3", durationInSeconds: 60*60),
        Stage(name: "Small Meal Break", durationInSeconds: 20*60),
        Stage(name: "Focused Work 3/3", durationInSeconds: 60*60),
    ])
    
    static let halfDaySession: Session = Session(stages: [
        Stage(name: "Focused Work 1/4", durationInSeconds: 45*60),
        Stage(name: "Meal Break", durationInSeconds: 50*60),
        Stage(name: "Stretching", durationInSeconds: 10*60),
        Stage(name: "Focused Work 2/4", durationInSeconds: 90*60),
        Stage(name: "Active Break", durationInSeconds: 20*60),
        Stage(name: "Focused Work 3/4", durationInSeconds: 90*60),
        Stage(name: "Focus Exercise", durationInSeconds: 10*60),
        Stage(name: "Active Break", durationInSeconds: 10*60),
        Stage(name: "Focused Work 4/4", durationInSeconds: 45*60),
    ])
    
    static let fullDaySession: Session = Session(stages: [
        Stage(name: "Focused Work 1/6", durationInSeconds: 90*60),
        Stage(name: "Active Break", durationInSeconds: 15*60),
        Stage(name: "Focused Work 2/6", durationInSeconds: 45*60),
        Stage(name: "Meal Break", durationInSeconds: 50*60),
        Stage(name: "Stretching", durationInSeconds: 10*60),
        Stage(name: "Focused Work 3/6", durationInSeconds: 90*60),
        Stage(name: "Active Break", durationInSeconds: 20*60),
        Stage(name: "Focused Work 4/6", durationInSeconds: 90*60),
        Stage(name: "Focus Exercise", durationInSeconds: 10*60),
        Stage(name: "Active Break", durationInSeconds: 10*60),
        Stage(name: "Focused Work 5/6", durationInSeconds: 90*60),
        Stage(name: "Meal Break", durationInSeconds: 50*60),
        Stage(name: "Stretching", durationInSeconds: 10*60),
        Stage(name: "Focused Work 6/6", durationInSeconds: 90*60),
    ])
}
