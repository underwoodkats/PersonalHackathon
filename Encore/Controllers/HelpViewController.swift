//
//  HelpViewController.swift
//  Encore
//
//  Created by Katselenbogen, Igor | Rogi | MESD on 2021/01/06.
//

import UIKit

class HelpViewController: UIViewController {
    
    @IBOutlet weak var tutorialAreaStackView: UIStackView!
    @IBOutlet weak var feedbackAreaStackView: UIStackView!
    let tutorialGradientLayer = CAGradientLayer()
    let feedbackGradientLayer = CAGradientLayer()


    // MARK: - Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - IBActions

    @IBAction func backPressed(_ sender: UIButton) {
        goToPreviousScreen()
    }
    
    override func viewWillLayoutSubviews() {
        setGradient()
    }
    
    private func setGradient() {
        let colorTop = K.Colors.gradientYellowTop
        let colorBottom = K.Colors.gradientYellowBottom
        
        tutorialGradientLayer.colors = [colorTop.cgColor, colorBottom.cgColor]
        feedbackGradientLayer.colors = [colorTop.cgColor, colorBottom.cgColor]
        
        tutorialGradientLayer.frame = tutorialAreaStackView.bounds
        feedbackGradientLayer.frame = feedbackAreaStackView.bounds
        
        tutorialAreaStackView.layer.insertSublayer(tutorialGradientLayer, at: 0)
        feedbackAreaStackView.layer.insertSublayer(feedbackGradientLayer, at: 0)
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
