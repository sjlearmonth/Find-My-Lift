//
//  PendingDetailsVC.swift
//  Find My Lift
//
//  Created by Stephen Learmonth on 10/11/2020.
//  Copyright © 2020 Stephen Learmonth. All rights reserved.
//

import UIKit

class PendingDetailsVC: UIViewController {

    // MARK: - Properties
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    private let data: [String:String]

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 30.0)
        label.backgroundColor = .systemGreen
        label.setHeight(height: 60.0)
        label.layer.cornerRadius = 30.0
        label.layer.masksToBounds = true
        return label
    }()

    private lazy var startTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Start Location:"
        label.textColor = .white
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 20.0)
        label.backgroundColor = .clear
        return label
    }()

    private lazy var startValueLabel: UILabel = {
        let label = UILabel()
        label.text = data["Start"]
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "AvenirNext-Regular", size: 20.0)
        label.backgroundColor = .white
        label.setDimensions(height: 40.0, width: 120.0)
        label.layer.cornerRadius = 5.0
        label.layer.masksToBounds = true
        return label
    }()

    private lazy var endTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "End Location:"
        label.textColor = .white
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 20.0)
        label.backgroundColor = .clear
        return label
    }()

    private lazy var endValueLabel: UILabel = {
        let label = UILabel()
        label.text = data["End"]
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "AvenirNext-Regular", size: 20.0)
        label.backgroundColor = .white
        label.setDimensions(height: 40.0, width: 120.0)
        label.layer.cornerRadius = 5.0
        label.layer.masksToBounds = true
        return label
    }()
    
    private lazy var dateTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Date:"
        label.textColor = .white
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 20.0)
        label.backgroundColor = .clear
        return label
    }()

    private lazy var dateValueLabel: UILabel = {
        let label = UILabel()
        label.text = data["Date"]
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "AvenirNext-Regular", size: 20.0)
        label.backgroundColor = .white
        label.setDimensions(height: 40.0, width: 120.0)
        label.layer.cornerRadius = 5.0
        label.layer.masksToBounds = true
        return label
    }()

    private lazy var startTimeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Start Time:"
        label.textColor = .white
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 20.0)
        label.backgroundColor = .clear
        return label
    }()

    private lazy var startTimeValueLabel: UILabel = {
        let label = UILabel()
        label.text = data["Time"]
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "AvenirNext-Regular", size: 20.0)
        label.backgroundColor = .white
        label.setDimensions(height: 40.0, width: 120.0)
        label.layer.cornerRadius = 5.0
        label.layer.masksToBounds = true
        return label
    }()

    private lazy var journeyTimeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Journey Time:"
        label.textColor = .white
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 20.0)
        label.backgroundColor = .clear
        return label
    }()

    private lazy var journeyTimeValueLabel: UILabel = {
        let label = UILabel()
        label.text = "48 mins"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "AvenirNext-Regular", size: 20.0)
        label.backgroundColor = .white
        label.setDimensions(height: 40.0, width: 120.0)
        label.layer.cornerRadius = 5.0
        label.layer.masksToBounds = true
        return label
    }()

    private lazy var detourTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Detour:"
        label.textColor = .white
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 20.0)
        label.backgroundColor = .clear
        return label
    }()

    private lazy var detourValueLabel: UILabel = {
        let label = UILabel()
        label.text = data["Detour"]
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "AvenirNext-Regular", size: 20.0)
        label.backgroundColor = .white
        label.setDimensions(height: 40.0, width: 120.0)
        label.layer.cornerRadius = 5.0
        label.layer.masksToBounds = true
        return label
    }()

    private lazy var passengerTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Passengers:"
        label.textColor = .white
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 20.0)
        label.backgroundColor = .clear
        return label
    }()

    private lazy var passengerValueLabel: UILabel = {
        let label = UILabel()
        label.text = "2"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "AvenirNext-Regular", size: 20.0)
        label.backgroundColor = .white
        label.setDimensions(height: 40.0, width: 120.0)
        label.layer.cornerRadius = 5.0
        label.layer.masksToBounds = true
        return label
    }()

    private lazy var smokingTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Smoking:"
        label.textColor = .white
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 20.0)
        label.backgroundColor = .clear
        return label
    }()

    private lazy var smokingValueLabel: UILabel = {
        let label = UILabel()
        label.text = "No"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "AvenirNext-Regular", size: 20.0)
        label.backgroundColor = .white
        label.setDimensions(height: 40.0, width: 120.0)
        label.layer.cornerRadius = 5.0
        label.layer.masksToBounds = true
        return label
    }()

    private lazy var chargeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Charge:"
        label.textColor = .white
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 20.0)
        label.backgroundColor = .clear
        return label
    }()

    private lazy var chargeValueLabel: UILabel = {
        let label = UILabel()
        label.text = "Yes"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "AvenirNext-Regular", size: 20.0)
        label.backgroundColor = .white
        label.setDimensions(height: 40.0, width: 120.0)
        label.layer.cornerRadius = 5.0
        label.layer.masksToBounds = true
        return label
    }()

    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.isScrollEnabled = true
        sv.bounces = false
        sv.showsVerticalScrollIndicator = false
        return sv
    }()
    
    private lazy var contentView: UIView = {
        let cv = UIView()
        cv.frame.size = CGSize(width: self.view.frame.width, height: self.view.frame.height * 2.0)
        return cv
    }()

    // MARK: -  Lifecycle
    
    init(data: [String:String]) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        configureScrollView()

    }
    
    // MARK: - Helper Functions
    
    private func configureUI() {
        
        configureGradientLayer()
        
        navigationItem.title = "Pending Details"
        navigationItem.backButtonTitle = ""

        navigationController?.navigationBar.barTintColor = .systemBlue
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30)]
        navigationController?.navigationBar.barStyle = .black
        
        if data["PendingType"] == "LiftOffered" {
            titleLabel.text = "Lift Offered"
        } else {
            titleLabel.text = "Lift Accepted"
        }
        contentView.addSubview(titleLabel)
        titleLabel.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 25.0, paddingLeft: 32.0, paddingRight: 32.0)
        
        contentView.addSubview(startTitleLabel)
        startTitleLabel.anchor(top: titleLabel.bottomAnchor, left: contentView.leftAnchor, paddingTop: 40.0, paddingLeft: 32.0)
        
        contentView.addSubview(startValueLabel)
        startValueLabel.anchor(right: contentView.rightAnchor, paddingRight: 32.0)
        startValueLabel.centerY(inView: startTitleLabel)

        contentView.addSubview(endTitleLabel)
        endTitleLabel.anchor(top: startValueLabel.bottomAnchor, left: contentView.leftAnchor, paddingTop: 25.0, paddingLeft: 32.0)
        
        contentView.addSubview(endValueLabel)
        endValueLabel.anchor(right: contentView.rightAnchor, paddingRight: 32.0)
        endValueLabel.centerY(inView: endTitleLabel)
        
        contentView.addSubview(dateTitleLabel)
        dateTitleLabel.anchor(top: endValueLabel.bottomAnchor, left: contentView.leftAnchor, paddingTop: 25.0, paddingLeft: 32.0)
        
        contentView.addSubview(dateValueLabel)
        dateValueLabel.anchor(right: contentView.rightAnchor, paddingRight: 32.0)
        dateValueLabel.centerY(inView: dateTitleLabel)
        
        contentView.addSubview(startTimeTitleLabel)
        startTimeTitleLabel.anchor(top: dateValueLabel.bottomAnchor, left: contentView.leftAnchor, paddingTop: 25.0, paddingLeft: 32.0)
        
        contentView.addSubview(startTimeValueLabel)
        startTimeValueLabel.anchor(right: contentView.rightAnchor, paddingRight: 32.0)
        startTimeValueLabel.centerY(inView: startTimeTitleLabel)

        contentView.addSubview(journeyTimeTitleLabel)
        journeyTimeTitleLabel.anchor(top: startTimeValueLabel.bottomAnchor, left: contentView.leftAnchor, paddingTop: 25.0, paddingLeft: 32.0)
        
        contentView.addSubview(journeyTimeValueLabel)
        journeyTimeValueLabel.anchor(right: contentView.rightAnchor, paddingRight: 32.0)
        journeyTimeValueLabel.centerY(inView: journeyTimeTitleLabel)

        if data["PendingType"] == "LiftOffered" {

            contentView.addSubview(detourTitleLabel)
            detourTitleLabel.anchor(top: journeyTimeValueLabel.bottomAnchor, left: contentView.leftAnchor, paddingTop: 25.0, paddingLeft: 32.0)
            
            contentView.addSubview(detourValueLabel)
            detourValueLabel.anchor(right: contentView.rightAnchor, paddingRight: 32.0)
            detourValueLabel.centerY(inView: detourTitleLabel)
            
            contentView.addSubview(passengerTitleLabel)
            passengerTitleLabel.anchor(top: detourValueLabel.bottomAnchor, left: contentView.leftAnchor, paddingTop: 25.0, paddingLeft: 32.0)
            
            contentView.addSubview(passengerValueLabel)
            passengerValueLabel.anchor(right: contentView.rightAnchor, paddingRight: 32.0)
            passengerValueLabel.centerY(inView: passengerTitleLabel)
            
            contentView.addSubview(smokingTitleLabel)
            smokingTitleLabel.anchor(top: passengerValueLabel.bottomAnchor, left: contentView.leftAnchor, paddingTop: 25.0, paddingLeft: 32.0)
            
            contentView.addSubview(smokingValueLabel)
            smokingValueLabel.anchor(right: contentView.rightAnchor, paddingRight: 32.0)
            smokingValueLabel.centerY(inView: smokingTitleLabel)

            contentView.addSubview(chargeTitleLabel)
            chargeTitleLabel.anchor(top: smokingValueLabel.bottomAnchor, left: contentView.leftAnchor, paddingTop: 25.0, paddingLeft: 32.0)
            
            contentView.addSubview(chargeValueLabel)
            chargeValueLabel.anchor(right: contentView.rightAnchor, paddingRight: 32.0)
            chargeValueLabel.centerY(inView: chargeTitleLabel)

            
        }
        
        else {
            
        }

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


}
