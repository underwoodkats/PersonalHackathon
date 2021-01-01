//
//  Stage.swift
//  Encore
//
//  Created by Katselenbogen, Igor on 2020/12/24.
//

import Foundation

struct Stage {
    var name: String
    var durationInSeconds: Int
    
    var durationStringFormat: String {
        let hours = normilizeTimeValue(durationInSeconds / 3600)
        let minutes = normilizeTimeValue(durationInSeconds / 60 % 60)
        let seconds = normilizeTimeValue(durationInSeconds % 60)
        
        if (Int(hours) == 0) {
            return "\(minutes):\(seconds)"
        } else {
            return "\(hours):\(minutes):\(seconds)"
        }
    }
    
    private func normilizeTimeValue(_ rawTimeUnitValue: Int) -> String {
        if rawTimeUnitValue < 10 {
            let result = "0" + String(rawTimeUnitValue)
            return result
        }
        return String(rawTimeUnitValue)
    }
}
