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
    
    func prepareNewBrain() {
        currentSession = nil
        goals = []
        currentStageIndex = 0
    }
}

// MARK: - Goals

extension EncoreBrain {
    var goalsCount: Int {
        return goals.count
    }
    
    func getGoal(by id: Int) -> Goal? {
        return goals.filter{ $0.goalId == id }.first
    }
    
    func getGoalPosition(by goalId: Int) -> Int? {
        let index = goals.firstIndex(where: { $0.goalId == goalId } )
        if let index = index {
            return index
        }
        return nil
    }
    
    func generateGoalId() -> Int {
        // Since we just incrementing the id from zero,
        // goals count could work just fine
        return goals.count
    }
    
    // In order to acheive correct representation on Goals Screens
    // We introduce new object - Goal Part. Each goal is splitted in a few (or only one)
    // parts with some maximum length. Each part is related to only one goal.
    private var goalsParts: [GoalPart] {
        var result = [GoalPart]()
        goals.forEach { goal in
            let substrings = goal.name.split(by: 17)
            for (index, substring) in substrings.enumerated() {
                result.append(GoalPart(goalId: goal.goalId, text: substring, isFirstPart: index == 0))
            }
        }
        return result
    }
    
    func getGoalPart(index: Int) -> GoalPart? {
        if index < totalGoalsPartsCount {
            return goalsParts[index]
        }
        return nil
    }
    
    var totalGoalsPartsCount: Int {
        return goalsParts.count
    }
    
    func addGoal(goal: Goal) {
        goals.append(goal)
    }
    
    func changeGoalStatus(id: Int) {
        goals.filter{ $0.goalId == id }.first?.changeStatus()
    }
    
    func sortGoals() {
        goals.sort(by: { $0.isAchieved && !$1.isAchieved})
    }
    
    func removeGoal(by goalPartPosition: Int) {
        let targetGoalPart = goalsParts[goalPartPosition]
        let targetGoalId = targetGoalPart.goalId
        if let targetIndex = goals.firstIndex(where: { $0.goalId == targetGoalId }) {
            goals.remove(at: targetIndex)
        }
    }
}

// MARK: - Session

extension EncoreBrain {
    
    var stagesCount: Int {
        return currentSession?.stages.count ?? 0
    }
    
    func setSession(_ session: Session) {
        currentSession = session
    }
    
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
