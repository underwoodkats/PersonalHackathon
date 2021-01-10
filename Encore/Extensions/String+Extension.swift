//
//  String+Extension.swift
//  Encore
//
//  Created by Katselenbogen, Igor on 2020/12/27.
//

import UIKit

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    // Split String into substrings with set length and
    // with a rule that it could be broken only in spaces between words.
    func split(by length: Int) -> [String] {
        var result = [String]()
        let words = self.components(separatedBy: " ")
        var currentCount = 0
        var currentSubstring = ""
        for word in words {
            if currentCount + 1 + word.count > length {
                result.append(currentSubstring)
                currentSubstring = word
                currentCount = word.count
            } else {
                currentCount += word.count
                currentSubstring += " \(word)"
            }
        }
        
        result.append(currentSubstring)
        return result.map { String($0) }
    }
}
