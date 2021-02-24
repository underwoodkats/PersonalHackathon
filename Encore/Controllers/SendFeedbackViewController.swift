//
//  SendFeedbackViewController.swift
//  Encore
//
//  Created by Katselenbogen, Igor on 2021/01/09.
//

import UIKit

class SendFeedbackViewController: UIViewController {
    
    // TODO: Level 2 - Fix the problem that a user can't edit the text, but unevitable remove it
    // TODO: Level 1 - This screen will be removed completely 
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var frameView: UIView!
    @IBOutlet weak var textView: FeedbackTextView!
    @IBOutlet weak var sendButton: EncoreButton!
    
    // MARK: - Private Variables
    
    private let gradientLayer = CAGradientLayer()
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        textView.delegate = self
        FeedbackTextView.appearance().tintColor = .gray
        disableSendButton()
    }
    
    override func viewWillLayoutSubviews() {
        setGradient()
    }
    
    // MARK: - Private Methods
    
    private func setGradient() {
        let colorTop = K.Colors.gradientYellowTop
        let colorBottom = K.Colors.gradientYellowBottom
        
        gradientLayer.colors = [colorTop.cgColor, colorBottom.cgColor]
        gradientLayer.frame = frameView.bounds
        frameView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func enableSendButton() {
        sendButton.isEnabled = true
        sendButton.isGray = false
    }
    
    private func disableSendButton() {
        sendButton.isEnabled = false
        sendButton.isGray = true
    }
    
    // MARK: - IBActions

    @IBAction func backPressed(_ sender: UIButton) {
        goToPreviousScreen()
    }
    
    @IBAction func sendFeedbackPressed(_ sender: EncoreButton) {
        if let message = textView.text {
            goToHomeScreen()
        }
    }
}

extension SendFeedbackViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        textView.textColor = K.Colors.mainBlueColor
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.layer.borderColor = UIColor.clear.cgColor
        if textView.text.isEmpty {
            textView.text = "I feel it would be interesting if the app..."
            textView.textColor = UIColor.lightGray
            disableSendButton()
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
          if text == "\n" {
              textView.resignFirstResponder()
              return false
          } // Recognizes enter key in keyboard
          return true
      }
    
    func textViewDidChange(_ textView: UITextView) {
        if !textView.text.isEmpty {
            enableSendButton()
        } else {
            disableSendButton()
        }
    }
}
