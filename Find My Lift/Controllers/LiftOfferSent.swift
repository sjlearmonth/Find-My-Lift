//
//  LiftOfferSent.swift
//  Find My Lift
//
//  Created by Stephen Learmonth on 26/10/2020.
//  Copyright © 2020 Stephen Learmonth. All rights reserved.
//


import UIKit

class LiftOfferSent: UIViewController {
    
    // MARK: - Properties
    
    private let confirmLabel: UILabel = {
        let label = UILabel()
        label.text = "Lift offer has been sent"
        label.textColor = UIColor(white: 1.0, alpha: 1.0)
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 28)
        label.backgroundColor = .systemGreen
        label.textAlignment = .center
        label.setHeight(height: 80.0)
        label.layer.cornerRadius = 40.0
        label.layer.masksToBounds = true
        return label
    }()
    
    private let timeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Time until passenger is collected:"
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
    
    //    private var countDownValue = 86400*4 + 3600*2 + 65
    private var countDownValue = 15
    
    private let waitingLabel: UILabel = {
        let label = UILabel()
        label.text = "Your passenger is waiting!"
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
        button.setTitle("Amend Offer", for: .normal)
        button.layer.cornerRadius = 10.0
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.setHeight(height: 50.0)
        button.isEnabled = true
        button.addTarget(self, action: #selector(handleAmendOffer), for: .touchUpInside)
        return button
    }()
    
    private lazy var messageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Message Passenger", for: .normal)
        button.layer.cornerRadius = 10.0
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.setHeight(height: 50.0)
        button.isEnabled = true
        button.addTarget(self, action: #selector(handleMessagePassenger), for: .touchUpInside)
        return button
    }()
    
    private lazy var messageTextView: UITextView = {
        let tv = UITextView()
        tv.setDimensions(height: 200, width: self.view.frame.width - 64.0)
        tv.text = "Type your message here."
        tv.font = UIFont(name: "AvenirNext-Regular", size: 18.0)
        tv.textColor = .black
        tv.textAlignment = .left
        tv.backgroundColor = UIColor.white
        tv.layer.borderWidth = 0.25
        tv.layer.borderColor = UIColor.white.cgColor
        tv.layer.cornerRadius = 5.0
        return tv
    }()
    
    private lazy var sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send Message", for: .normal)
        button.layer.cornerRadius = 10.0
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.setHeight(height: 50.0)
        button.isEnabled = true
        button.addTarget(self, action: #selector(handleSendMessage), for: .touchUpInside)
        return button
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancel Lift Offer", for: .normal)
        button.layer.cornerRadius = 10.0
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.setHeight(height: 50.0)
        button.isEnabled = true
        button.addTarget(self, action: #selector(handleCancelOffer), for: .touchUpInside)
        return button
    }()
    
    private lazy var findButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Offer Another Lift", for: .normal)
        button.layer.cornerRadius = 10.0
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.setHeight(height: 50.0)
        button.isEnabled = true
        button.addTarget(self, action: #selector(handleOfferAnotherLift), for: .touchUpInside)
        return button
    }()
    
    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.isScrollEnabled = true
        sv.bounces = false
        return sv
    }()
    
    private lazy var contentView: UIView = {
        let cv = UIView()
        cv.frame.size = CGSize(width: self.view.frame.width, height: self.view.frame.height * 2.0)
        return cv
    }()
    
    var messagePassengerClicked = false
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        configureScrollView()
        
    }
    
    // MARK: - Helper Functions
    
    private func configureUI() {
        
        configureGradientLayer()
        
        configureNavigationBar()
        
        contentView.addSubview(confirmLabel)
        confirmLabel.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 40.0, paddingLeft: 32.0, paddingRight: 32.0)
        
        contentView.addSubview(timeTitleLabel)
        timeTitleLabel.anchor(top: confirmLabel.bottomAnchor, paddingTop: 25.0)
        timeTitleLabel.centerX(inView: contentView)
        
        contentView.addSubview(timeValueLabel)
        timeValueLabel.anchor(top: timeTitleLabel.bottomAnchor, paddingTop: 25.0)
        timeValueLabel.centerX(inView: contentView)
        
        contentView.addSubview(amendButton)
        amendButton.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 250.0, paddingLeft: 32.0, paddingRight: 32.0)
        
        contentView.addSubview(messageButton)
        messageButton.anchor(top: amendButton.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 25.0, paddingLeft: 32.0, paddingRight: 32.0)
        
        contentView.addSubview(cancelButton)
        cancelButton.anchor(top: messageButton.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 25.0, paddingLeft: 32.0, paddingRight: 32.0)
        
        contentView.addSubview(findButton)
        findButton.anchor(top: cancelButton.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 25.0, paddingLeft: 32.0, paddingRight: 32.0)
        
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCountDownLabel), userInfo: nil, repeats: true)
    }
    
    private func configureNavigationBar() {
        title = "Lift Offer Sent"
        navigationItem.backButtonTitle = ""
        
        navigationController?.navigationBar.barTintColor = .systemBlue
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30)]
        navigationController?.navigationBar.barStyle = .black
    }
    
    private func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.anchor(top: self.view.topAnchor,
                          bottom: self.view.bottomAnchor,
                          paddingTop: 0,
                          paddingBottom: 0)
        scrollView.trail(left: self.view.leadingAnchor,
                         right: self.view.trailingAnchor,
                         leftT: 0,
                         rightT: 0)
        
        scrollView.addSubview(contentView)
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true;
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true;
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true;
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true;
        
        contentView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true;
    }
    
    private func computeTimeLeft(timeInSeconds: Int) -> String {
        let days = countDownValue / 86400
        let hours = (countDownValue % 86400) / 3600
        let minutes = (countDownValue % 3600) / 60
        let seconds = (countDownValue % 3600) % 60
        let dayString = days == 1 ? "day" : "days"
        let hourString = hours == 1 ? "hour" : "hours"
        let minuteString = minutes == 1 ? "min" : "mins"
        let secondString = seconds == 1 ? "sec" : "secs"
        return "\(days) " + dayString + " \(hours) " + hourString + " \(minutes) " + minuteString + " \(seconds) " + secondString
    }
    
    // MARK: - Selectors
    
    @objc func updateCountDownLabel() {
        if countDownValue > 0 {
            countDownValue -= 1
            timeValueLabel.text = computeTimeLeft(timeInSeconds: countDownValue)
        } else {
            timeTitleLabel.removeFromSuperview()
            timeValueLabel.removeFromSuperview()
            amendButton.removeFromSuperview()
            messageButton.removeFromSuperview()
            cancelButton.removeFromSuperview()
            findButton.removeFromSuperview()
            if messagePassengerClicked == true {
                messageTextView.removeFromSuperview()
                sendButton.removeFromSuperview()
                messagePassengerClicked = false
            }
            contentView.addSubview(waitingLabel)
            waitingLabel.anchor(top: confirmLabel.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 25.0, paddingLeft: 32.0, paddingRight: 32.0)
        }
    }
    
    @objc func handleAmendOffer() {
        let controller = navigationController?.viewControllers[1]
        controller?.modalPresentationStyle = .fullScreen
        controller?.modalTransitionStyle = .crossDissolve
        navigationController?.popToViewController(controller!, animated: true)
    }
    
    @objc func handleMessagePassenger() {
        print("DEBUG: message passsenger clicked")
        
        messagePassengerClicked = true
        
        messageButton.removeFromSuperview()
        cancelButton.removeFromSuperview()
        findButton.removeFromSuperview()
        
        view.addSubview(messageTextView)
        messageTextView.anchor(top: amendButton.bottomAnchor, paddingTop: 25.0)
        messageTextView.centerX(inView: view)
        
        view.addSubview(sendButton)
        sendButton.anchor(top: messageTextView.bottomAnchor,
                          left: view.leftAnchor,
                          right: view.rightAnchor,
                          paddingTop: 25.0,
                          paddingLeft: 32,
                          paddingRight: 32)
        
        view.addSubview(cancelButton)
        cancelButton.anchor(top: sendButton.bottomAnchor,
                            left: view.leftAnchor,
                            right: view.rightAnchor,
                            paddingTop: 25.0,
                            paddingLeft: 32,
                            paddingRight: 32)
        
        view.addSubview(findButton)
        findButton.anchor(top: cancelButton.bottomAnchor,
                          left: view.leftAnchor,
                          right: view.rightAnchor,
                          paddingTop: 25.0,
                          paddingLeft: 32,
                          paddingRight: 32)
        
    }
    
    @objc func handleCancelOffer() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func handleOfferAnotherLift() {
        let controller = navigationController?.viewControllers[2]
        controller?.modalPresentationStyle = .fullScreen
        controller?.modalTransitionStyle = .crossDissolve
        navigationController?.popToViewController(controller!, animated: true)
    }
    
    @objc func handleSendMessage() {
        print("DEBUG: send message clicked")
        let controller = ChatVC()
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        navigationController?.pushViewController(controller, animated: true)
    }

}
