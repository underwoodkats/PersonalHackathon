//
//  Int+Extension.swift
//  Encore
//
//  Created by Katselenbogen, Igor on 2021/01/01.
//

import Foundation

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
    
    func stringTimeFormatShort() -> String {
        let hours = self / 3600
        let minutes = self / 60 % 60
        let hoursPart = hours > 0 ? "\(hours)h " : ""
        let minutesPart = minutes > 0 ? "\(minutes)m" : ""
        
        return hoursPart + minutesPart
    }
    
    private func normilizeTimeValue(_ rawTimeUnitValue: Int) -> String {
        if rawTimeUnitValue < 10 {
            let result = "0" + String(rawTimeUnitValue)
            return result
        }
        return String(rawTimeUnitValue)
    }
}
