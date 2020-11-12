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
    
    private lazy var driverTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Driver:"
        label.textColor = .white
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 20.0)
        label.backgroundColor = .clear
        return label
    }()

    private lazy var driverValueLabel: UILabel = {
        let label = UILabel()
        label.text = data["Driver"]
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "AvenirNext-Regular", size: 20.0)
        label.backgroundColor = .white
        label.setDimensions(height: 40.0, width: 120.0)
        label.layer.cornerRadius = 5.0
        label.layer.masksToBounds = true
        return label
    }()

    private lazy var regTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Registration:"
        label.textColor = .white
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 20.0)
        label.backgroundColor = .clear
        return label
    }()

    private lazy var regValueLabel: UILabel = {
        let label = UILabel()
        label.text = data["Reg"]
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "AvenirNext-Regular", size: 20.0)
        label.backgroundColor = .white
        label.setDimensions(height: 40.0, width: 120.0)
        label.layer.cornerRadius = 5.0
        label.layer.masksToBounds = true
        return label
    }()

    private lazy var colourTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Vehicle Colour:"
        label.textColor = .white
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 20.0)
        label.backgroundColor = .clear
        return label
    }()

    private lazy var colourValueLabel: UILabel = {
        let label = UILabel()
        label.text = data["Colour"]
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "AvenirNext-Regular", size: 20.0)
        label.backgroundColor = .white
        label.setDimensions(height: 40.0, width: 120.0)
        label.layer.cornerRadius = 5.0
        label.layer.masksToBounds = true
        return label
    }()
    
    private lazy var pickupTimeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Pickup Time:"
        label.textColor = .white
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 20.0)
        label.backgroundColor = .clear
        return label
    }()

    private lazy var pickupTimeValueLabel: UILabel = {
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
    
    private lazy var editLiftButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit Lift", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGreen
        button.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 20.0)
        button.setHeight(height: 50.0)
        button.layer.cornerRadius = 25.0
        button.addTarget(self, action: #selector(handleEditLiftButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var cancelLiftButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancel Lift", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGreen
        button.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 20.0)
        button.setHeight(height: 50.0)
        button.layer.cornerRadius = 25.0
        button.addTarget(self, action: #selector(handleCancelLiftButton), for: .touchUpInside)
        return button
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

            contentView.addSubview(detourTitleLabel)
            detourTitleLabel.anchor(top: startTimeValueLabel.bottomAnchor, left: contentView.leftAnchor, paddingTop: 25.0, paddingLeft: 32.0)
            
            contentView.addSubview(detourValueLabel)
            detourValueLabel.anchor(right: contentView.rightAnchor, paddingRight: 32.0)
            detourValueLabel.centerY(inView: detourTitleLabel)
            
            contentView.addSubview(editLiftButton)
            editLiftButton.anchor(top: detourValueLabel.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 25.0, paddingLeft: 32.0, paddingRight: 32.0)

            contentView.addSubview(cancelLiftButton)
            cancelLiftButton.anchor(top: editLiftButton.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 25.0, paddingLeft: 32.0, paddingRight: 32.0)

        } else {
            
            titleLabel.text = "Lift Accepted"
            
            contentView.addSubview(titleLabel)
            titleLabel.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 25.0, paddingLeft: 32.0, paddingRight: 32.0)
            
            contentView.addSubview(driverTitleLabel)
            driverTitleLabel.anchor(top: titleLabel.bottomAnchor, left: contentView.leftAnchor, paddingTop: 25.0, paddingLeft: 32.0)
            
            contentView.addSubview(driverValueLabel)
            driverValueLabel.anchor(right: contentView.rightAnchor, paddingRight: 32.0)
            driverValueLabel.centerY(inView: driverTitleLabel)

            contentView.addSubview(regTitleLabel)
            regTitleLabel.anchor(top: driverValueLabel.bottomAnchor, left: contentView.leftAnchor, paddingTop: 25.0, paddingLeft: 32.0)
            
            contentView.addSubview(regValueLabel)
            regValueLabel.anchor(right: contentView.rightAnchor, paddingRight: 32.0)
            regValueLabel.centerY(inView: regTitleLabel)

            contentView.addSubview(colourTitleLabel)
            colourTitleLabel.anchor(top: regValueLabel.bottomAnchor, left: contentView.leftAnchor, paddingTop: 25.0, paddingLeft: 32.0)
            
            contentView.addSubview(colourValueLabel)
            colourValueLabel.anchor(right: contentView.rightAnchor, paddingRight: 32.0)
            colourValueLabel.centerY(inView: colourTitleLabel)

            contentView.addSubview(dateTitleLabel)
            dateTitleLabel.anchor(top: colourValueLabel.bottomAnchor, left: contentView.leftAnchor, paddingTop: 25.0, paddingLeft: 32.0)
            
            contentView.addSubview(dateValueLabel)
            dateValueLabel.anchor(right: contentView.rightAnchor, paddingRight: 32.0)
            dateValueLabel.centerY(inView: dateTitleLabel)

            contentView.addSubview(pickupTimeTitleLabel)
            pickupTimeTitleLabel.anchor(top: dateValueLabel.bottomAnchor, left: contentView.leftAnchor, paddingTop: 25.0, paddingLeft: 32.0)
            
            contentView.addSubview(pickupTimeValueLabel)
            pickupTimeValueLabel.anchor(right: contentView.rightAnchor, paddingRight: 32.0)
            pickupTimeValueLabel.centerY(inView: pickupTimeTitleLabel)
            
            contentView.addSubview(editLiftButton)
            editLiftButton.anchor(top: pickupTimeValueLabel.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 25.0, paddingLeft: 32.0, paddingRight: 32.0)

            contentView.addSubview(cancelLiftButton)
            cancelLiftButton.anchor(top: editLiftButton.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 25.0, paddingLeft: 32.0, paddingRight: 32.0)


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

    // MARK: - Selectors
    
    @objc func handleEditLiftButton() {
        print("DEBUG: edit lift button clicked")
        let controller = PendingEditVC(data: data)
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func handleCancelLiftButton() {
        print("DEBUG: cancel lift button clicked")
        navigationController?.popViewController(animated: true)
    }

}
