//
//  GoalsReviewViewController.swift
//  Encore
//
//  Created by Katselenbogen, Igor on 2021/01/02.
//

import UIKit

class GoalsForDayViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Private Variables
    
    private let model = EncoreBrain.shared
    private let gradientLayer = CAGradientLayer()
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.alwaysBounceVertical = false
        tableView.delegate = self
        tableView.register(UINib(nibName: K.Cells.goalCellNibName, bundle: nil), forCellReuseIdentifier: K.Cells.goalCellIdentifier)
    }
    
    override func viewWillLayoutSubviews() {
        setTableViewBackgroundGradient()
    }
    
    // MARK: - IBActions
    
    @IBAction func backPressed(_ sender: UIButton) {
        goToPreviousScreen()
    }
    
    // MARK: - Private Methods
    
    private func setTableViewBackgroundGradient() {
        let colorTop = K.Colors.gradientYellowTop
        let colorBottom = K.Colors.gradientYellowBottom

        gradientLayer.colors = [colorTop.cgColor, colorBottom.cgColor]
        gradientLayer.frame = self.tableView.bounds
        let backgroundView = UIView(frame: self.tableView.bounds)
        backgroundView.layer.insertSublayer(gradientLayer, at: 0)
        self.tableView.backgroundView = backgroundView
    }
    
}

// MARK: - Table View Data Source

extension GoalsForDayViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let possibleRowsWithoutScrolling = Int((tableView.frame.height / Metrics.goalsTableViewRowHeight))
        return max(model.totalGoalsPartsCount + 1, possibleRowsWithoutScrolling)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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

// MARK: - Table View Delegate
extension GoalsForDayViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // TODO: Level 2 - Make limits for the words
        return Metrics.goalsTableViewRowHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: Level 2 -Make the text be crossed
        if let goalPart = model.getGoalPart(index: indexPath.row) {
            model.changeGoalStatus(id: goalPart.goalId)
            tableView.reloadData()
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
}
