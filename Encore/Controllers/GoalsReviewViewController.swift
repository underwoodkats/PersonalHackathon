//
//  GoalsReviewViewController.swift
//  Encore
//
//  Created by Katselenbogen, Igor on 2021/01/05.
//

import UIKit

class GoalsReviewViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Private Variables
    
    private let model = EncoreBrain.shared
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model.sortGoals()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.alwaysBounceVertical = false
        tableView.register(UINib(nibName: K.Cells.goalCellNibName, bundle: nil), forCellReuseIdentifier: K.Cells.goalCellIdentifier)
    }
    
    // MARK: - IBActions

    
    @IBAction func finishPressed(_ sender: Any) {
        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
    }
    @IBAction func backPressed(_ sender: UIButton) {
        goToPreviousScreen()
    }
}

// MARK: - TabkeView Data Source

extension GoalsReviewViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let possibleRowsWithoutScrolling = Int((tableView.frame.height / Metrics.goalsTableViewRowHeight))
        return max(model.totalGoalsPartsCount + 1, possibleRowsWithoutScrolling)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        model.sortGoals()
        let cell = tableView.dequeueReusableCell(withIdentifier: K.Cells.goalCellIdentifier, for: indexPath) as! GoalCell
        if indexPath.row < model.totalGoalsPartsCount {
            if let currentPart = model.getGoalPart(index: indexPath.row) {
                cell.goalLabel.text = currentPart.text
                if currentPart.isFirstPart, let relatedGoal = model.getGoal(by: currentPart.goalId) {
                    cell.goalCompletedImage.isHidden = !relatedGoal.isAchieved
                    cell.goalInProcessImage.isHidden = relatedGoal.isAchieved
                }
            }
        } else {
            cell.goalLabel.text = " "
        }
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - TableView Delegate

extension GoalsReviewViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Metrics.goalsTableViewRowHeight
    }
}
