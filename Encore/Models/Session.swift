//
//  Session.swift
//  Encore
//
//  Created by Katselenbogen, Igor on 2020/12/24.
//

import Foundation

struct Session {
    var stages: [Stage]
}

struct Sessions {
    static let miniSession: Session = Session(stages: [
        Stage(name: "Session Overiview", durationInSeconds: 10*60),
        Stage(name: "Focused Work Cycle 1", durationInSeconds: 45*60),
        Stage(name: "Active Break", durationInSeconds: 15*60),
        Stage(name: "Focused Work Cycle 2", durationInSeconds: 60*60),
        Stage(name: "Small Meal Break", durationInSeconds: 20*60),
        Stage(name: "Focused Work Cycle 3", durationInSeconds: 60*60),
        Stage(name: "Review of accomplishments", durationInSeconds: 10*60)
    ])
    
    static let halfDaySession: Session = Session(stages: [
        Stage(name: "Session Overiview", durationInSeconds: 15*60),
        Stage(name: "Focused Work Cycle 1", durationInSeconds: 45*60),
        Stage(name: "Meal Break", durationInSeconds: 50*60),
        Stage(name: "Stretching", durationInSeconds: 10*60),
        Stage(name: "Focused Work Cycle 2", durationInSeconds: 90*60),
        Stage(name: "Active Break", durationInSeconds: 20*60),
        Stage(name: "Focused work cycle 3", durationInSeconds: 90*60),
        Stage(name: "Focus Exercise", durationInSeconds: 10*60),
        Stage(name: "Active Break", durationInSeconds: 10*60),
        Stage(name: "Focused Work Cycle 4", durationInSeconds: 45*60),
        Stage(name: "Review of accomplishments", durationInSeconds: 10*60)
    ])
    
    static let fullDaySession: Session = Session(stages: [
        Stage(name: "Session Overiview", durationInSeconds: 15*60),
        Stage(name: "Focused Work Cycle 1", durationInSeconds: 90*60),
        Stage(name: "Active Break", durationInSeconds: 15*60),
        Stage(name: "Focused Work Cycle 2", durationInSeconds: 45*60),
        Stage(name: "Meal Break", durationInSeconds: 50*60),
        Stage(name: "Stretching", durationInSeconds: 10*60),
        Stage(name: "Focused work cycle 3", durationInSeconds: 90*60),
        Stage(name: "Active Break", durationInSeconds: 20*60),
        Stage(name: "Focused Work Cycle 4", durationInSeconds: 90*60),
        Stage(name: "Focus Exercise", durationInSeconds: 10*60),
        Stage(name: "Active Break", durationInSeconds: 10*60),
        Stage(name: "Focused Work Cycle 5", durationInSeconds: 90*60),
        Stage(name: "Meal Break", durationInSeconds: 50*60),
        Stage(name: "Stretching", durationInSeconds: 10*60),
        Stage(name: "Focused Work Cycle 6", durationInSeconds: 90*60),
        Stage(name: "Review of Accomplishments", durationInSeconds: 10*60)
    ])
}


// TODO: Think about hint for each stage
// TODO: Think if we can make a screen for basic recommendations


