//
//  EncoreBrain.swift
//  Encore
//
//  Created by Katselenbogen, Igor on 2020/12/24.
//

import Foundation

class EncoreBrain {
    static let shared = EncoreBrain()
    private init() {}
    
    private(set) var currentSession: Session?
    private(set) var goals: [Goal] = []
    
    var stagesCount: Int {
        return currentSession?.stages.count ?? 0
    }
    
    var goalsCount: Int {
        return goals.count
    }
    
    func setSession(_ session: Session) {
        currentSession = session
    }
    
    func addGoal(goal: Goal) {
        goals.append(goal)
    }
}
