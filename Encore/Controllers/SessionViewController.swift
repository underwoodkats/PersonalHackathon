//
//  SessionViewController.swift
//  Encore
//
//  Created by Katselenbogen, Igor on 2021/01/01.
//

import UIKit

class SessionViewController: UIViewController {
    
    // TODO: Level 1 - Add tips for closing the session
    // TODO: Level 2 - Exctract all texts strings. At least withing this file
    // TODO: Level 1 - Make done button gray at first
    // TODO: Level 2 - Gray out todays goals if there are none
    
    enum StageLifecycle: Int {
        case stageInProcess
        case stageFinished
        
        mutating func next(){
             self = StageLifecycle(rawValue: rawValue + 1) ?? StageLifecycle(rawValue: 0)!
         }
    }

    // MARK: - IBOutlets
    
    @IBOutlet weak var stageTitle: UILabel!
    
    @IBOutlet weak var timerTitle: UILabel!
    // This label is on stageInProcess state
    @IBOutlet weak var nextStageSubtitle: UILabel!
    
    @IBOutlet weak var afterStageInformationStack: UIStackView!
    // This label is on stageFinished state
    @IBOutlet weak var nextStageTitle: UILabel!
    
    @IBOutlet weak var nextStageButton: EncoreButton!
    @IBOutlet weak var infoButton: UIButton!
    
    @IBOutlet weak var catImage: UIImageView!
    @IBOutlet weak var backgroundView: UIView!
    
    // MARK: - Private Variables
    
    private var model = EncoreBrain.shared
    private var toolTipManager: ToolTipManager?
    private var currentTipsArray: [String]?
    private var hasPressedClose = false
    
    private var currentStageLifecycle: StageLifecycle? {
        didSet {
            if currentStageLifecycle == .stageInProcess {
                setStageInProcess()
            } else {
                setStageFinished()
            }
        }
    }
    
    private let notificationManager = NotificationManager.shared
    private var timer: Timer?
    private var counter = 0.0
    private var currentStageTimeStart: Date?
    
    // MARK: - Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()
        model.startSession()
        currentStageLifecycle = .stageInProcess
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self,
                                               selector:#selector(applicationWillEnterForeground(_:)),
                                               name: UIApplication.willEnterForegroundNotification,
                                               object: nil)
        
        updateTimerAfterAwaking()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func applicationWillEnterForeground(_ notification: NSNotification) {
        updateTimerAfterAwaking()
        if counter <= 0.0 {
            timer?.invalidate()
            currentStageLifecycle?.next()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let window = self.view.window {
            toolTipManager = ToolTipManager(on: window)
        }
    }
    
    // MARK: - Private Methods
    
    private func setStageInProcess() {
        currentStageTimeStart = Date()
        
        afterStageInformationStack.isHidden = true
        
        timerTitle.isHidden = false
        nextStageSubtitle.isHidden = false
        infoButton.isHidden = false
        
        if let stage = model.getCurrentStage() {
            stageTitle.text = stage.name
            counter = Double(stage.durationInSeconds)
            timerTitle.text = stage.durationInSeconds.stringTimeFormat()
            catImage.image = stage.catImage
            backgroundView.backgroundColor = stage.backgroundColor
            currentTipsArray = stage.hintsArray
            timer?.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimerLabel), userInfo: nil, repeats: true)
            scheduleNotification(timeInterval: TimeInterval(stage.durationInSeconds))
        }
        
        if let nextStage = model.getNextStage() {
            nextStageTitle.text = nextStage.name
            nextStageSubtitle.text = "Next session: \(nextStage.name)"
        } else {
            nextStageTitle.text = "Review"
            nextStageSubtitle.text = "Next session: Review"
        }

        nextStageButton.setTitle("Done", for: .normal)
    }
    
    private func scheduleNotification(timeInterval: TimeInterval) {
        let title = "Yey! Stage completed!"
        var body = ""
        if let nextStage = model.getNextStage() {
            body = "Next stage is " + nextStage.name
        } else {
            body = "Next stage is " + "Review"
        }
        notificationManager.scheduleNotification(notificationTitle: title, notificationBody: body, timeInterval: timeInterval)
    }
    
    private func setStageFinished() {
        afterStageInformationStack.isHidden = false
        
        timerTitle.isHidden = true
        nextStageSubtitle.isHidden = true
        infoButton.isHidden = true
        
        stageTitle.text = "Stage Finished"
        nextStageButton.setTitle("Let's go!", for: .normal)
    }
    
    // Unfortunately, timer can't work in background state.
    // So this additional logic helps us keep track on time.
    private func updateTimerAfterAwaking() {
        if let currentStageTimeStart = currentStageTimeStart {
            let currentTime = Date()
            let timePassed = Double(currentTime.timeIntervalSince(currentStageTimeStart))
            
            counter -= timePassed
            if counter <= 0.0 {
                counter = 0.0
            }
            
            let timerLabelText = Int(counter).stringTimeFormat()
            timerTitle.text = timerLabelText
        }
    }
    
    @objc private func updateTimerLabel() {
        counter -= 1
        let timerLabelText = Int(counter).stringTimeFormat()
        timerTitle.text = timerLabelText
        if counter <= 0 {
            timer?.invalidate()
            currentStageLifecycle?.next()
        }
    }
    
    // MARK: - IBActions

    @IBAction func closePressed(_ sender: UIButton) {
        if hasPressedClose {
            goToHomeScreen()
        } else {
            hasPressedClose = true
            toolTipManager?.showToolTip(attachTo: sender, textArray: K.ToolTips.sessionScreenClosingWarningTip, toolTipType: .Warning)
        }
    }
    
    @IBAction func nextStageButtonPressed(_ sender: Any) {
        if let cycle = currentStageLifecycle, cycle == .stageFinished {
            if !model.goToNextStageIfPossible() {
                goTo(screen: K.StoryBoard.congratulationsViewController)
                return
            }
        }
        
        currentStageLifecycle?.next()
    }
    
    @IBAction func schedulePressed(_ sender: UIButton) {
        goTo(screen: K.StoryBoard.scheduleViewController)
    }
    @IBAction func goalsPressed(_ sender: UIButton) {
        goTo(screen: K.StoryBoard.goalsForDayViewController)
    }
    
    @IBAction func infoPressed(_ sender: Any) {
        if let tips = currentTipsArray {
            toolTipManager?.showToolTip(attachTo: self.infoButton, textArray: tips, toolTipType: .Info)
        }
    }
}
