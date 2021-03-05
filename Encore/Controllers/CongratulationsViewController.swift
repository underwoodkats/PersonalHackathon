//
//  CongratulationsViewController.swift
//  Encore
//
//  Created by Katselenbogen, Igor on 2021/01/05.
//

import UIKit

class CongratulationsViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var reviewButton: EncoreButton!
    @IBOutlet weak var callToActionLabel: UILabel!
    
    // MARK: - Private Variables
    private let model = EncoreBrain.shared
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adjustUI()
        sendAnalytics()
    }
    
    // MARK: - Private Methods
    
    private func adjustUI() {
        // Can't go to the review if a user
        // doesn't have any goals
        if model.goalsCount == 0 {
            reviewButton.isHidden = true
            callToActionLabel.text = K.Strings.noGoalsToReviewText
        } else {
            callToActionLabel.text = K.Strings.callToReviewText
        }
    }
    
    private func sendAnalytics() {
        let eventName = K.AnalyticsEvents.sessionEnd
        let sessionVolume = model.currentSession?.stages.count ?? 0
        let goalsCount = model.goals.count
        let goalsAchiviedCount = model.getGoalsAchivedCount()
        
        var eventParams = [K.AnalyticsParams.sessionVolume: sessionVolume, K.AnalyticsParams.goalsCount: goalsCount, K.AnalyticsParams.goalsAchievedCount: goalsAchiviedCount]
        
        if goalsCount != 0 {
            let percentageOfCompletion = Int(Double(goalsAchiviedCount) / Double(goalsCount) * 100)
            eventParams[K.AnalyticsParams.percentageOfCompletion] = percentageOfCompletion
        }
        
        AnalyticsManager.logEvent(eventName, eventParams)
    }
    
    // MARK: - IBActions
    
     @IBAction func finishPressed(_ sender: EncoreButton) {
        AppStoreReviewManager.requestReviewIfAppropriate()
        goToHomeScreen()
    }
    
    @IBAction func reviewPressed(_ sender: EncoreButton) {
        goTo(screen: K.StoryBoard.goalsReviewViewController)
    }
}
