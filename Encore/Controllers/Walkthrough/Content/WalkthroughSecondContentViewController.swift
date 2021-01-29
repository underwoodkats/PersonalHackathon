//
//  WalkthroughSecondContentViewController.swift
//  Encore
//
//  Created by Katselenbogen, Igor on 2021/01/11.
//

import UIKit

class WalkthroughSecondContentViewController: WalkthroughContentViewController {
    
    @IBOutlet weak var topTitle: UILabel!
    @IBOutlet weak var bottomTitle: UILabel!
    @IBOutlet weak var activityListStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pageIndex = 1
        adjustLabels()
    }
    
    func adjustLabels() {
        let labels = [topTitle, bottomTitle]
        let screenWidth = self.view.bounds.width
        
        if screenWidth >= 414 { // iPhone 11 and others
            labels.forEach { $0?.font = $0?.font.withSize(24) }
            activityListStackView.subviews
                .compactMap { $0 as? UILabel }
                .forEach { $0.font = $0.font.withSize(26) }
            activityListStackView.spacing = 20
        } else {
            labels.forEach { $0?.font = $0?.font.withSize(22) }
            activityListStackView.subviews
                .compactMap { $0 as? UILabel }
                .forEach { $0.font = $0.font.withSize(22) }
            activityListStackView.spacing = 15
        }
    }
}
