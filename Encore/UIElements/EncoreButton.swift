//
//  EncoreButton.swift
//  Encore
//
//  Created by Katselenbogen, Igor on 2020/12/24.
//

import UIKit

// TODO: Level 2 - We need to apply gradient for the button

@IBDesignable
class EncoreButton: UIButton {
    
    private var gradientLayer = CAGradientLayer()
    
    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBInspectable
    var isPrimaryButton: Bool = true

    func setGradientBackground() {
        
        var colorTop: UIColor
        var colorBottom: UIColor
        
        if isPrimaryButton {
            colorTop = UIColor(hexString: "#F6EE66")
            colorBottom = UIColor(hexString: "#FBD66D")
        } else {
            colorTop = K.Colors.mainBlueColor
            colorBottom = K.Colors.mainBlueColor
        }
        
        

        gradientLayer.colors = [colorTop.cgColor, colorBottom.cgColor]
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = 16
        self.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 2
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.masksToBounds = false

        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()

            DispatchQueue.main.async {
                self.setGradientBackground()
        }
    }
}

