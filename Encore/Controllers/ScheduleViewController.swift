//
//  ScheduleViewController.swift
//  Encore
//
//  Created by Katselenbogen, Igor on 2021/01/02.
//

import UIKit

class ScheduleViewController: UIViewController {
    
    // TODO: Level 3 - Add total time left here as well
    
    // MARK: - IBOutlets

    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Private Variables
    
    private let model = EncoreBrain.shared
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.alwaysBounceVertical = false
        tableView.register(UINib(nibName: K.Cells.scheduleCellNibName, bundle: nil), forCellReuseIdentifier: K.Cells.scheduleCellIdentifier)
    }
    
    // MARK: - IBActions
    
    @IBAction func backPressed(_ sender: UIButton) {
        goToPreviousScreen(fromRight: true)
    }
}

// MARK: - Table View Data Source

extension ScheduleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.stagesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.Cells.scheduleCellIdentifier, for: indexPath) as! ScheduleCell
        let currentStage = model.currentSession?.stages[indexPath.row]
        
        cell.stageLabel.text = currentStage?.name
        
        if let duration = currentStage?.durationInMinutes {
            cell.timeLabel.text = "\(duration) minutes"
        }
        
        if indexPath.row < model.getCurrentStageIndex() {
            cell.representStageAsCompleted()
        }
        
        return cell
    }
}
