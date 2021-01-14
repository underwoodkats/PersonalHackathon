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
    
    @IBAction func openTutorialPressed(_ sender: UIButton) {
        let transition = CATransition()
        transition.duration = 0.30
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromRight
        view.window!.layer.add(transition, forKey: kCATransition)
        
        let storyboard = UIStoryboard(name: K.StoryBoard.walkthroughStoryBoardName, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: K.StoryBoard.walkthroughViewController)
        UIApplication.shared.windows.first?.rootViewController = viewController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    @IBAction func giveUsFeedbackPressed(_ sender: UIButton) {
        goTo(screen: K.StoryBoard.sendFeedbackViewController)
    }
}
