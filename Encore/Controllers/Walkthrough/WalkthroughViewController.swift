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
    @IBOutlet var skipButton: UIButton!
    
    // MARK: - Public Properties
    
    var walkthroughPageViewController: WalkthroughPageViewController?
    
    // MARK: - IBActions
    
    @IBAction func skipButtonPressed(sender: UIButton) {
        finishWalkthroughPresentation()
    }
    
    @IBAction func nextButtonPressed(sender: UIButton) {
        if let index = walkthroughPageViewController?.currentIndex {
            switch index {
            case 0...2:
                walkthroughPageViewController?.forwardPage()
            case 3:
               finishWalkthroughPresentation()
            default:
                break
            }
        }
        updateUI()
    }
    
    // MARK: - Private Methods

    private func updateUI() {
        if let index = walkthroughPageViewController?.currentIndex {
            switch index {
            case 0...2:
                nextButton.setTitle("Next", for: .normal)
                skipButton.isHidden = false
            case 3:
                nextButton.setTitle("Start", for: .normal)
                skipButton.isHidden = true
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
