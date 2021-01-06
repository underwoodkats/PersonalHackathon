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
}
