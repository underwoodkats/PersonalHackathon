//
//  Constants.swift
//  Encore
//
//  Created by Katselenbogen, Igor on 2020/12/26.
//

import Foundation

struct K {
    
    struct StoryBoard {
        // Walkthrough
        static let walkthroughStoryBoardName = "Walkthrough"
        
        static let walkthroughFirstContentViewController = "WalkthroughFirstContentViewController"
        static let walkthroughSecondContentViewController = "WalkthroughSecondContentViewController"
        static let walkthroughThirdContentViewController = "WalkthroughThirdContentViewController"
        static let walkthroughFourthContentViewController = "WalkthroughFourthContentViewController"
        
        // Main
        static let mainStoryBoardName = "Main"
        
        static let homeViewController = "HomeViewController"
        static let preparationViewController = "PreparationViewController"
        static let inputGoalsViewController = "InputGoalsViewController"
        static let sessionViewController = "SessionViewController"
        static let scheduleViewController = "ScheduleViewController"
        static let goalsForDayViewController = "GoalsForDayViewController"
        static let congratulationsViewController = "CongratulationsViewController"
        static let goalsReviewViewController = "GoalsReviewViewController"
        static let helpViewController = "HelpViewController"
        static let sendFeedbackViewController = "SendFeedbackViewController"
    }
    
    
    // Cell Names
    static let scheduleCellNibName = "ScheduleCell"
    static let goalCellNibName = "GoalCell"
    
    // Cell Identifiers
    static let scheduleCellIdentifier = "ScheduleCell"
    static let goalCellIdentifier = "GoalCell"
    
    // Segue Names
    static let goalsSegue = "GoalsToSession"
    static let sessionSegue = "SessionToReview"
    
    struct UserDefaultsKey {
        static let hasViewedWalkthrough = "hasViewedWalkthrough"
    }
}
