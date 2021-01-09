//
//  SendFeedbackViewController.swift
//  Encore
//
//  Created by Katselenbogen, Igor on 2021/01/09.
//

import UIKit

class SendFeedbackViewController: UIViewController {
    
    // TODO: Level 2 - Firslty disable send button if the text is empty
    // TODO: Level 2 - Fix the problem that a user can't edit the text, but unevitable remove it
    // TODO: Level 2 - Make the button be diasbled for the interaction if the text is not inputted.
    // The thing above could be solved via managing states of the app. So everything is in one place.
    // And we can set the button disabled view in the EncoreButton place.

    @IBOutlet weak var textView: FeedbackTextView!
    @IBOutlet weak var sendButton: EncoreButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        textView.delegate = self
        sendButton.isEnabled = false
    }

    @IBAction func backPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendFeedbackPressed(_ sender: EncoreButton) {
        if let message = textView.text {
            Bugfender.sendUserFeedbackReturningUrl(withSubject: "Feedback", message: message)
            self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
        }
    }
}

extension SendFeedbackViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        textView.textColor = UIColor.black
        // In order to make it work we need to set border width
        textView.layer.borderColor = UIColor.black.cgColor
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.layer.borderColor = UIColor.clear.cgColor
        print("end end")
        if textView.text.isEmpty {
            textView.text = "I encountered a problem with..."
            textView.textColor = UIColor.gray
            sendButton.isEnabled = false
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
            sendButton.isEnabled = true
        }
    }
}
