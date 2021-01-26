//
//  ScheduleViewCell.swift
//  Encore
//
//  Created by Katselenbogen, Igor on 2020/12/26.
//

import UIKit

class ScheduleCell: UITableViewCell {

    @IBOutlet weak var stageLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var cellContentView: UIView!
    
    let gradientLayer = CAGradientLayer()
    var isCompleted: Bool = false

    override func layoutSubviews() {
        setGradientView()
    }
    
    func setGradientView() {
        
        var colorTop: UIColor
        var colorBottom: UIColor
        
        if !isCompleted {
            colorTop = K.Colors.gradientYellowTop
            colorBottom = K.Colors.gradientYellowBottom
        } else {
            colorTop = K.Colors.gradientGrayTop
            colorBottom = K.Colors.gradientGrayBottom
        }
        
        gradientLayer.colors = [colorTop.cgColor, colorBottom.cgColor]
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func representStageAsCompleted() {
        isCompleted = true
        stageLabel.textColor = UIColor.white
        timeLabel.textColor = UIColor.white
    }
}
