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
        static let countdownViewController = "CountdownViewController"
        static let scheduleViewController = "ScheduleViewController"
        static let goalsForDayViewController = "GoalsForDayViewController"
        static let congratulationsViewController = "CongratulationsViewController"
        static let goalsReviewViewController = "GoalsReviewViewController"
        static let moreViewController = "MoreViewController"
        static let contactsViewController = "ContactsViewController"
    }
    
    struct Colors {
        
        static let gradientYellowTop = UIColor(hexString: "#F6EE66")
        static let gradientYellowBottom = UIColor(hexString: "#FBD66D")
        
        static let gradientGrayTop = UIColor(hexString: "#BEBCBC")
        static let gradientGrayBottom = UIColor(hexString: "#B2B2B2")
        
        static let grayButtonTitleColor = UIColor(hexString: "#8E8D8D")
        static let grayButtonTopColor = UIColor(hexString: "#E5E3E3")
        static let grayButtonBottomColor = UIColor(hexString: "#BEBEBE")
        
        static let mainYellowColor = UIColor(hexString: "#F9E06A")
        static let mainBlueColor = UIColor(hexString: "#545D9E")
        static let warningRedColor = UIColor(hexString: "#FA6060")
        
        // Colors for Stages
        static let focusedWorkBackgroundColor = UIColor(hexString: "#FAE67D")
        static let activeBreakBackgroundColor = UIColor(hexString: "#C3FDE3")
        static let mealBreakBackgroundColor = UIColor(hexString: "#DBEBFF")
        static let stretchingBackgroundColor = UIColor(hexString: "#E6BEE2")
        static let meditationBackgroundColor = UIColor(hexString: "#C9BEE6")
    }
    
    struct Images {
        
        static let goalsButtonDisabled = UIImage(named: "GoalsListGray")!
        
        // Images for Stages
        static let focusedWorkCatImage = UIImage(named: "WorkingCat")!
        static let activeBreakCatImage = UIImage(named: "DancingCat")!
        static let mealBreakCatImage = UIImage(named: "EatingCat")!
        static let stretchingCatImage = UIImage(named: "StretchingCat")!
        static let meditationCatImage = UIImage(named: "MeditatingCat")!
    }
    
    struct ToolTips {
        static let insertGoalsScreenInfoTips =  ["Tip: Prioritize your most urgent and important goals and tasks first (1/2)",
                                                 "But remember to make sure that they are doable within the current session 😺 (2/2)"]
        
        static let insertGoalScreenWarningTip = ["Are you sure? You won’t be able to change them later"]
        
        static let sessionScreenClosingWarningTip = ["Are you sure you want to stop? Tap again to force finish the session"]
        
//         Session Stages
        static let focusedWorkHints = ["Remove all distractions and dive deep into your goals. (1/2)\n",
                                       "Try to finish your most important tasks first. (2/2)\n" ]
        
        static let activeBreakHints = ["There is nothing better than fresh air! Please, use this time for a walk! (1/2)",
                                       "Don’t forget to drink water! It’s important to stay hydrated and fresh. (2/2)"]
        static let mealBreakHints = ["Reward your body with some fuel to recharge yourself. Eat something that makes you happy and refreshed."]
        static let stretchingHints = ["Great time to remember your PE classes and shake your limbs! Don’t be shy! 1..2..3..4"]
        static let meditationHints = ["When the mind is so active, its important to bring it back to a calm and happy place. (1/2)",
                                      "Let’s practice some deep breathing. Close your eyes and inhale... exhale... (2/2)"]
        
        static let reviseGoals = ["It is a great time to revise your goals!"]
        
        static let skipStageWarning = ["Tap again to force finish the stage"]
    }
    
    struct Cells {
        // Cell Names
        static let scheduleCellNibName = "ScheduleCell"
        static let goalCellNibName = "GoalCell"
        
        // Cell Identifiers
        static let scheduleCellIdentifier = "ScheduleCell"
        static let goalCellIdentifier = "GoalCell"
    }
    
    struct Placeholders {
        static let addingGoalPlaceholder = "Ex: Apply to 4 internships"
    }
    
    struct UserDefaultsKey {
        static let hasViewedWalkthrough = "hasViewedWalkthrough"
        
        static let hasOpenedInputGoals = "hasOpenedInputGoals"
        
        static let lastReviewRequestAppVersion = "lastReviewRequestAppVersion"
    }
    
    struct Notifications {
        static let completeStageNotificationTitle = "Yey! Stage completed!"
        static let completeStageNotificationBodyBase = "Next stage is "
        
        static let didNotAllowNotificationsLog = "The user didn't allow notification permissions."
    }
    
    struct Strings {
        
        // Input Goals Screen
        static let alertTitle = "Add a new goal"
        static let alertMessage = "Describe your goal in one easy to understand sentence"
        static let alertAddActionTitle = "Add"
        static let alertCancelActionTitle = "Back"
        
        // Session Screen
        static let nextSession = "Next stage: "
        static let review = "Review"
        static let stageFinishedText = "Stage Finished"
        static let doneButtonText = "Done"
        static let nextButtonText = "Let's go!"
        
        // Congratulations Screen
        static let callToReviewText = "Check the review to evaluate your results!"
        static let noGoalsToReviewText = "Reward yourself with a treat! And rest well until the next time"
        
        static let feedbackEmailSubject = "User Feedback"
    }
    
    struct ExternalLinks {
        static let appStoreProductPageURL = "https://apps.apple.com/us/app/encore-personal-growth/id1548470945"
        static let productURL = URL(string: appStoreProductPageURL)
        static let encoreEmail = "encore.cat.app@gmail.com"
        static let encoreInstaAppLink = "instagram://user?username=encore.app"
        static let encoreInstaWebLink = "https://instagram.com/encore.app"
    }
    
    struct AnalyticsEvents {
        static let notificationPersmission = "Notification_Persmission"
        
        static let sessionStart = "Session_Start"
        static let sessionEnd = "Session_End"
        static let infoPressed = "Info_Pressed"
        static let tutorialPressed = "Tutorial_Pressed"
        static let contactUsPressed = "Contact_Us_Pressed"
        static let shareAppPressed = "Share_Pressed"
        static let writeReviewPressed = "Write_Review_Pressed"
        static let sendFeedbackPressed = "Send_Feedback_Pressed"
        static let openInstaPressed = "Open_Insta_Pressed"
    }
    
    struct AnalyticsParams {
        static let notificationAllowed = "Notification_Allowed"
        static let sessionVolume = "Session_Volume"
        static let goalsCount = "Goals_Count"
        static let stageName = "Stage_Name"
        static let goalsAchievedCount = "Goals_Achived_Count"
        static let percentageOfCompletion = "Percentage_Of_Completion_%"
    }
    
    struct ErrorsMessages {
        static let notificationSchedulingErrorMessage = "An error occured with scheduling notification."
        static let sendingFeedbackErrorMessage = "An error occured during sending email"
    }
}
