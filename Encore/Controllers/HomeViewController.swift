//
//  ViewController.swift
//  Encore
//
//  Created by Katselenbogen, Igor on 2020/12/24.
//

import UIKit

class HomeViewController: UIViewController {
    // TODO: Level 1 - Update the design
    
    // MARK: - Life Cycles

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - IBActions

    @IBAction func startPressed(_ sender: EncoreButton) {
        goTo(screen: K.StoryBoard.preparationViewController)
    }
    
    @IBAction func helpPressed(_ sender: EncoreButton) {
        goTo(screen: K.StoryBoard.helpViewController)
    }
}

