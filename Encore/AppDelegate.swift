//
//  AppDelegate.swift
//  Encore
//
//  Created by Katselenbogen, Igor on 2020/12/24.
//

import UIKit
@_exported import BugfenderSDK

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setBugfender()
        configureInitialViewController()
        return true
    }
    
    private func configureInitialViewController() {
        
        let initialViewController: UIViewController
        
        window = UIWindow()

//        if UserDefaults.standard.bool(forKey: K.UserDefaultsKey.hasViewedWalkthrough) {
//            let storyboard = UIStoryboard(name: K.StoryBoard.mainStoryBoardName, bundle: nil)
//            let loginViewController = storyboard.instantiateViewController(withIdentifier: K.StoryBoard.homeViewController)
//            initialViewController = loginViewController
//        } else {
            let storyboard = UIStoryboard(name: K.StoryBoard.walkthroughStoryBoardName, bundle: nil)
            let onboardingViewController = storyboard.instantiateViewController(withIdentifier: K.StoryBoard.walkthroughViewController)
            initialViewController = onboardingViewController
//        }
        
        window?.rootViewController = initialViewController
        window?.makeKeyAndVisible()
    }
    
    private func setBugfender() {
        Bugfender.activateLogger("FyR8iFCy4n4CvOR7YW2OVffxhZE93oVE")
        Bugfender.enableCrashReporting()
//        Bugfender.enableUIEventLogging()
    }
}

