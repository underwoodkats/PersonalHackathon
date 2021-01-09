//
//  ViewController.swift
//  Encore
//
//  Created by Katselenbogen, Igor on 2020/12/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    // TODO: Level 1 - Think about presentation new screens options! Why it is from the bottom?
    // TODO: Level 1 - Update the design
    
    // MARK: - Life Cycles

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func helpPressed(_ sender: EncoreButton) {
        
        
        let transition = CATransition()
        transition.duration = 0.30
//        transition.type = CATransitionType.reveal
//        transition.type = CATransitionType.push
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromRight
        view.window!.layer.add(transition, forKey: kCATransition)
        
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "HelpViewController") as! HelpViewController
        newViewController.modalPresentationStyle = .fullScreen
        self.present(newViewController, animated: false)
        
    }
}

