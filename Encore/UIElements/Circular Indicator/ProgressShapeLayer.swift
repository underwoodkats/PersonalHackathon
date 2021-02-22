//
//  ProgressShapeLayer.swift
//  Encore
//
//  Created by Igor Katselenbogen on 2021/02/18.
//

import UIKit

class ProgressShapeLayer: CAShapeLayer {
    
    // MARK: - Initialization
    
    public init(strokeColor: UIColor, lineWidth: CGFloat) {
        super.init()
        
        self.strokeColor = strokeColor.cgColor
        self.lineWidth = lineWidth
        self.fillColor = UIColor.clear.cgColor
        self.lineCap = .round
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
