//
//  LiftOfferAcceptedVC.swift
//  Find My Lift
//
//  Created by Stephen Learmonth on 21/10/2020.
//  Copyright © 2020 Stephen Learmonth. All rights reserved.
//

import UIKit

class LiftOfferAcceptedVC: UIViewController {

    // MARK: - Properties
    
    private let confirmLabel: UILabel = {
        let label = UILabel()
        label.text = "Your lift with Louise is confirmed"
        label.textColor = UIColor(white: 1.0, alpha: 1.0)
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 23)
        label.backgroundColor = .systemGreen
        label.textAlignment = .center
        label.setHeight(height: 50.0)
        label.layer.cornerRadius = 25.0
        label.layer.masksToBounds = true
        return label
    }()
    
    private let timeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Time until lift arrives:"
        label.textColor = UIColor(white: 1.0, alpha: 1.0)
        label.backgroundColor = .clear
        label.font = UIFont(name: "AvenirNext-Regular", size: 20)
        return label
    }()

    private lazy var timeValueLabel: UILabel = {
        let label = UILabel()
        label.text = computeTimeLeft(timeInSeconds: countDownValue)
        label.textColor = UIColor(white: 1.0, alpha: 1.0)
        label.backgroundColor = .clear
        label.font = UIFont(name: "AvenirNext-Regular", size: 20)
        return label
    }()

    private var countDownValue = 86400*4 + 3600*2 + 65
    
    private let arrivesLabel: UILabel = {
        let label = UILabel()
        label.text = "Your lift has arrived!"
        label.textColor = UIColor(white: 1.0, alpha: 1.0)
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 23)
        label.backgroundColor = .systemGreen
        label.textAlignment = .center
        label.setHeight(height: 50.0)
        label.layer.cornerRadius = 25.0
        label.layer.masksToBounds = true
        return label
    }()
    
    private lazy var amendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Amend Lift Requirements", for: .normal)
        button.layer.cornerRadius = 10.0
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.setHeight(height: 50.0)
        button.isEnabled = true
        button.addTarget(self, action: #selector(handleAmendLift), for: .touchUpInside)
        return button
    }()

    private lazy var messageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Message Driver", for: .normal)
        button.layer.cornerRadius = 10.0
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.setHeight(height: 50.0)
        button.isEnabled = true
        button.addTarget(self, action: #selector(handleMessageDriver), for: .touchUpInside)
        return button
    }()

    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancel Lift", for: .normal)
        button.layer.cornerRadius = 10.0
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.setHeight(height: 50.0)
        button.isEnabled = true
        button.addTarget(self, action: #selector(handleCancelLift), for: .touchUpInside)
        return button
    }()
    
    private lazy var findButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Find Another Lift", for: .normal)
        button.layer.cornerRadius = 10.0
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.setHeight(height: 50.0)
        button.isEnabled = true
        button.addTarget(self, action: #selector(handleFindAnotherLift), for: .touchUpInside)
        return button
    }()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    // MARK: - Helper Functions
    
    private func configureUI() {
        
        configureGradientLayer()
        
        configureNavigationBar()
                
        view.addSubview(confirmLabel)
        confirmLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 40.0, paddingLeft: 16.0, paddingRight: 16.0)
        
        view.addSubview(timeTitleLabel)
        timeTitleLabel.anchor(top: confirmLabel.bottomAnchor, paddingTop: 25.0)
        timeTitleLabel.centerX(inView: view)
        
        view.addSubview(timeValueLabel)
        timeValueLabel.anchor(top: timeTitleLabel.bottomAnchor, paddingTop: 25.0)
        timeValueLabel.centerX(inView: view)
        
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCountDownLabel), userInfo: nil, repeats: true)
    }
    
    private func configureNavigationBar() {
        title = "Lift Offer Accepted"
        navigationItem.backButtonTitle = ""

        navigationController?.navigationBar.barTintColor = .systemBlue
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30)]
        navigationController?.navigationBar.barStyle = .black
    }
    private func computeTimeLeft(timeInSeconds: Int) -> String {
        let days = countDownValue / 86400
        let hours = (countDownValue % 86400) / 3600
        let minutes = (countDownValue % 3600) / 60
        let seconds = (countDownValue % 3600) % 60
        return "\(days) days : \(hours) hrs : \(minutes) mins : \(seconds) secs"
    }
    
    // MARK: - Selectors
    
    @objc func updateCountDownLabel() {
        if countDownValue > 0 {
            countDownValue -= 1
            timeValueLabel.text = computeTimeLeft(timeInSeconds: countDownValue)
        } else {
            timeTitleLabel.removeFromSuperview()
            timeValueLabel.removeFromSuperview()
            view.addSubview(arrivesLabel)
            arrivesLabel.anchor(top: confirmLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 25.0, paddingLeft: 32.0, paddingRight: 32.0)
        }
    }
    
    @objc func handleAmendLift() {
        
    }
    
    @objc func handleMessageDriver() {
        
    }
    
    @objc func handleCancelLift() {
        
    }
    
    @objc func handleFindAnotherLift() {
        
    }
}
