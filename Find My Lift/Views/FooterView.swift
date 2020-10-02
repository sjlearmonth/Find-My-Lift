//
//  FooterView.swift
//  Find My Lift
//
//  Created by Stephen Learmonth on 02/10/2020.
//  Copyright © 2020 Stephen Learmonth. All rights reserved.
//

import UIKit

class FooterView: UIView {
    
    // MARK: - Properties
    
    var groupSortRadioButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "Radio Button - Selected"), for: .normal)
        button.setDimensions(height: 25, width: 25)
        button.backgroundColor = .white
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(handleGroupSortRadioButton), for: .touchUpInside)
        return button
    }()

    var driverSortRadioButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "Radio Button - Unselected"), for: .normal)
        button.setDimensions(height: 25, width: 25)
        button.backgroundColor = .white
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(handleDriverSortRadioButton), for: .touchUpInside)
        return button
    }()

    var pickupTimeSortRadioButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "Radio Button - Unselected"), for: .normal)
        button.setDimensions(height: 25, width: 25)
        button.backgroundColor = .white
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(handlePickupTimeSortRadioButton), for: .touchUpInside)
        return button
    }()

    var allSortRadioButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "Radio Button - Unselected"), for: .normal)
        button.setDimensions(height: 25, width: 25)
        button.backgroundColor = .white
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(handleAllSortRadioButton), for: .touchUpInside)
        return button
    }()
    
    private let groupSortTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sort by group:"
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 18)
        label.backgroundColor = .white
        return label
    }()

    private let driverSortTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sort by driver:"
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 18)
        label.backgroundColor = .white
        return label
    }()

    private let pickupTimeSortTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sort by pickup time:"
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 18)
        label.backgroundColor = .white
        return label
    }()
    
    private let allSortTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "All"
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 18)
        label.backgroundColor = .white
        return label
    }()
    
    private let groupSortTextField: UITextField = {
        let tf = UITextField()
        tf.textColor = .black
        tf.textAlignment = .center
        tf.placeholder = "Work"
        tf.font = UIFont(name: "AvenirNext-DemiBold", size: 15)
        tf.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        tf.setWidth(width: 150)
        tf.layer.cornerRadius = 5
        return tf
    }()

    private let driverSortTextField: UITextField = {
        let tf = UITextField()
        tf.textColor = .black
        tf.textAlignment = .center
        tf.placeholder = "Louise"
        tf.font = UIFont(name: "AvenirNext-DemiBold", size: 15)
        tf.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        tf.setWidth(width: 150)
        tf.layer.cornerRadius = 5

        return tf
    }()

    private let pickupTimeSortTextField: UITextField = {
        let tf = UITextField()
        tf.textColor = .black
        tf.textAlignment = .center
        tf.placeholder = "2:00pm"
        tf.font = UIFont(name: "AvenirNext-DemiBold", size: 15)
        tf.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        tf.setWidth(width: 150)
        tf.layer.cornerRadius = 5

        return tf
    }()
    
    private enum radioButtonStates {
        case group
        case driver
        case pickupTime
        case all
    }
    
    private var radioButtonState = radioButtonStates.group
    
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
            switch radioButtonState {
            case .driver:
                driverSortRadioButton.setImage(UIImage(named: "Radio Button - Unselected"), for: .normal)
                driverSortTextField.isEnabled = false
                driverSortTextField.text = ""
            case .pickupTime:
                pickupTimeSortRadioButton.setImage(UIImage(named: "Radio Button - Unselected"), for: .normal)
                pickupTimeSortTextField.isEnabled = false
                pickupTimeSortTextField.text = ""
            case .all:
                allSortRadioButton.setImage(UIImage(named: "Radio Button - Unselected"), for: .normal)
            default:
                break
            }

            radioButtonState = .group
            groupSortRadioButton.setImage(UIImage(named: "Radio Button - Selected"), for: .normal)
            groupSortTextField.isEnabled = true
            groupSortTextField.text = ""
        }
        
    }

    @objc func handleDriverSortRadioButton() {
        
        if radioButtonState != .driver {
            switch radioButtonState {
            case .group:
                groupSortRadioButton.setImage(UIImage(named: "Radio Button - Unselected"), for: .normal)
                groupSortTextField.isEnabled = false
                groupSortTextField.text = ""
            case .pickupTime:
                pickupTimeSortRadioButton.setImage(UIImage(named: "Radio Button - Unselected"), for: .normal)
                pickupTimeSortTextField.isEnabled = false
                pickupTimeSortTextField.text = ""
            case .all:
                allSortRadioButton.setImage(UIImage(named: "Radio Button - Unselected"), for: .normal)
            default:
                break
            }

            radioButtonState = .driver
            driverSortRadioButton.setImage(UIImage(named: "Radio Button - Selected"), for: .normal)
            driverSortTextField.isEnabled = true
            driverSortTextField.text = ""
        }

    }

    @objc func handlePickupTimeSortRadioButton() {
        
        if radioButtonState != .pickupTime {
            switch radioButtonState {
            case .group:
                groupSortRadioButton.setImage(UIImage(named: "Radio Button - Unselected"), for: .normal)
                groupSortTextField.isEnabled = false
                groupSortTextField.text = ""
            case .driver:
                driverSortRadioButton.setImage(UIImage(named: "Radio Button - Unselected"), for: .normal)
                driverSortTextField.isEnabled = false
                driverSortTextField.text = ""
            case .all:
                allSortRadioButton.setImage(UIImage(named: "Radio Button - Unselected"), for: .normal)
            default:
                break
            }

            radioButtonState = .pickupTime
            pickupTimeSortRadioButton.setImage(UIImage(named: "Radio Button - Selected"), for: .normal)
            pickupTimeSortTextField.isEnabled = true
            pickupTimeSortTextField.text = ""
        }

    }

    @objc func handleAllSortRadioButton() {
        
        if radioButtonState != .all {
            switch radioButtonState {
            case .group:
                groupSortRadioButton.setImage(UIImage(named: "Radio Button - Unselected"), for: .normal)
                groupSortTextField.isEnabled = false
                groupSortTextField.text = ""
            case .driver:
                driverSortRadioButton.setImage(UIImage(named: "Radio Button - Unselected"), for: .normal)
                driverSortTextField.isEnabled = false
                driverSortTextField.text = ""
            case .pickupTime:
                pickupTimeSortRadioButton.setImage(UIImage(named: "Radio Button - Unselected"), for: .normal)
                pickupTimeSortTextField.isEnabled = false
                pickupTimeSortTextField.text = ""
            default:
                break
            }

            radioButtonState = .all
            allSortRadioButton.setImage(UIImage(named: "Radio Button - Selected"), for: .normal)
        }

    }

    // MARK: - Helper Functions
    
    private func configureUI() {
        
        let groupSortStackView = UIStackView(arrangedSubviews: [groupSortRadioButton,
                                                                groupSortTitleLabel,
                                                                groupSortTextField])
        groupSortStackView.axis = .horizontal
        groupSortStackView.distribution = .fill
        groupSortStackView.spacing = 5

        let driverSortStackView = UIStackView(arrangedSubviews: [driverSortRadioButton,
                                                                driverSortTitleLabel,
                                                                driverSortTextField])
        driverSortStackView.axis = .horizontal
        driverSortStackView.distribution = .fill
        driverSortStackView.spacing = 5

        let pickupTimeSortStackView = UIStackView(arrangedSubviews: [pickupTimeSortRadioButton,
                                                                pickupTimeSortTitleLabel,
                                                                pickupTimeSortTextField])
        pickupTimeSortStackView.axis = .horizontal
        pickupTimeSortStackView.distribution = .fill
        pickupTimeSortStackView.spacing = 5

        let allSortStackView = UIStackView(arrangedSubviews: [allSortRadioButton,
                                                              allSortTitleLabel])
        
        let stackView = UIStackView(arrangedSubviews: [groupSortStackView,driverSortStackView,pickupTimeSortStackView,allSortStackView])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        
        self.addSubview(stackView)
        stackView.centerX(inView: self)
        stackView.centerY(inView: self, constant: 50)
        
    }
    
}
