//
//  Stage.swift
//  Encore
//
//  Created by Katselenbogen, Igor on 2020/12/24.
//

import UIKit

struct Stage {
    private var stageType: StageType
    
    var name: String
    var durationInSeconds: Int
    
    var durationInMinutes: Int {
        return durationInSeconds / 60
    }
    
    var catImage: UIImage
    var backgroundColor: UIColor
    
    init(name: String, durationInSeconds: Int, stageType: StageType) {
        self.name = name
        self.durationInSeconds = durationInSeconds
        self.stageType = stageType
        
        switch stageType {
        case .focusedWork:
            catImage = K.Images.focusedWorkCatImage
            backgroundColor = K.Colors.focusedWorkBackgroundColor
        case .activeBreak:
            catImage = K.Images.activeBreakCatImage
            backgroundColor = K.Colors.activeBreakBackgroundColor
        case .mealBreak:
            catImage = K.Images.mealBreakCatImage
            backgroundColor = K.Colors.mealBreakBackgroundColor
        case .stretching:
            catImage = K.Images.stretchingCatImage
            backgroundColor = K.Colors.stretchingBackgroundColor
        case .meditation:
            catImage = K.Images.meditationCatImage
            backgroundColor = K.Colors.meditationBackgroundColor
        }
    }
}

enum StageType {
    case focusedWork
    case activeBreak
    case mealBreak
    case stretching
    case meditation
}
