//
//  ContactsViewController.swift
//  Encore
//
//  Created by Igor Katselenbogen on 2021/02/28.
//

import UIKit
import MessageUI

class ContactsViewController: UIViewController {
    
    // TODO: Level 1 - Remove Feedback Screen
    // TODO: Level 1 - Send analytics on all actions that are pressed here
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Private Methods
    
    private func sendEmail() {
        showMailComposer()
    }
    
    private func showMailComposer() {
        guard MFMailComposeViewController.canSendMail() else {
            // TODO: Level 2 - Add toaster if user can't send email
            // Show alert informing user
            return
        }
        
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients([K.ExternalLinks.encoreEmail]) // Please fix it later
        composer.setSubject(K.Strings.feedbackEmailSubject)
        
        present(composer, animated: true)
    }
    
    // MARK: - IBActions
    
    @IBAction func backPressed(_ sender: UIButton) {
        goToPreviousScreen()
    }
    
    @IBAction func sendFeedbackPressed(_ sender: UIButton) {
        AnalyticsManager.logEvent(K.AnalyticsEvents.sendFeedbackPressed)
        sendEmail()
    }
    
    @IBAction func openInstaPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func openWebsitePressed(_ sender: UIButton) {
        
    }
}

// MARK: - MailCompose Delegate

extension ContactsViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if let error = error {
            AnalyticsManager.logError(errorMessage: K.ErrorsMessages.sendingFeedbackErrorMessage, error: error)
            controller.dismiss(animated: true, completion: nil) // Add maybe path to the home?
            return
        }
        
        if result == .sent {
            // TODO: Level 2 - Add toast message if message is sent
            goToHomeScreen()
        }
        
        controller.dismiss(animated: true)
    }
}
