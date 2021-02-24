//
//  AnalyticsManager.swift
//  Encore
//
//  Created by Igor Katselenbogen on 2021/02/23.
//

import Foundation
import Flurry_iOS_SDK

class AnalyticsManager {
    
    static func logEvent(_ eventName: String, _ eventParams: [String:Any]) {
        Flurry.logEvent(eventName, withParameters: eventParams)
    }
    
    static func logEvent(_ eventName: String) {
        Flurry.logEvent(eventName)
    }
}
