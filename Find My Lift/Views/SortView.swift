//
//  SortView.swift
//  Find My Lift
//
//  Created by Stephen Learmonth on 19/10/2020.
//  Copyright © 2020 Stephen Learmonth. All rights reserved.
//

import UIKit

protocol SortViewDelegate: class {
    func executeDynamicSearch(query: String, type: Int)
}

class SortView: UIView {
    
    // MARK: - Properties
    
    private lazy var driverSortRadioButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "Radio Button - Selected"), for: .normal)
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

    private let driverSortTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sort by driver:"
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
    
    private lazy var driverSortTextField: UITextField = {
        let tf = UITextField()
        tf.textColor = .black
        tf.textAlignment = .center
        tf.placeholder = "Louise"
        tf.font = UIFont(name: "AvenirNext-DemiBold", size: 15)
        tf.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        tf.setWidth(width: 150)
        tf.layer.cornerRadius = 5
        tf.delegate = self
        return tf
    }()

    private lazy var pickupTimeSortTextField: UITextField = {
        let tf = UITextField()
        tf.textColor = .black
        tf.textAlignment = .center
        tf.placeholder = "2:00pm"
        tf.font = UIFont(name: "AvenirNext-DemiBold", size: 15)
        tf.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        tf.setWidth(width: 150)
        tf.layer.cornerRadius = 5
        tf.delegate = self
        return tf
    }()
    
    enum radioButtonStates : Int {
        case driver
        case pickupTime
    }
    
    private var radioButtonState = radioButtonStates.driver
    
    weak var delegate: SortViewDelegate?
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Selectors
    
    @objc func handleDriverSortRadioButton() {
    
        if radioButtonState != .driver {
            pickupTimeSortRadioButton.setImage(UIImage(named: "Radio Button - Unselected"), for: .normal)
            pickupTimeSortTextField.isEnabled = false
            pickupTimeSortTextField.text = ""
            
            radioButtonState = .driver
            driverSortRadioButton.setImage(UIImage(named: "Radio Button - Selected"), for: .normal)
            driverSortTextField.isEnabled = true
            driverSortTextField.text = ""
        }

    }

    @objc func handlePickupTimeSortRadioButton() {
        
        if radioButtonState != .pickupTime {

            driverSortRadioButton.setImage(UIImage(named: "Radio Button - Unselected"), for: .normal)
            driverSortTextField.isEnabled = false
            driverSortTextField.text = ""

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

        let stackView = UIStackView(arrangedSubviews:[driverSortStackView,
                                                      pickupTimeSortStackView])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        
        self.addSubview(stackView)
        stackView.centerX(inView: self)
        stackView.centerY(inView: self)
    }
}

extension SortView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return false
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("DEBUG: delegate method called text is \(string)")
        delegate?.executeDynamicSearch(query: textField.text ?? "", type: radioButtonState.rawValue)
        return true
    }

}
