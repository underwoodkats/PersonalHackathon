//
//  UILabel+Extension.swift
//  Encore
//
//  Created by Igor Katselenbogen on 2021/03/05.
//

import UIKit

extension UILabel {
    
    func strikeThrough(_ isStrikeThrough:Bool) {
        if isStrikeThrough {
            if let lblText = self.text {
                let attributeString =  NSMutableAttributedString(string: lblText)
                attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle,
                                             value: 1.5,
                                             range: NSMakeRange(0,attributeString.length))
                self.attributedText = attributeString
            }
        } else {
            if let attributedStringText = self.attributedText?.string {
                let attributeString =  NSMutableAttributedString(string: attributedStringText)
                attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle,
                                             value: 0,
                                             range: NSMakeRange(0,attributeString.length))
                self.attributedText = attributeString
            }
        }
    }
}
