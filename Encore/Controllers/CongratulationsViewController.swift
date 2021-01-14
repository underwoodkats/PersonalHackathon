//
//  CongratulationsViewController.swift
//  Encore
//
//  Created by Katselenbogen, Igor on 2021/01/05.
//

import UIKit

class CongratulationsViewController: UIViewController {
    
    // TODO: Level 1 - Update the design

    // MARK: - IBOutlets
    
    @IBOutlet weak var reviewButton: EncoreButton!
    
    // MARK: - Private Variables
    private let model = EncoreBrain.shared
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Can't go to the review if a user
        // doesn't have any goals
        if model.goalsCount == 0 {
            reviewButton.isHidden = true
        }
    }
    
    // MARK: - IBActions
    
     @IBAction func finishPressed(_ sender: EncoreButton) {
        goToHomeScreen()
    }
    
    @IBAction func reviewPressed(_ sender: EncoreButton) {
        goTo(screen: K.StoryBoard.goalsReviewViewController)
    }
}
