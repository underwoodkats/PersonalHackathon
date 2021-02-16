//
//  AppStoreReviewManager.swift
//  Encore
//
//  Created by Igor Katselenbogen on 2021/02/15.
//

import StoreKit

enum AppStoreReviewManager {
    
    static func requestReviewIfAppropriate() {
        
        let defaults = UserDefaults.standard
        let bundle = Bundle.main
        
        let bundleVersionKey = kCFBundleVersionKey as String
        let currentVersion = bundle.object(forInfoDictionaryKey: bundleVersionKey) as? String
        let lastVersion = defaults.string(forKey: K.UserDefaultsKey.lastReviewRequestAppVersion)
        
        guard lastVersion == nil || lastVersion != currentVersion else {
            return
        }
        
        SKStoreReviewController.requestReview()
        
        defaults.set(currentVersion, forKey: K.UserDefaultsKey.lastReviewRequestAppVersion)
    }
}
