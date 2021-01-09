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
        tableView.dataSource = self
        tableView.delegate = self
        tableView.alwaysBounceVertical = false
        tableView.register(UINib(nibName: K.goalCellNibName, bundle: nil), forCellReuseIdentifier: K.goalCellIdentifier)
        
        model.sortGoals()
    }
    
    // MARK: - IBActions

    
    @IBAction func finishPressed(_ sender: Any) {
        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
    }
    @IBAction func backPressed(_ sender: UIButton) {
        // TODO: Level 2 - Need to not copy the button, but create an instance for all screen.
        // See the outlets for the button
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - TabkeView Data Source

extension GoalsReviewViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: Level 2 - Create constant struct
        return max(model.goalsCount, 6)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.goalCellIdentifier, for: indexPath) as! GoalCell
        if indexPath.row < model.goalsCount {
            let currentGoal = model.goals[indexPath.row]
            cell.goalLabel.text = currentGoal.name
            cell.goalCompletedImage.isHidden = !currentGoal.isAchieved
            cell.goalInProcessImage.isHidden = currentGoal.isAchieved
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
        return 70
    }
}
