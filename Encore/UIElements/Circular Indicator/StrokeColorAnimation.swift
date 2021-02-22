//
//  StrokeColorAnimation.swift
//  Encore
//
//  Created by Igor Katselenbogen on 2021/02/19.
//

import UIKit

class StrokeColorAnimation: CAKeyframeAnimation {
    
    // MARK: - Initialization
    
    override init() {
        super.init()
    }
    
    init(colors: [CGColor], duration: Double) {
        
        super.init()
        
        self.keyPath = "strokeColor"
        self.values = colors
        self.duration = duration
        self.repeatCount = .greatestFiniteMagnitude
        self.timingFunction = .init(name: .easeInEaseOut)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
