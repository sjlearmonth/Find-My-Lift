//
//  GroupSelectorView.swift
//  Find My Lift
//
//  Created by Stephen Learmonth on 02/10/2020.
//  Copyright © 2020 Stephen Learmonth. All rights reserved.
//

import UIKit

protocol GroupSelectorDelegate : class {
    func readGroupSelected(group: String)
}

class GroupSelectorView: UIView {
    
    // MARK: - Properties
    
    private let groupCategories : [String] = ["Work", "Gym", "College", "My Village", "Running", "Swimming", "Tennis"]
    
    weak var delegate: GroupSelectorDelegate?
    
    private var selectedGroup = ""
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Select Group"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        label.backgroundColor = .clear
        return label
    }()
    
    private lazy var groupSelector: UIPickerView = {
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
        if groupSelector.selectedRow(inComponent: 0) == 0 {
            delegate?.readGroupSelected(group: groupCategories[0])
        } else {
            delegate?.readGroupSelected(group: selectedGroup)
        }
        self.removeFromSuperview()
    }

    // MARK: - Helper Functions
    
    private func configureUI() {
        
        self.backgroundColor = .white
        
        self.addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, paddingTop: 16)
        titleLabel.centerX(inView: self)

        self.addSubview(groupSelector)
        groupSelector.centerX(inView: self)
        groupSelector.centerY(inView: self)
        groupSelector.setWidth(width: 250)
        
        self.addSubview(cancelButton)
        cancelButton.anchor(left: self.leftAnchor, bottom: self.bottomAnchor, paddingLeft: 16, paddingBottom: 0)
        
        self.addSubview(setButton)
        setButton.anchor(bottom: self.bottomAnchor, right: self.rightAnchor, paddingBottom: 0, paddingRight: 16)
    }
    
}

extension GroupSelectorView: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 25.0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return groupCategories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 175.0
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedGroup = groupCategories[row]
        print("DEBUG: selectedGroup: \(selectedGroup)")
        return
    }
    
}

extension GroupSelectorView: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return groupCategories.count
    }

}

