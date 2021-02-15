//
//  AppDelegate.swift
//  Encore
//
//  Created by Katselenbogen, Igor on 2020/12/24.
//

import UIKit
import IQKeyboardManager
@_exported import BugfenderSDK

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let notificationManager = NotificationManager.shared

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setBugfender()
        configureInitialViewController()
        setIQKeyboardManager()
        notificationManager.notificationCenter.delegate = notificationManager
        
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    private func configureInitialViewController() {
        
        let initialViewController: UIViewController
        
        window = UIWindow()

        if UserDefaults.standard.bool(forKey: K.UserDefaultsKey.hasViewedWalkthrough) {
            let storyboard = UIStoryboard(name: K.StoryBoard.mainStoryBoardName, bundle: nil)
            let loginViewController = storyboard.instantiateViewController(withIdentifier: K.StoryBoard.homeViewController)
            initialViewController = loginViewController
        } else {
            let storyboard = UIStoryboard(name: K.StoryBoard.walkthroughStoryBoardName, bundle: nil)
            let onboardingViewController = storyboard.instantiateViewController(withIdentifier: K.StoryBoard.walkthroughViewController)
            initialViewController = onboardingViewController
        }
        
        window?.rootViewController = initialViewController
        window?.makeKeyAndVisible()
    }
    
    private func setBugfender() {
        Bugfender.activateLogger("PUT-YOUR-KEY")
        Bugfender.enableCrashReporting()
//        Bugfender.enableUIEventLogging()
    }
    
    private func setIQKeyboardManager() {
        IQKeyboardManager.shared().isEnabled = true
        IQKeyboardManager.shared().isEnableAutoToolbar = false
    }
}
