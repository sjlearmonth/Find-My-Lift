//
//  TimeSelectorView.swift
//  Find My Lift
//
//  Created by Stephen Learmonth on 01/10/2020.
//  Copyright © 2020 Stephen Learmonth. All rights reserved.
//

import UIKit

protocol TimeSelectorDelegate: class {
    func readTimeSelected(time: Date)
}

class TimeSelectorView: UIView {

    // MARK: - Properties
    
    weak var delegate: TimeSelectorDelegate?
    
    private lazy var timeSelector: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .time
        dp.preferredDatePickerStyle = .wheels
        dp.setHeight(height: 150)
        dp.timeZone = .current
        return dp
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Set Time"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        label.backgroundColor = .clear
        return label
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setHeight(height: 50)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.addTarget(self, action: #selector(handleCancelClicked), for: .touchUpInside)
        return button
    }()
    
    private lazy var setButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Set", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setHeight(height: 50)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.addTarget(self, action: #selector(handleSetClicked), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - selectors
        
    @objc func handleCancelClicked() {
        self.removeFromSuperview()
    }
    
    @objc func handleSetClicked() {
        delegate?.readTimeSelected(time: timeSelector.date)
        self.removeFromSuperview()
    }
    
    // MARK: - Helper Functions
    
    private func configureUI() {
        
        self.backgroundColor = .white
        
        self.addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, paddingTop: 16)
        titleLabel.centerX(inView: self)
        
        self.addSubview(timeSelector)
        timeSelector.centerY(inView: self)
        timeSelector.centerX(inView: self)
        
        self.addSubview(cancelButton)
        cancelButton.anchor(left: self.leftAnchor, bottom: self.bottomAnchor, paddingLeft: 16, paddingBottom: 0)
        
        self.addSubview(setButton)
        setButton.anchor(bottom: self.bottomAnchor, right: self.rightAnchor, paddingBottom: 0, paddingRight: 16)

    }
}
