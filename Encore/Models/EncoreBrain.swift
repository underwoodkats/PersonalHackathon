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
    
    private var currentStageIndex: Int = 0
    
    var stagesCount: Int {
        return currentSession?.stages.count ?? 0
    }
   
    func setSession(_ session: Session) {
        currentSession = session
    }
}

// MARK: - Goals

extension EncoreBrain {
    var goalsCount: Int {
        return goals.count
    }
    
    func addGoal(goal: Goal) {
        goals.append(goal)
    }
    
    func changeGoalStatus(goalIndex: Int) {
        if goalIndex < goalsCount {
            goals[goalIndex].isAchieved = !goals[goalIndex].isAchieved
        }
    }
}

// MARK: - Session

extension EncoreBrain {
    
    func startSession() {
        currentStageIndex = 0
    }
    
    func getCurrentStage() -> Stage? {
        if let session = currentSession {
            return session.stages[currentStageIndex]
        }
        return nil
    }
    
    func getNextStage() -> Stage? {
        if let session = currentSession {
            if currentStageIndex + 1 < stagesCount {
                return session.stages[currentStageIndex + 1]
            }
        }
        return nil
    }
    
    func goToNextStageIfPossible() -> Bool {
        if currentStageIndex < stagesCount - 1 {
            currentStageIndex += 1
            return true
        } else {
            return false
        }
    }
}
