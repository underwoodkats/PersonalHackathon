//
//  FeedbackTextView.swift
//  Encore
//
//  Created by Katselenbogen, Igor | Rogi | MESD on 2021/01/09.
//

import UIKit

@IBDesignable
class FeedbackTextView: UITextView {
    
    @IBInspectable var cornerRadius: CGFloat = 0
    @IBInspectable var borderWidth: CGFloat = 0
    @IBInspectable var borderColor: UIColor = .clear
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = cornerRadius > 0
        
        self.textContainer.lineFragmentPadding = 10
    }
}
