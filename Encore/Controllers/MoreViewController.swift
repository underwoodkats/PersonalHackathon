//
//  MoreViewController.swift
//  Encore
//
//  Created by Katselenbogen, Igor | Rogi | MESD on 2021/01/06.
//

import UIKit

class MoreViewController: UIViewController {
    
    // TODO: Level 1 - Send analytics on all actions that are pressed here
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tutorialAreaStackView: UIStackView!
    @IBOutlet weak var contactUsAreaStackView: UIStackView!
    @IBOutlet weak var shareAppAreaStackView: UIStackView!
    @IBOutlet weak var versionLabel: UILabel!
    
    // MARK: - Private Variables
    
    private let tutorialGradientLayer = CAGradientLayer()
    private let contactGradientLayer = CAGradientLayer()
    private let shareAppGradientLayer = CAGradientLayer()

    // MARK: - Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()
        setVersionLabel()
    }
    
    override func viewWillLayoutSubviews() {
        setGradient()
    }
    
    // MARK: - Private Methods
    
    private func setGradient() {
        let colorTop = K.Colors.gradientYellowTop
        let colorBottom = K.Colors.gradientYellowBottom
        
        let commonColorList = [colorTop.cgColor, colorBottom.cgColor]
        
        tutorialGradientLayer.colors = commonColorList
        contactGradientLayer.colors = commonColorList
        shareAppGradientLayer.colors = commonColorList
        
        tutorialGradientLayer.frame = tutorialAreaStackView.bounds
        contactGradientLayer.frame = contactUsAreaStackView.bounds
        shareAppGradientLayer.frame = shareAppAreaStackView.bounds
        
        tutorialAreaStackView.layer.insertSublayer(tutorialGradientLayer, at: 0)
        contactUsAreaStackView.layer.insertSublayer(contactGradientLayer, at: 0)
        shareAppAreaStackView.layer.insertSublayer(shareAppGradientLayer, at: 0)
    }
    
    private func share() {
        let activityViewController = UIActivityViewController(
            activityItems: [K.URLs.productURL!],
            applicationActivities: nil)
        
        present(activityViewController, animated: true, completion: nil)
    }
    
    private func setVersionLabel() {
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            self.versionLabel.text = "Encore \(version)"
        }
    }
    
    // MARK: - IBActions

    @IBAction func backPressed(_ sender: UIButton) {
        goToPreviousScreen()
    }
    
    @IBAction func openTutorialPressed(_ sender: UIButton) {
        AnalyticsManager.logEvent(K.AnalyticsEvents.tutorialPressed)
        
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
    
    @IBAction func shareAppPressed(_ sender: UIButton) {
        AnalyticsManager.logEvent(K.AnalyticsEvents.shareAppPressed)
        share()
    }
    
    @IBAction func contactUsPressed(_ sender: UIButton) {
        goTo(screen: K.StoryBoard.sendFeedbackViewController)
    }
}
