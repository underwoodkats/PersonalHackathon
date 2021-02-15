//
//  WalkthroughViewController.swift
//  Encore
//
//  Created by Katselenbogen, Igor on 2021/01/10.
//

import UIKit

class WalkthroughViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet var pageControl: UIPageControl!
    
    @IBOutlet var nextButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet var skipButton: UIButton!
    @IBOutlet weak var startButton: EncoreButton!
    
    // MARK: - Public Properties
    
    var walkthroughPageViewController: WalkthroughPageViewController?
    
    // MARK: - IBActions
    
    @IBAction func skipButtonPressed(sender: UIButton) {
        finishWalkthroughPresentation()
    }
    
    @IBAction func startButtonPressed(_ sender: Any) {
        finishWalkthroughPresentation()
    }
    
    @IBAction func nextButtonPressed(sender: UIButton) {
        walkthroughPageViewController?.forwardPage()
        updateUI()
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        walkthroughPageViewController?.backwardPage()
        updateUI()
    }
    
    // MARK: - Private Methods

    private func updateUI() {
        if let index = walkthroughPageViewController?.currentIndex {
            switch index {
            case 0:
                nextButton.isHidden = false
                backButton.isHidden = true
                
                skipButton.isHidden = false
                startButton.isHidden = true
            case 1...2:
                nextButton.isHidden = false
                backButton.isHidden = false
                
                skipButton.isHidden = false
                startButton.isHidden = true
            case 3:
                nextButton.isHidden = true
                backButton.isHidden = false
                
                skipButton.isHidden = true
                startButton.isHidden = false
            default:
                break
            }
            
            pageControl.currentPage = index
        }
    }
    
    private func finishWalkthroughPresentation() {
        setDefaultsKey()
        openHomeScreen()
    }
    
    private func openHomeScreen() {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: kCATransition)
        
        let storyboard = UIStoryboard(name: K.StoryBoard.mainStoryBoardName, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: K.StoryBoard.homeViewController)
        UIApplication.shared.windows.first?.rootViewController = viewController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    private func setDefaultsKey() {
        UserDefaults.standard.set(true, forKey: K.UserDefaultsKey.hasViewedWalkthrough)
    }
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    override func viewDidLayoutSubviews() {
        // Making page control dots bigger
        pageControl.subviews.forEach {
            $0.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        if let pageViewController = destination as? WalkthroughPageViewController {
            walkthroughPageViewController = pageViewController
            walkthroughPageViewController?.walkthroughDelegate = self
        }
    }
}

extension WalkthroughViewController: WalkthroughPageViewControllerDelegate {
    func didUpdatePageIndex(currentIndex: Int) {
        updateUI()
    }
}
