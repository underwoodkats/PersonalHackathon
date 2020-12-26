//
//  ModeButton.swift
//  Encore
//
//  Created by Katselenbogen, Igor on 2020/12/26.
//

import UIKit

@IBDesignable
class ModeButton: UIButton {
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = self.bounds.height / 2
        layer.masksToBounds = true
    }
}
