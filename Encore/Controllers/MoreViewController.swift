//
//  MoreViewController.swift
//  Encore
//
//  Created by Katselenbogen, Igor | Rogi | MESD on 2021/01/06.
//

import UIKit

class MoreViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tutorialAreaStackView: UIStackView!
    @IBOutlet weak var contactUsAreaStackView: UIStackView!
    @IBOutlet weak var shareAppAreaStackView: UIStackView!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var writeReviewAreaStackView: UIStackView!
    
    // MARK: - Private Variables
    
    private let tutorialGradientLayer = CAGradientLayer()
    private let contactGradientLayer = CAGradientLayer()
    private let shareAppGradientLayer = CAGradientLayer()
    private let writeReviewGradientLayer = CAGradientLayer()

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
        writeReviewGradientLayer.colors = commonColorList
        
        tutorialGradientLayer.frame = tutorialAreaStackView.bounds
        contactGradientLayer.frame = contactUsAreaStackView.bounds
        shareAppGradientLayer.frame = shareAppAreaStackView.bounds
        writeReviewGradientLayer.frame = writeReviewAreaStackView.bounds
        
        tutorialAreaStackView.layer.insertSublayer(tutorialGradientLayer, at: 0)
        contactUsAreaStackView.layer.insertSublayer(contactGradientLayer, at: 0)
        shareAppAreaStackView.layer.insertSublayer(shareAppGradientLayer, at: 0)
        writeReviewAreaStackView.layer.insertSublayer(writeReviewGradientLayer, at: 0)
    }
    
    private func writeReview() {
        var components = URLComponents(url: K.ExternalLinks.productURL!, resolvingAgainstBaseURL: false)
        
        components?.queryItems = [
            URLQueryItem(name: "action", value: "write-review")
        ]
        
        guard let writeReviewURL = components?.url else {
            return
        }
        
        UIApplication.shared.open(writeReviewURL)
    }
    
    private func share() {
        let activityViewController = UIActivityViewController(
            activityItems: [K.ExternalLinks.productURL!],
            applicationActivities: nil)
        
        present(activityViewController, animated: true, completion: nil)
    }
    
    private func setVersionLabel() {
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            self.versionLabel.text = "Version \(version)"
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
    
    @IBAction func contactUsPressed(_ sender: UIButton) {
        AnalyticsManager.logEvent(K.AnalyticsEvents.contactUsPressed)
        goTo(screen: K.StoryBoard.contactsViewController)
    }
    
    @IBAction func shareAppPressed(_ sender: UIButton) {
        AnalyticsManager.logEvent(K.AnalyticsEvents.shareAppPressed)
        share()
    }
    
    @IBAction func writeReviewPressed(_ sender: UIButton) {
        AnalyticsManager.logEvent(K.AnalyticsEvents.writeReviewPressed)
        writeReview()
    }
}
