//
//  SessionViewController.swift
//  Encore
//
//  Created by Katselenbogen, Igor on 2021/01/01.
//

import UIKit

class SessionViewController: UIViewController {
    
    // TODO: Level 1 - Make done button gray at first
    
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
    
    @IBOutlet weak var goalsButton: UIButton!
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
        checkIfUserHasGoals()
        model.startSession()
        adjustUI()
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
            if let stage = currentStageLifecycle, stage == .stageInProcess {
                currentStageLifecycle?.next()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let window = self.view.window, toolTipManager == nil {
            toolTipManager = ToolTipManager(on: window)
            // We need to set it here, so the tooltip manager is created before
            // stage is set - in order to present tool tip right when the screen opens
            currentStageLifecycle = .stageInProcess
        }
    }
    
    // MARK: - Private Methods
    
    private func adjustUI() {
        if let width = model.screenWidth, width <= 320 { // small size of screen
            stageTitle.font = stageTitle.font.withSize(23)
            nextStageSubtitle.font = nextStageSubtitle.font.withSize(20)
        }
    }
    
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
            // Before scheduling new notifications, let's cancel all that we have in our queue.
            // Since all of them are scheduled it might happen that it will be shown for not correct stage.
            // In the case when user tap "done" button and copmlete the stage manually.
            notificationManager.cancelNotifications()
            scheduleNotification(timeInterval: TimeInterval(stage.durationInSeconds))
        }
        
        if let nextStage = model.getNextStage() {
            nextStageTitle.text = nextStage.name
            nextStageSubtitle.text = K.Strings.nextSession +  nextStage.name
        } else {
            nextStageTitle.text = K.Strings.review
            nextStageSubtitle.text = K.Strings.nextSession + K.Strings.review
        }
        
        openToolTipIfNeeded()

        nextStageButton.setTitle(K.Strings.doneButtonText, for: .normal)
    }
    
    private func scheduleNotification(timeInterval: TimeInterval) {
        let title = K.Notifications.completeStageNotificationTitle
        var body = ""
        if let nextStage = model.getNextStage() {
            body = K.Notifications.completeStageNotificationBodyBase + nextStage.name
        } else {
            body = K.Notifications.completeStageNotificationBodyBase + K.Strings.review
        }
        notificationManager.scheduleNotification(notificationTitle: title, notificationBody: body, timeInterval: timeInterval)
    }
    
    private func checkIfUserHasGoals() {
        if model.goalsCount == 0 {
            goalsButton.isEnabled = false
            goalsButton.setImage(K.Images.goalsButtonDisabled, for: .normal)
        }
    }
    
    private func openToolTipIfNeeded() {
        let stageType = model.getCurrentStage()?.stageType.rawValue
        if let stage = stageType {
            let key = "hasOpened" + stage
            
            if !UserDefaults.standard.bool(forKey: key) {
                openToolTip()
                UserDefaults.standard.set(true, forKey: key)
            }
        }
    }
    
    
    private func openToolTip() {
        if let tips = currentTipsArray {
            toolTipManager?.showToolTip(attachTo: self.infoButton, textArray: tips, toolTipType: .Info)
        }
    }
    
    private func setStageFinished() {
        afterStageInformationStack.isHidden = false
        
        timerTitle.isHidden = true
        nextStageSubtitle.isHidden = true
        infoButton.isHidden = true
        
        stageTitle.text = K.Strings.stageFinishedText
        nextStageButton.setTitle(K.Strings.nextButtonText, for: .normal)
        // This cleaning protect us from showing redundant notification in case
        // when a user manually taps "done" button and waits in the "stage finished" state for some time
        notificationManager.cancelNotifications()
        
        remindReviewGoalsIfNeeded()
    }
    
    private func remindReviewGoalsIfNeeded() {
        if nextStageTitle.text == K.Strings.review && goalsButton.isEnabled {
            toolTipManager?.showToolTip(attachTo: goalsButton, textArray: K.ToolTips.reviseGoals, toolTipType: .Info)
        }
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
        openToolTip()
    }
}
