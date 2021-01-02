//
//  SessionViewController.swift
//  Encore
//
//  Created by Katselenbogen, Igor | Rogi | MESD on 2021/01/01.
//

import UIKit

class SessionViewController: UIViewController {
    
    // TODO: Implement INFO button
    // TODO: Also changing background color
    // TODO: Also changing cat
    // TODO: Add push notifications when stage is finished
    // TODO: Add tips for closing the session
    // TODO: Exctract all texts strings. At least withing this file
    
    enum StageLifecycle: Int {
        case stageInProcess
        case stageFinished
        
        mutating func next(){
             self = StageLifecycle(rawValue: rawValue + 1) ?? StageLifecycle(rawValue: 0)!
         }
    }

    // MARK: - IBOutlets
    
    @IBOutlet weak var stageTitle: UILabel!
    
    @IBOutlet weak var stageInformationStack: UIStackView!
    @IBOutlet weak var timerTitle: UILabel!
    // This label is on stageInProcess state
    @IBOutlet weak var nextStageSubtitle: UILabel!
    
    @IBOutlet weak var afterStageInformationStack: UIStackView!
    // This label is on stageFinished state
    @IBOutlet weak var nextStageTitle: UILabel!
    
    @IBOutlet weak var nextStageButton: EncoreButton!
    
    // MARK: - Private Variable
    
    private var model = EncoreBrain.shared
    
    private var currentStageLifecycle: StageLifecycle? {
        didSet {
            if currentStageLifecycle == .stageInProcess {
                setStageInProcess()
            } else {
                setStageFinished()
            }
        }
    }
    
    private var timer: Timer?
    var counter = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model.startSession()
        currentStageLifecycle = .stageInProcess
    }
    
    func setStageInProcess() {
        afterStageInformationStack.isHidden = true
        stageInformationStack.isHidden = false
        
        if let stage = model.getCurrentStage() {
            stageTitle.text = stage.name
            counter = Double(stage.durationInSeconds)
            timerTitle.text = stage.durationInSeconds.stringTimeFormat()
            timer?.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimerLabel), userInfo: nil, repeats: true)
        }
        
        if let nextStage = model.getNextStage() {
            nextStageTitle.text = nextStage.name
            nextStageSubtitle.text = "Next session: \(nextStage.name)"
        } else {
            nextStageTitle.text = "Review of accomplishments"
            nextStageSubtitle.text = "Next session: Review of accomplishments"
        }

        nextStageButton.setTitle("I am done", for: .normal)
    }
    
    func setStageFinished() {
        stageInformationStack.isHidden = true
        afterStageInformationStack.isHidden = false
        
        stageTitle.text = "Stage Finished"
        
        nextStageButton.setTitle("Let's go!", for: .normal)
    }
    
    @objc private func updateTimerLabel() {
        counter -= 1
        let timerLabelText = Int(counter).stringTimeFormat()
        timerTitle.text = timerLabelText
        if counter == 0 {
            currentStageLifecycle?.next()
        }
    }
    
    @IBAction func closePressed(_ sender: UIButton) {
    
    }
    
    @IBAction func schedulePressed(_ sender: Any) {
    
    }
    
    @IBAction func goalsPressed(_ sender: Any) {
    
    }
    
    
    @IBAction func nextStageButtonPressed(_ sender: Any) {
        
        if let cycle = currentStageLifecycle, cycle == .stageFinished {
            if !model.goToNextStageIfPossible() {
                self.performSegue(withIdentifier: K.sessionSegue, sender: self)
                return
            }
        }
        currentStageLifecycle?.next()
    }
}