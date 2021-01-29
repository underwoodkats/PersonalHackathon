//
//  ViewController.swift
//  Encore
//
//  Created by Katselenbogen, Igor on 2020/12/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    let notificationManager = NotificationManager.shared
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notificationManager.requestForPersmission() // Ask for this permission only once
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareModelForNewSession()
    }
    
    private func prepareModelForNewSession() {
        EncoreBrain.shared.prepareNewBrain()
        EncoreBrain.shared.screenWidth = Double(self.view.bounds.width)
    }
    
    // MARK: - IBActions

    @IBAction func startPressed(_ sender: EncoreButton) {
        goTo(screen: K.StoryBoard.preparationViewController)
    }
    
    @IBAction func helpPressed(_ sender: EncoreButton) {
        goTo(screen: K.StoryBoard.helpViewController)
    }
}

