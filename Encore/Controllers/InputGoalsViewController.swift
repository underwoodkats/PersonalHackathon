//
//  InputGoalsViewController.swift
//  Encore
//
//  Created by Katselenbogen, Igor on 2020/12/26.
//

import UIKit
import TipSee

class InputGoalsViewController: UIViewController {
    
    // Update text in tool tips
    // Extract text to K
    
    // TODO: Level 3 - Make round corners for the first cell
    // TODO: Level 3 - Make it possible to edit a goal
    // TODO: Level 3 - When add goal, go down to that goal (move table view)

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
        tableView.showsVerticalScrollIndicator = false
        tableView.register(UINib(nibName: K.Cells.goalCellNibName, bundle: nil), forCellReuseIdentifier: K.Cells.goalCellIdentifier)
    }
    
    // MARK: - Private Methods
    
    private func setTableViewUI() {
        tableView.clipsToBounds = true
        tableView.layer.cornerRadius = 40 // Set As you want
        tableView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
    }
    
    private func addGoal() {
        var textField = UITextField()
        textField.autocapitalizationType = .sentences
        
        let alert = UIAlertController(title: "Add a new goal", message: "", preferredStyle: .alert)
        
        let addAction = UIAlertAction(title: "Add", style: .default) { (action) in
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
        
        let cancelAction = UIAlertAction(title: "Back", style: .default)
        
        alert.message = "Describe your goal in one easy to understand sentence"
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = K.Placeholders.addingGoalPlaceholder
            textField = alertTextField
        }
        
        alert.addAction(cancelAction)
        alert.addAction(addAction)
        
        
        present(alert, animated: true) {
            // This code helps us dismiss alert when a user tap outside
            alert.view.superview?.isUserInteractionEnabled = true
            alert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissOnTapOutside)))
        }
    }
    
    @objc func dismissOnTapOutside(){
       self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - IBActions
    
    @IBAction func addGoalPressed(_ sender: EncoreButton) {
        addGoal()
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
        return max(model.totalGoalsPartsCount + 1 , possibleRowsWithoutScrolling)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.Cells.goalCellIdentifier, for: indexPath) as! GoalCell
        cell.delegate = self
        if indexPath.row < model.totalGoalsPartsCount {
            if let currentPart = model.getGoalPart(index: indexPath.row) {
                if currentPart.isFirstPart {
                    var goalPosition = ""
                    if let position = model.getGoalPosition(by: currentPart.goalId) {
                        goalPosition = "\(position + 1)"
                    }
                    
                    cell.goalLabel.text = "\(goalPosition). \(currentPart.text)"
                    cell.removeButton.isHidden = false
                } else {
                    cell.goalLabel.text = "\(currentPart.text)"
                    cell.removeButton.isHidden = true
                }
            }
        } else {
            cell.goalLabel.text = " "
            cell.removeButton.isHidden = true
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row >= model.totalGoalsPartsCount {
            addGoal()
        }
    }
}

// MARK: - Goal Cell Delegate

extension InputGoalsViewController: GoalCellDelegate {
    func didPressRemoveButton(_ cell: UITableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            print("Remove button tapped at \(indexPath)")
            let targetGoalPartPosition = indexPath.row
            model.removeGoal(by: targetGoalPartPosition)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
