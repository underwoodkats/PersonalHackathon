//
//  ScreenSizeManager.swift
//  Encore
//
//  Created by Igor Katselenbogen on 2021/02/19.
//

import UIKit

class ScreenSizeManager {
    
    enum ScreenSize: String {
        case small, medium, large
    }
    
    static func getCurrentScreenSize(screenView: UIView) -> ScreenSize {
        let screenWidth = screenView.bounds.width
        if  screenWidth <= 320 {
            return .small
        } else if screenWidth >= 414 { // iPhone 11 and others
            return .large
        } else {
            return .medium
        }
    }
}
