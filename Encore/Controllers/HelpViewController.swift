//
//  HelpViewController.swift
//  Encore
//
//  Created by Katselenbogen, Igor | Rogi | MESD on 2021/01/06.
//

import UIKit

class HelpViewController: UIViewController {
    
    // TODO: Level 1 - Make link to the onboarding

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: kCATransition)
        
        dismiss(animated: false)
    }

}
