//
//  ToolTipManager.swift
//  Encore
//
//  Created by Katselenbogen, Igor on 2021/01/13.
//

import UIKit
import TipSee

class ToolTipManager {
    
    enum ToolTipType {
        case Info
        case Warning
    }
    
    private let window: UIWindow
    
    private var tipManager: TipSeeManager?
    
    private var infoHintToolTipConfiguration: TipSee.Options.Bubble {
        return TipSee.Options.Bubble
            .default()
            .with{
                $0.foregroundColor = .white
                $0.backgroundColor = K.Colors.mainBlueColor
                $0.position = .bottom
            }
    }
    
    private var warningToolTipConfiguration: TipSee.Options.Bubble {
        return TipSee.Options.Bubble
            .default()
            .with{
                $0.foregroundColor = .white
                $0.backgroundColor = K.Colors.warningRedColor
                $0.position = .top
            }
    }
    
    private var defaultTipOption = TipSee.Options
        .default()
        .with {
            $0.dimColor =  UIColor.clear
            $0.bubbleLiveDuration = .untilNext
            $0.dimFading = false
        }
    
    init(on window: UIWindow) {
        self.window = window
    }
    
    func showToolTip(attachTo view: UIView, textArray: [String], toolTipType: ToolTipType) {
        self.tipManager?.finish()
        
        self.tipManager = TipSeeManager(on: self.window, with: self.defaultTipOption)
        let configuration = getConfiguaration(for: toolTipType)
        
        if let tipManager = tipManager {
            if textArray.count > 1 {
                // Multiple Texts ToolTip
                tipManager.add(
                    new: view,
                    texts: textArray,
                    with: configuration)
                {
                    previousButton, nextButton in
                    nextButton.imageView?.contentMode = .scaleAspectFit
                    previousButton.imageView?.contentMode = .scaleAspectFit
                    nextButton.setImage(#imageLiteral(resourceName: "ToolTipRightArrow"), for: .normal)
                    previousButton.setImage(#imageLiteral(resourceName: "ToolTipLeftArrow"), for: .normal)
                    previousButton.tintColor = .white
                    nextButton.tintColor = .white
                }
            } else {
                // One Text ToolTip
                if let text = textArray.first {
                    tipManager.add(new: view, text: text, with: configuration)
                }
            }
            
            tipManager.onDimTap = {[unowned self] _ in
                guard let tipManager = self.tipManager else { return }
                tipManager.finish()
            }
            
            tipManager.next()
        }
      
    }
    
    private func getConfiguaration(for type: ToolTipType) -> TipSee.Options.Bubble {
        switch type {
        case .Info:
            return infoHintToolTipConfiguration
        case .Warning:
            return warningToolTipConfiguration
        }
    }
}
