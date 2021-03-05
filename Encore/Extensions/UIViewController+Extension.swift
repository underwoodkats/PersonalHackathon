//
//  UIViewController+Extension.swift
//  Encore
//
//  Created by Katselenbogen, Igor on 2021/01/09.
//

import UIKit

extension UIViewController {
    
    @objc func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:    #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func goTo(screen name: String, isFading: Bool = false, fromLeft: Bool = false) {
        let transition = CATransition()
        transition.duration = 0.30
        transition.type = isFading ? CATransitionType.fade : CATransitionType.moveIn
        transition.subtype = fromLeft ? CATransitionSubtype.fromLeft : CATransitionSubtype.fromRight
        view.window!.layer.add(transition, forKey: kCATransition)
        
        let storyBoard: UIStoryboard = UIStoryboard(name: K.StoryBoard.mainStoryBoardName, bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: name)
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: false)
    }
    
    func goToPreviousScreen(fromRight: Bool = false) {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.reveal
        transition.subtype = fromRight ? CATransitionSubtype.fromRight : CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: kCATransition)
        
        dismiss(animated: false)
    }
    
    func goToHomeScreen() {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: kCATransition)
        
        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
    }
}
