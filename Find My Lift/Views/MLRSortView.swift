//
//  MLRSortView.swift
//  Find My Lift
//
//  Created by Stephen Learmonth on 26/10/2020.
//  Copyright © 2020 Stephen Learmonth. All rights reserved.
//

import UIKit

protocol MLRSortViewDelegate: class {
    func executeDynamicSearch(query: String, type: radioButtonStates)
}

class MLRSortView: UIView {
    
    // MARK: - Properties
    
    private lazy var groupSortRadioButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "Radio Button - Selected"), for: .normal)
        button.setDimensions(height: 25, width: 25)
        button.backgroundColor = .clear
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(handleGroupSortRadioButton), for: .touchUpInside)
        button.isEnabled = true
        return button
    }()

    private lazy var passengerSortRadioButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "Radio Button - Unselected"), for: .normal)
        button.setDimensions(height: 25, width: 25)
        button.backgroundColor = .clear
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(handleDriverSortRadioButton), for: .touchUpInside)
        button.isEnabled = true
        return button
    }()

    private lazy var pickupTimeSortRadioButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "Radio Button - Unselected"), for: .normal)
        button.setDimensions(height: 25, width: 25)
        button.backgroundColor = .clear
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(handlePickupTimeSortRadioButton), for: .touchUpInside)
        button.isEnabled = true
        return button
    }()

    private let groupSortTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sort by group:"
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 18)
        label.backgroundColor = .clear
        return label
    }()

    private let passengerSortTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sort by passenger:"
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 18)
        label.backgroundColor = .clear
        return label
    }()

    private let pickupTimeSortTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sort by pickup time:"
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 18)
        label.backgroundColor = .clear
        return label
    }()
    
    private lazy var groupSortTextField: UITextField = {
        let tf = UITextField()
        tf.textColor = .black
        tf.textAlignment = .center
        tf.placeholder = "Work"
        tf.font = UIFont(name: "AvenirNext-DemiBold", size: 15)
        tf.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        tf.setWidth(width: 100)
        tf.layer.cornerRadius = 5
        tf.delegate = self
        tf.returnKeyType = .done
        return tf
    }()

    private lazy var passengerSortTextField: UITextField = {
        let tf = UITextField()
        tf.textColor = .black
        tf.textAlignment = .center
        tf.placeholder = "Louise"
        tf.font = UIFont(name: "AvenirNext-DemiBold", size: 15)
        tf.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        tf.setWidth(width: 100)
        tf.layer.cornerRadius = 5
        tf.delegate = self
        tf.returnKeyType = .done
        return tf
    }()

    private lazy var pickupTimeSortTextField: UITextField = {
        let tf = UITextField()
        tf.textColor = .black
        tf.textAlignment = .center
        tf.placeholder = "2:00pm"
        tf.font = UIFont(name: "AvenirNext-DemiBold", size: 15)
        tf.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        tf.setWidth(width: 100)
        tf.layer.cornerRadius = 5
        tf.delegate = self
        tf.returnKeyType = .done
        return tf
    }()
        
    private var radioButtonState = radioButtonStates.group
    
    weak var delegate: MLRSortViewDelegate?
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Selectors
    
    @objc func handleGroupSortRadioButton() {
        if radioButtonState != .group {
            passengerSortRadioButton.setImage(UIImage(named: "Radio Button - Unselected"), for: .normal)
            passengerSortTextField.isEnabled = false
            passengerSortTextField.text = ""

            pickupTimeSortRadioButton.setImage(UIImage(named: "Radio Button - Unselected"), for: .normal)
            pickupTimeSortTextField.isEnabled = false
            pickupTimeSortTextField.text = ""
            
            radioButtonState = .group
            groupSortRadioButton.setImage(UIImage(named: "Radio Button - Selected"), for: .normal)
            groupSortTextField.isEnabled = true
            groupSortTextField.text = ""
        }

    }
    
    @objc func handleDriverSortRadioButton() {
    
        if radioButtonState != .passenger {
            groupSortRadioButton.setImage(UIImage(named: "Radio Button - Unselected"), for: .normal)
            groupSortTextField.isEnabled = false
            groupSortTextField.text = ""

            pickupTimeSortRadioButton.setImage(UIImage(named: "Radio Button - Unselected"), for: .normal)
            pickupTimeSortTextField.isEnabled = false
            pickupTimeSortTextField.text = ""
            
            radioButtonState = .passenger
            passengerSortRadioButton.setImage(UIImage(named: "Radio Button - Selected"), for: .normal)
            passengerSortTextField.isEnabled = true
            passengerSortTextField.text = ""
        }

    }

    @objc func handlePickupTimeSortRadioButton() {
        
        if radioButtonState != .pickupTime {

            groupSortRadioButton.setImage(UIImage(named: "Radio Button - Unselected"), for: .normal)
            groupSortTextField.isEnabled = false
            groupSortTextField.text = ""

            passengerSortRadioButton.setImage(UIImage(named: "Radio Button - Unselected"), for: .normal)
            passengerSortTextField.isEnabled = false
            passengerSortTextField.text = ""

            radioButtonState = .pickupTime
            pickupTimeSortRadioButton.setImage(UIImage(named: "Radio Button - Selected"), for: .normal)
            pickupTimeSortTextField.isEnabled = true
            pickupTimeSortTextField.text = ""
        }
    }
    
    @objc func handleClickMe() {
        print("DEBUG: click me clicked")
    }

    // MARK: - Helper Functions
    
    private func configureUI() {
        
        let groupSortStackView = UIStackView(arrangedSubviews: [groupSortRadioButton,
                                                                groupSortTitleLabel,
                                                                groupSortTextField])
        groupSortStackView.axis = .horizontal
        groupSortStackView.distribution = .fill
        groupSortStackView.spacing = 5

        let passengerSortStackView = UIStackView(arrangedSubviews: [passengerSortRadioButton,
                                                                passengerSortTitleLabel,
                                                                passengerSortTextField])
        passengerSortStackView.axis = .horizontal
        passengerSortStackView.distribution = .fill
        passengerSortStackView.spacing = 5

        let pickupTimeSortStackView = UIStackView(arrangedSubviews: [pickupTimeSortRadioButton,
                                                                     pickupTimeSortTitleLabel,
                                                                     pickupTimeSortTextField])
        pickupTimeSortStackView.axis = .horizontal
        pickupTimeSortStackView.distribution = .fill
        pickupTimeSortStackView.spacing = 5

        let stackView = UIStackView(arrangedSubviews:[groupSortStackView,
                                                      passengerSortStackView,
                                                      pickupTimeSortStackView])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        
        self.addSubview(stackView)
        stackView.centerX(inView: self)
        stackView.centerY(inView: self)
    }
}

extension MLRSortView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return false
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var searchString = ""
        guard let textString = textField.text else { return true }
        if string.isEmpty {
            searchString = ""
        } else {
            searchString = textString + string
        }
        delegate?.executeDynamicSearch(query: searchString, type: radioButtonState)
        return true
    }
}

