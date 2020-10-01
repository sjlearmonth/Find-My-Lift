//
//  PassengerSelectorView.swift
//  Find My Lift
//
//  Created by Stephen Learmonth on 01/10/2020.
//  Copyright © 2020 Stephen Learmonth. All rights reserved.
//

import UIKit

protocol PassengerSelectorDelegate : class {
    func readPassengerCount(count: String)
}

class PassengerSelectorView: UIView {
    
    // MARK: - Properties
    
    private let passengerCount : [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    
    weak var delegate: PassengerSelectorDelegate?
    
    private var selectedPassengerCount = ""
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Set Number of Passengers"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        label.backgroundColor = .clear
        return label
    }()
    
    private lazy var passengerCountSelector: UIPickerView = {
        let pv = UIPickerView()
        pv.delegate = self
        pv.dataSource = self
        pv.clipsToBounds = true
        return pv
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

    
    // MARK: - Lifecycle
    
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
        delegate?.readPassengerCount(count: selectedPassengerCount)
        self.removeFromSuperview()
    }

    // MARK: - Helper Functions
    
    private func configureUI() {
        
        self.backgroundColor = .white
        
        self.addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, paddingTop: 16)
        titleLabel.centerX(inView: self)

        self.addSubview(passengerCountSelector)
        passengerCountSelector.centerX(inView: self)
        passengerCountSelector.centerY(inView: self)
        passengerCountSelector.setWidth(width: 100)
        
        self.addSubview(cancelButton)
        cancelButton.anchor(left: self.leftAnchor, bottom: self.bottomAnchor, paddingLeft: 16, paddingBottom: 0)
        
        self.addSubview(setButton)
        setButton.anchor(bottom: self.bottomAnchor, right: self.rightAnchor, paddingBottom: 0, paddingRight: 16)

    }
    
}

extension PassengerSelectorView: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 25.0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return passengerCount[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 75.0
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedPassengerCount = passengerCount[row]
        return
    }
    
    
}

extension PassengerSelectorView: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return passengerCount.count
    }

}
