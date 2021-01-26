//
//  InputGoalsViewController.swift
//  Encore
//
//  Created by Katselenbogen, Igor on 2020/12/26.
//

import UIKit
import TipSee

class InputGoalsViewController: UIViewController {
    
    // TODO: Level 1 - Update the design
    // TODO: Level 2 - Make round corners for the first cell
    // TODO: Level 1 - Make it possible to edit a goal

    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextButton: EncoreButton!
    @IBOutlet weak var infoButton: UIButton!
    
    // MARK: - Private Variables
    
    private let model = EncoreBrain.shared
    private var toolTipManager: ToolTipManager?
    private var hasPressedNext = false
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let window = self.view.window {
            toolTipManager = ToolTipManager(on: window)
        }
    }
    
    // MARK: - Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.alwaysBounceVertical = false
        tableView.register(UINib(nibName: K.Cells.goalCellNibName, bundle: nil), forCellReuseIdentifier: K.Cells.goalCellIdentifier)
    }
    
    // MARK: - Private Methods
    
    private func setTableViewUI() {
        tableView.clipsToBounds = true
        tableView.layer.cornerRadius = 40 // Set As you want
        tableView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
    }
    
    // MARK: - IBActions
    
    @IBAction func addGoalPressed(_ sender: EncoreButton) {
        var textField = UITextField()
        textField.autocapitalizationType = .sentences
        
        let alert = UIAlertController(title: "Add a New Goal", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            if let newGoalName = textField.text, !newGoalName.trimmingCharacters(in: .whitespaces).isEmpty {
                let goalName = newGoalName.capitalizingFirstLetter()
                let goalId = self.model.generateGoalId()
                let newGoal = Goal(goalId: goalId, name: goalName, isAchieved: false)
                self.model.addGoal(goal: newGoal)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = K.Placeholders.addingGoalPlaceholder
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func infoPressed(_ sender: UIButton) {
        toolTipManager?.showToolTip(attachTo: self.infoButton, textArray: K.ToolTips.insertGoalsScreenInfoTips, toolTipType: .Info)
    }
    
    @IBAction func nextPressed(_ sender: EncoreButton) {
        if model.goalsCount > 0 || hasPressedNext {
            goTo(screen: K.StoryBoard.sessionViewController)
        } else {
            hasPressedNext = true
            toolTipManager?.showToolTip(attachTo: sender, textArray: K.ToolTips.insertGoalScreenWarningTip, toolTipType: .Warning)
        }
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        goToPreviousScreen()
    }
}

// MARK: - Table View Data Source

extension InputGoalsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let possibleRowsWithoutScrolling = Int((tableView.frame.height / Metrics.goalsTableViewRowHeight))
        return max(model.totalGoalsPartsCount, possibleRowsWithoutScrolling)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.Cells.goalCellIdentifier, for: indexPath) as! GoalCell
        if indexPath.row < model.totalGoalsPartsCount {
            if let currentPart = model.getGoalPart(index: indexPath.row) {
                if currentPart.isFirstPart {
                    cell.goalLabel.text = "\(currentPart.goalId + 1). \(currentPart.text)"
                } else {
                    cell.goalLabel.text = "\(currentPart.text)"
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

extension InputGoalsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Metrics.goalsTableViewRowHeight
    }
}
