//
//  Int+Extension.swift
//  Encore
//
//  Created by Katselenbogen, Igor on 2021/01/01.
//

import Foundation

// TODO: Level 3 - Think if we want to show hours or we can just show only minutes - like 90:30
// instead of 01:30:30

extension Int {
    func stringTimeFormat() -> String {
        let hours = normilizeTimeValue(self / 3600)
        let minutes = normilizeTimeValue(self / 60 % 60)
        let seconds = normilizeTimeValue(self % 60)
        
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
