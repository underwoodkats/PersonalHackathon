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
    var hintsArray: [String]
    
    init(name: String, durationInSeconds: Int, stageType: StageType) {
        self.name = name
        self.durationInSeconds = durationInSeconds
        self.stageType = stageType
        
        switch stageType {
        case .focusedWork:
            catImage = K.Images.focusedWorkCatImage
            backgroundColor = K.Colors.focusedWorkBackgroundColor
            hintsArray = K.ToolTips.focusedWorkHints
        case .activeBreak:
            catImage = K.Images.activeBreakCatImage
            backgroundColor = K.Colors.activeBreakBackgroundColor
            hintsArray = K.ToolTips.activeBreakHints
        case .mealBreak:
            catImage = K.Images.mealBreakCatImage
            backgroundColor = K.Colors.mealBreakBackgroundColor
            hintsArray = K.ToolTips.mealBreakHints
        case .stretching:
            catImage = K.Images.stretchingCatImage
            backgroundColor = K.Colors.stretchingBackgroundColor
            hintsArray = K.ToolTips.stretchingHints
        case .meditation:
            catImage = K.Images.meditationCatImage
            backgroundColor = K.Colors.meditationBackgroundColor
            hintsArray = K.ToolTips.meditationHints
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
