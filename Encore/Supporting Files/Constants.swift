//
//  Constants.swift
//  Encore
//
//  Created by Katselenbogen, Igor on 2020/12/26.
//

import UIKit

struct K {
    
    struct StoryBoard {
        // Walkthrough
        static let walkthroughStoryBoardName = "Walkthrough"
        
        static let walkthroughViewController = "WalkthroughViewController"
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
    
    struct Colors {
        static let mainPurpleColor = UIColor(hexString: "#545D9E")
        static let warningRedColor = UIColor(hexString: "#FA6060")
        
        // Colors for Stages
        static let focusedWorkBackgroundColor = UIColor(hexString: "#FAE67D")
        static let activeBreakBackgroundColor = UIColor(hexString: "#C3FDE3")
        static let mealBreakBackgroundColor = UIColor(hexString: "#DBEBFF")
        static let stretchingBackgroundColor = UIColor(hexString: "#FFBFBF")
        static let meditationBackgroundColor = UIColor(hexString: "#BDA0E2")
    }
    
    struct Images {
        
        // Images for Stages
        static let focusedWorkCatImage = UIImage(named: "WorkingCat")!
        static let activeBreakCatImage = UIImage(named: "DancingCat")!
        static let mealBreakCatImage = UIImage(named: "EatingCat")!
        static let stretchingCatImage = UIImage(named: "Cat")!
        static let meditationCatImage = UIImage(named: "Cat")!
    }
    
    struct ToolTips {
        static let insertGoalsScreenInfoTips =  ["We advice you to set achievable goals.",
                                                 "We recommend splitting goals into smaller ones in order to achieve results."]
        
        static let insertGoalScreenWarningTip = ["Are you sure? You won’t be able to change them later"]
    }
    
    // Cell Names
    static let scheduleCellNibName = "ScheduleCell"
    static let goalCellNibName = "GoalCell"
    
    // Cell Identifiers
    static let scheduleCellIdentifier = "ScheduleCell"
    static let goalCellIdentifier = "GoalCell"
    
    struct Placeholders {
        static let addingGoalPlaceholder = "I want to achieve..."
    }
    
    struct UserDefaultsKey {
        static let hasViewedWalkthrough = "hasViewedWalkthrough"
    }
}
