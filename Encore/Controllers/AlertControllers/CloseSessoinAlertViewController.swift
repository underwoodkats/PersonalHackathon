//
//  CloseSessoinAlertViewController.swift
//  Encore
//
//  Created by Igor Katselenbogen on 2021/04/04.
//

import UIKit

class CloseSessoinAlertViewController: UIViewController {
    
    // MARK: - IBOutlers
    
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var alertContainer: UIView!
    
    // MARK: - Life Cycles

    override func viewWillLayoutSubviews() {
        alertContainer.layer.cornerRadius = Metrics.alertContainerCornerRadius
        
        if let mainString = bodyLabel.text {
            let stringToColor = K.Strings.alertUnderlinedWord
            let range = (mainString as NSString).range(of: stringToColor)

            let mutableAttributedString = NSMutableAttributedString.init(string: mainString)
            mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: K.Colors.alertUnderlinedWordColor, range: range)

            bodyLabel.attributedText = mutableAttributedString
        }
    }
    
    // MARK: - IBActions

    @IBAction func confirmPressed(_ sender: EncoreButton) {
        goToHomeScreen()
    }
    @IBAction func cancelPressed(_ sender: EncoreButton) {
        dismiss(animated: true, completion: nil)
    }
}
