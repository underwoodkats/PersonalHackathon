//
//  CountdownViewController.swift
//  Encore
//
//  Created by Igor Katselenbogen on 2021/02/19.
//

import UIKit

class CountdownViewController: UIViewController {
    
    // MARK: - IBOutles
    
    @IBOutlet weak var timerLabel: UILabel!
    
    // MARK: - Private Variables
    
    private var timer: Timer?
    private var counter = 3.0
    private var indicatorSize: CGFloat = 0.0

    private let circularIndicator: ProgressView = {
        let progress = ProgressView(colors: [K.Colors.gradientYellowTop, K.Colors.gradientYellowBottom], lineWidth: Metrics.CountdownScreen.circularIndicatorWidth)
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        prepareCircularAnimation()
        prepareTimer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        circularIndicator.isAnimating = true
    }
    
    // MARK: - Private Methods
    
    private func setUI() {
        let size = ScreenSizeManager.getCurrentScreenSize(screenView: self.view)
        switch size {
        case .small:
            indicatorSize = Metrics.CountdownScreen.smallIndicatorSize
            timerLabel.font = timerLabel.font.withSize(Metrics.CountdownScreen.smallTimerFontSize)
        case .medium:
            indicatorSize = Metrics.CountdownScreen.mediumIndicatorSize
            timerLabel.font = timerLabel.font.withSize(Metrics.CountdownScreen.mediumTimerFontSize)
        case .large:
            indicatorSize = Metrics.CountdownScreen.largeIndicatorSize
            timerLabel.font = timerLabel.font.withSize(Metrics.CountdownScreen.largeTimerFontSize)
        }
    }
    
    private func prepareCircularAnimation() {
        self.view.addSubview(circularIndicator)
        
        NSLayoutConstraint.activate([
            circularIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            circularIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            circularIndicator.widthAnchor.constraint(equalToConstant: indicatorSize),
            circularIndicator.heightAnchor.constraint(equalTo: self.circularIndicator.widthAnchor)
        ])
        
    }
    
    private func prepareTimer() {
        timer?.invalidate()
        timerLabel.text = "\(Int(counter))"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
    }
    
    @objc private func countdown() {
        counter -= 1.0
        if counter == 0 {
            timer?.invalidate()
            goTo(screen: K.StoryBoard.sessionViewController, isFading: true)
        }
        timerLabel.text = "\(Int(counter))"
    }
}
