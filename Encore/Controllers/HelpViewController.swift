//
//  HelpViewController.swift
//  Encore
//
//  Created by Katselenbogen, Igor | Rogi | MESD on 2021/01/06.
//

import UIKit

class HelpViewController: UIViewController {
    
    // TODO: Level 1 - Update the design

    // MARK: - Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - IBActions

    @IBAction func backPressed(_ sender: UIButton) {
        goToPreviousScreen()
    }
    
    @IBAction func giveUsFeedbackPressed(_ sender: UIButton) {
        goTo(screen: K.StoryBoard.sendFeedbackViewController)
    }
}
