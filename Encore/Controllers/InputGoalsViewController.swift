//
//  InputGoalsViewController.swift
//  Encore
//
//  Created by Katselenbogen, Igor | Rogi | MESD on 2020/12/26.
//

import UIKit

class InputGoalsViewController: UIViewController {
    
    // TODO - Make round corners for the first cell
    // TODO - Think better about cutting the string - no spaces around

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextButton: EncoreButton!
    
    private let model = EncoreBrain.shared
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.goalCellNibName, bundle: nil), forCellReuseIdentifier: K.goalCellIdentifier)
    }
    
    private func setTableViewUI() {
        tableView.clipsToBounds = true
        tableView.layer.cornerRadius = 40 // Set As you want
        tableView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
    }
   
    
    @IBAction func addGoalPressed(_ sender: EncoreButton) {
        var textField = UITextField()
        textField.autocapitalizationType = .sentences
        
        let alert = UIAlertController(title: "Add a New Goal", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            if let newGoalName = textField.text {
                let goalName = "— " + newGoalName.capitalizingFirstLetter()
                
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
    
    func updateUIIfGoalsAreSet() {
        if model.goalsCount > 0 {
            nextButton.setTitle("Let's go!", for: .normal)
        }
    }
    
    @IBAction func nextPressed(_ sender: EncoreButton) {
        self.performSegue(withIdentifier: K.goalsSegue, sender: self)
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}


extension InputGoalsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        updateUIIfGoalsAreSet()
        return model.goalsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.goalCellIdentifier, for: indexPath) as! GoalCell
        let currentGoal = model.goals[indexPath.row]
        cell.goalLabel.text = currentGoal.name
        cell.selectionStyle = .none
        return cell
    }
}


