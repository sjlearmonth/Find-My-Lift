//
//  LiftRequestDetailsVC.swift
//  Find My Lift
//
//  Created by Stephen Learmonth on 30/09/2020.
//  Copyright © 2020 Stephen Learmonth. All rights reserved.
//

import UIKit

class LiftRequestDetailsVC: UIViewController {

    // MARK: - Properties
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private let pickupLocationLabel: UILabel = {
        let label = UILabel()
        label.text = "Pickup:"
        label.textColor = UIColor(white: 1.0, alpha: 1.0)
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 20)
        return label
    }()

    private let pickupLocationTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "LU6 1AW"
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 5
        textField.setDimensions(height: 35, width: 150)
        textField.textAlignment = .center
        return textField
    }()

    private let pickupLocationDisclosure: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrowtriangle.down.fill"), for: .normal)
        button.setDimensions(height: 25, width: 25)
        button.addTarget(self, action: #selector(handleDisclosure), for: .touchUpInside)
        button.isHidden = false
        button.isEnabled = true
        button.tintColor = .white
        return button
    }()
    
    private let destinationLocationLabel: UILabel = {
        let label = UILabel()
        label.text = "Destination:"
        label.textColor = UIColor(white: 1.0, alpha: 1.0)
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 20)
        return label
    }()
    
    private let destinationLocationTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "NN14 7NU"
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 5
        textField.setDimensions(height: 35, width: 150)
        textField.textAlignment = .center
        return textField
    }()
    
    private let destinationLocationDisclosure: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrowtriangle.down.fill"), for: .normal)
        button.setDimensions(height: 25, width: 25)
        button.addTarget(self, action: #selector(handleDisclosure), for: .touchUpInside)
        button.isHidden = false
        button.isEnabled = true
        button.tintColor = .white
        return button
    }()
    
    private let selectDateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select Date", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 20)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(handleSelectDateClicked), for: .touchUpInside)
        return button
    }()

    private let selectedDateLabel: UILabel = {
        let label = UILabel()
        label.text = "01-10-2020"
        label.textColor = .black
        label.backgroundColor = .white
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.font = UIFont(name: "AvenirNext-Regular", size: 20)
        return label
    }()
    
    private let selectTimeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select Time", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 20)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(handleSelectTimeClicked), for: .touchUpInside)
        return button
    }()

    private let selectedTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "12:18 hrs"
        label.textColor = .black
        label.backgroundColor = .white
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.font = UIFont(name: "AvenirNext-Regular", size: 20)
        return label
    }()
    
    private lazy var dateSelectorView: DateSelectorView = {
        let dsv = DateSelectorView()
        dsv.delegate = self
        dsv.setWidth(width: 350)
        dsv.setHeight(height: 250)
        return dsv
    }()

    private lazy var timeSelectorView: TimeSelectorView = {
        let tsv = TimeSelectorView()
        tsv.delegate = self
        tsv.setWidth(width: 350)
        tsv.setHeight(height: 250)
        return tsv
    }()
    
    private let passengerCountButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Set Passenger Count", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 20)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(handlePassengerCountClicked), for: .touchUpInside)
        return button
    }()
    
    private let passengerCountLabel: UILabel = {
        let label = UILabel()
        label.text = "2"
        label.textColor = .black
        label.backgroundColor = .white
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.font = UIFont(name: "AvenirNext-Regular", size: 20)
        label.setWidth(width: 50)
        return label
    }()
    
    private lazy var passengerSelectorView : PassengerSelectorView = {
        let psv = PassengerSelectorView()
        psv.delegate = self
        psv.setWidth(width: 350)
        psv.setHeight(height: 250)
        return psv
    }()
    
    private let groupSelectionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select Group", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 20)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(handleSelectGroupClicked), for: .touchUpInside)

        return button
    }()
    
    private let selectedGroupLabel: UILabel = {
        let label = UILabel()
        label.text = "Work"
        label.textColor = .black
        label.backgroundColor = .white
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.font = UIFont(name: "AvenirNext-Regular", size: 20)
        label.setWidth(width: 175)
        return label
    }()
    
    private let groupsView = GroupsView()
    
    private let checkLiftAvailabilityButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Check Lift Availability", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 30)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 30
        button.addTarget(self, action: #selector(handleCheckForLiftClicked), for: .touchUpInside)

        return button
    }()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - Selectors
    
    @objc func handleDisclosure() {
        print("DEBUG: handle pickup disclosure clicked")
    }
    
    @objc func handleSelectDateClicked() {
        view.addSubview(dateSelectorView)
        dateSelectorView.centerX(inView: view)
        dateSelectorView.centerY(inView: view)
        return
    }
    
    @objc func handleSelectTimeClicked() {
        view.addSubview(timeSelectorView)
        timeSelectorView.centerX(inView: view)
        timeSelectorView.centerY(inView: view)
        return
    }
    
    @objc func handlePassengerCountClicked() {
        view.addSubview(passengerSelectorView)
        passengerSelectorView.centerX(inView: view)
        passengerSelectorView.centerY(inView: view)
        return
    }
    
    @objc func handleSelectGroupClicked() {
        print("DEBUG: handle select group clicked")
        view.addSubview(groupsView)
        groupsView.groupsViewDelegate = self
        groupsView.centerX(inView: view)
        groupsView.centerY(inView: view)
        return
    }
    
    @objc func handleCheckForLiftClicked() {
        print("DEBUG: check for lift clicked")
    }
    
    // MARK: - Helper Functions
    private func configureUI() {
        
        configureGradientLayer()
        
        title = "Lift Request Details"

        navigationController?.navigationBar.barTintColor = .systemBlue
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30)]
        navigationController?.navigationBar.barStyle = .black
        
        let pickupStackView = UIStackView(arrangedSubviews: [pickupLocationLabel,
                                                             pickupLocationTextField,
                                                             pickupLocationDisclosure])
        pickupStackView.axis = .horizontal
        pickupStackView.distribution = .fill
        pickupStackView.spacing = 5
        
        let destinationStackView = UIStackView(arrangedSubviews: [destinationLocationLabel,
                                                                  destinationLocationTextField,
                                                                  destinationLocationDisclosure])
        destinationStackView.axis = .horizontal
        destinationStackView.distribution = .fill
        destinationStackView.spacing = 5

        view.addSubview(pickupStackView)
        pickupStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                               left: view.leftAnchor,
                               right: view.rightAnchor, paddingTop: 40, paddingLeft: 32, paddingRight: 32,
                               height: 35)
        
        view.addSubview(destinationStackView)
        destinationStackView.anchor(top: pickupStackView.bottomAnchor,
                               left: view.leftAnchor,
                               right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32,
                               height: 35)

        let dateStackView = UIStackView(arrangedSubviews: [selectDateButton,
                                                           selectedDateLabel])
        dateStackView.axis = .horizontal
        dateStackView.distribution = .fillEqually
        dateStackView.spacing = 20
        
        view.addSubview(dateStackView)
        dateStackView.anchor(top: destinationStackView.bottomAnchor,
                                 left: view.leftAnchor,
                                 right: view.rightAnchor,
                                 paddingTop: 32,
                                 paddingLeft: 32,
                                 paddingRight: 32)

        let timeStackView = UIStackView(arrangedSubviews: [selectTimeButton,
                                                           selectedTimeLabel])
        timeStackView.axis = .horizontal
        timeStackView.distribution = .fillEqually
        timeStackView.spacing = 20
        
        view.addSubview(timeStackView)
        timeStackView.anchor(top: dateStackView.bottomAnchor,
                                 left: view.leftAnchor,
                                 right: view.rightAnchor,
                                 paddingTop: 32,
                                 paddingLeft: 32,
                                 paddingRight: 32)

        let passengerCountStackView = UIStackView(arrangedSubviews: [passengerCountButton,
                                                                     passengerCountLabel])
        passengerCountStackView.axis = .horizontal
        passengerCountStackView.distribution = .fill
        passengerCountStackView.spacing = 20
        
        view.addSubview(passengerCountStackView)
        passengerCountStackView.anchor(top: timeStackView.bottomAnchor,
                                       left: view.leftAnchor,
                                       right: view.rightAnchor,
                                       paddingTop: 32,
                                       paddingLeft: 32,
                                       paddingRight: 32)
        
        let selectedGroupStackView = UIStackView(arrangedSubviews: [groupSelectionButton,
                                                                    selectedGroupLabel])
        selectedGroupStackView.axis = .horizontal
        selectedGroupStackView.distribution = .fill
        selectedGroupStackView.spacing = 20
        
        view.addSubview(selectedGroupStackView)
        selectedGroupStackView.anchor(top: passengerCountStackView.bottomAnchor,
                                      left: view.leftAnchor,
                                      right: view.rightAnchor,
                                      paddingTop: 32,
                                      paddingLeft: 32,
                                      paddingRight: 32)
        
        view.addSubview(checkLiftAvailabilityButton)
        checkLiftAvailabilityButton.centerX(inView: view)
        checkLiftAvailabilityButton.anchor(left: view.leftAnchor,
                                           bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                           right: view.rightAnchor,
                                           paddingLeft: 32,
                                           paddingBottom: 32,
                                           paddingRight: 32)
        
        
        for family in UIFont.familyNames {
                print("family:", family)
                for font in UIFont.fontNames(forFamilyName: family) {
                    print("font:", font)
                }
            }
    }
}

extension LiftRequestDetailsVC: DateSelectorDelegate {
    func readDateSelected(date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_GB")
        dateFormatter.setLocalizedDateFormatFromTemplate("dd/MM/YYYY")
        let dateString = dateFormatter.string(from: date)
        selectedDateLabel.text = dateString
        return
    }
}

extension LiftRequestDetailsVC: TimeSelectorDelegate {
    func readTimeSelected(time: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_GB")
        dateFormatter.setLocalizedDateFormatFromTemplate("HH:mm")
        let timeString = dateFormatter.string(from: time)
        selectedTimeLabel.text = timeString + " hrs"
        return
    }
}

extension LiftRequestDetailsVC: PassengerSelectorDelegate {
    func readPassengerCount(count: String) {
        passengerCountLabel.text = count
    }
}

extension LiftRequestDetailsVC: GroupsViewDelegate {
    func readSelectedGroup(group: String) {
        selectedGroupLabel.text = group
        groupsView.removeFromSuperview()
    }
    
}
