//
//  EncoreButton.swift
//  Encore
//
//  Created by Katselenbogen, Igor on 2020/12/24.
//

import UIKit

// TODO: Level 2 - Export all colors to some constant file
// TODO: Level 2 - We need to apply gradient for the button

@IBDesignable
class EncoreButton: UIButton {
    
    
    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    @IBInspectable
    var isPrimaryButton: Bool = true
    
    private var shadowLayer: CAShapeLayer!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 12).cgPath
            
            if isPrimaryButton {
                shadowLayer.fillColor = UIColor(hexString: "#F9E06A").cgColor
            } else {
                shadowLayer.fillColor = UIColor(hexString: "#545D9E").cgColor
            }
            
            shadowLayer.shadowColor = UIColor.darkGray.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            shadowLayer.shadowOpacity = 0.8
            shadowLayer.shadowRadius = 2
            
            layer.insertSublayer(shadowLayer, at: 0)
        }
    }
}
