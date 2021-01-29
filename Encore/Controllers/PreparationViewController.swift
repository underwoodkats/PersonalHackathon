//
//  PreparationViewController.swift
//  Encore
//
//  Created by Katselenbogen, Igor on 2020/12/24.
//

import UIKit

class PreparationViewController: UIViewController {
    
    // TODO: Level 3 - Create gradient manager. It could have different methods to appl gradient to tableView background, or just to button, or to a view. But it is better more centrilized.
    // TODO: Level 3 - Remove yellow background on iPhone 11 for the small session
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var catAreaView: UIView!
    @IBOutlet weak var firstModeButton: ModeButton!
    @IBOutlet weak var secondModeButton: ModeButton!
    @IBOutlet weak var thirdModeButton: ModeButton!
    
    @IBOutlet weak var catImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextButton: EncoreButton!
    @IBOutlet weak var totalTimeView: UIView!
    @IBOutlet weak var totalTimeLabel: UILabel!
    
    // MARK: - Private Variables
    
    private var buttons: [ModeButton] = []
    private let model = EncoreBrain.shared
    private let catAreaGradientLayer = CAGradientLayer()
    private let tableViewBackgroundGradientLayer = CAGradientLayer()
    private let totalTimeGradientLayer = CAGradientLayer()

    // MARK: - Life Cycles
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setGradients()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUIElements(isModeChosen: false)
        clearButtonsSelection()
        
        buttons = [firstModeButton, secondModeButton, thirdModeButton]
        
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.Cells.scheduleCellNibName, bundle: nil), forCellReuseIdentifier: K.Cells.scheduleCellIdentifier)
        tableView.showsVerticalScrollIndicator = false
    }
    
    // MARK: - Private Methods
    
    private func setGradients() {
        let colorTop = K.Colors.gradientYellowTop
        let colorBottom = K.Colors.gradientYellowBottom

        catAreaGradientLayer.colors = [colorTop.cgColor, colorBottom.cgColor]
        tableViewBackgroundGradientLayer.colors = [colorTop.cgColor, colorBottom.cgColor]
        totalTimeGradientLayer.colors = [colorTop.cgColor, colorBottom.cgColor]
        
        catAreaGradientLayer.frame = catAreaView.bounds
        tableViewBackgroundGradientLayer.frame = tableView.bounds
        totalTimeGradientLayer.frame = totalTimeView.bounds
        
        let backgroundView = UIView(frame: self.tableView.bounds)
        
        catAreaView.layer.insertSublayer(catAreaGradientLayer, at: 0)
        backgroundView.layer.insertSublayer(tableViewBackgroundGradientLayer, at: 0)
        tableView.backgroundView = backgroundView
        totalTimeView.layer.insertSublayer(totalTimeGradientLayer, at: 0)
    }
 
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
        totalTimeView.isHidden = !isModeChosen
        totalTimeLabel.isHidden = !isModeChosen
    }
    
    private func scrollToFirstRow() {
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.scrollToRow(at: indexPath, at: .top, animated: false)
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
        
                let totalTimeString = self.model.getTotalTimeForCurrentSession()
        
                updateUIElements(isModeChosen: true)
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    
                    self.tableView.reloadData()
                    if let time = totalTimeString, !time.isEmpty {
                        self.totalTimeView.isHidden = false
                        self.totalTimeLabel.text = time
                    } else {
                        self.totalTimeView.isHidden = true
                    }
                    self.scrollToFirstRow()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: K.Cells.scheduleCellIdentifier, for: indexPath) as! ScheduleCell
        let currentStage = model.currentSession?.stages[indexPath.row]
        
        cell.stageLabel.text = currentStage?.name
        
        if let duration = currentStage?.durationInMinutes {
            cell.timeLabel.text = "\(duration) minutes"
        }
        
        return cell
    }
}
