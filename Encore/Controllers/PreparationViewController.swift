//
//  PreparationViewController.swift
//  Encore
//
//  Created by Katselenbogen, Igor on 2020/12/24.
//

import UIKit

class PreparationViewController: UIViewController {
    
    // TODO: Level 1 : Update the design
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var firstModeButton: ModeButton!
    @IBOutlet weak var secondModeButton: ModeButton!
    @IBOutlet weak var thirdModeButton: ModeButton!
    
    @IBOutlet weak var catImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextButton: EncoreButton!
    
    // MARK: - Private Variables
    
    private var buttons: [ModeButton] = []
    private let model = EncoreBrain.shared

    // MARK: - Life Cycles
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUIElements(isModeChosen: false)
        clearButtonsSelection()
        
        buttons = [firstModeButton, secondModeButton, thirdModeButton]
        
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.scheduleCellNibName, bundle: nil), forCellReuseIdentifier: K.scheduleCellIdentifier)
    }
    
    // MARK: - Private Methods
    
    private func clearButtonsSelection() {
        buttons.forEach {
            $0.borderColor = .clear
            $0.borderWidth = 0
        }
    }
    
    private func selectMode(button: ModeButton) {
        button.borderColor = UIColor(hexString: "#535987")
        button.borderWidth = 3
    }
    
    private func updateUIElements(isModeChosen: Bool) {
        catImage.isHidden = isModeChosen
        nextButton.isHidden = !isModeChosen
        tableView.isHidden = !isModeChosen
    }
    
    // MARK: - IBActions
    
    @IBAction func sessionSelected(_ sender: ModeButton) {
                clearButtonsSelection()
                switch sender.tag {
                case 0:
                    model.setSession(Sessions.miniSession)
                    selectMode(button: sender)
                case 1:
                    model.setSession(Sessions.halfDaySession)
                    selectMode(button: sender)
                case 2:
                    model.setSession(Sessions.fullDaySession)
                    selectMode(button: sender)
                default:
                    break
                }
                updateUIElements(isModeChosen: true)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        goToPreviousScreen()
    }
    
    @IBAction func nextPressed(_ sender: EncoreButton) {
        goTo(screen: K.StoryBoard.inputGoalsViewController)
    }
}

// MARK: - Table View Data Source

extension PreparationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.stagesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.scheduleCellIdentifier, for: indexPath) as! ScheduleCell
        let currentStage = model.currentSession?.stages[indexPath.row]
        
        cell.stageLabel.text = currentStage?.name
        
        if let duration = currentStage?.durationInMinutes {
            cell.timeLabel.text = "\(duration) minutes"
        }
        
        return cell
    }
}



