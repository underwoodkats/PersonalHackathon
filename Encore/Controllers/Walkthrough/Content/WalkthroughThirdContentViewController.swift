//
//  WalkthroughThirdContentViewController.swift
//  Encore
//
//  Created by Katselenbogen, Igor on 2021/01/11.
//

import UIKit

class WalkthroughThirdContentViewController: WalkthroughContentViewController {
    
    @IBOutlet weak var screenTitle: UILabel!
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var midLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
    @IBOutlet weak var miniEncoreLabel: UILabel!
    @IBOutlet weak var halfEncoreLabel: UILabel!
    @IBOutlet weak var fullEncoreLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pageIndex = 2
        adjustLabels()
    }
    
    func adjustLabels() {
        let labels = [topLabel, midLabel, bottomLabel]
        let sessionLables = [miniEncoreLabel, halfEncoreLabel, fullEncoreLabel]
        print("POC - width \(self.view.bounds.width)")
        let screenWidth = self.view.bounds.width
        // Adjust sizes if the screen is small
        // 320 is the size of iPhone SE first generation
        if  screenWidth <= 320 {
            screenTitle.font = screenTitle.font.withSize(16)
            labels.forEach { $0?.font = $0?.font.withSize(15) }
            sessionLables.forEach { $0?.font = $0?.font.withSize(13) }
//            topLabel.font = topLabel.font.withSize(10)
        } else if screenWidth >= 414 { // iPhone 11 and others
            screenTitle.font = screenTitle.font.withSize(24)
            labels.forEach { $0?.font = $0?.font.withSize(22) }
            sessionLables.forEach { $0?.font = $0?.font.withSize(16) }
        } else {
            screenTitle.font = screenTitle.font.withSize(22)
            labels.forEach { $0?.font = $0?.font.withSize(20) }
            sessionLables.forEach { $0?.font = $0?.font.withSize(16) }
        }
        
//        414 11
        
    }
}
