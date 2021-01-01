//
//  Int+Extension.swift
//  Encore
//
//  Created by Katselenbogen, Igor | Rogi | MESD on 2021/01/01.
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
    
    private func normilizeTimeValue(_ rawTimeUnitValue: Int) -> String {
        if rawTimeUnitValue < 10 {
            let result = "0" + String(rawTimeUnitValue)
            return result
        }
        return String(rawTimeUnitValue)
    }
}
