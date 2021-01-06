//
//  InputGoalsViewController.swift
//  Encore
//
//  Created by Katselenbogen, Igor on 2020/12/26.
//

import UIKit

class InputGoalsViewController: UIViewController {
    
    // TODO: Level 2 - Make round corners for the first cell
    // TODO: Level 1 - Think better about cutting the string - no spaces around

    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextButton: EncoreButton!
    
    // MARK: - Private Variables
    
    private let model = EncoreBrain.shared
    
    // MARK: - Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.alwaysBounceVertical = false
        tableView.register(UINib(nibName: K.goalCellNibName, bundle: nil), forCellReuseIdentifier: K.goalCellIdentifier)
    }
    
    // MARK: - Private Methods
    
    private func setTableViewUI() {
        tableView.clipsToBounds = true
        tableView.layer.cornerRadius = 40 // Set As you want
        tableView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
    }
    
    private func updateUIIfGoalsAreSet() {
        if model.goalsCount > 0 {
            nextButton.setTitle("Let's go!", for: .normal)
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func addGoalPressed(_ sender: EncoreButton) {
        var textField = UITextField()
        textField.autocapitalizationType = .sentences
        
        let alert = UIAlertController(title: "Add a New Goal", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            if let newGoalName = textField.text {
                let goalName = newGoalName.capitalizingFirstLetter()
                
                let newGoal = Goal(name: goalName, isAchieved: false)
                self.model.addGoal(goal: newGoal)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "I want to achieve..."
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func nextPressed(_ sender: EncoreButton) {
        self.performSegue(withIdentifier: K.goalsSegue, sender: self)
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Table View Data Source

extension InputGoalsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        updateUIIfGoalsAreSet()
        // TODO: Level 2 -Create constant struct
        return max(model.goalsCount, 6)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.goalCellIdentifier, for: indexPath) as! GoalCell
        if indexPath.row < model.goalsCount {
            let currentGoal = model.goals[indexPath.row]
            cell.goalLabel.text = "\(indexPath.row + 1). \(currentGoal.name)"
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
        return 70
    }
}
