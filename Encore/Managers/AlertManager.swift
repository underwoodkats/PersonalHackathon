//
//  AlertManager.swift
//  Encore
//
//  Created by Igor Katselenbogen on 2021/04/04.
//

import UIKit

class AlertManager {
    
    static let shared = AlertManager()
    private init() {}
    
    func getClosingSessionAlert() -> CloseSessoinAlertViewController {
        let storyboard = UIStoryboard(name: K.StoryBoard.mainStoryBoardName, bundle: .main)
        let alertViewController = storyboard.instantiateViewController(withIdentifier: K.StoryBoard.closeSessoinAlertViewController) as! CloseSessoinAlertViewController
        return alertViewController
    }
}
