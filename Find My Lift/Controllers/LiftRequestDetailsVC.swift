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

    private lazy var pickupLocationTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "LU6 1AW"
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 5
        textField.setDimensions(height: 35, width: 150)
        textField.textAlignment = .center
        textField.returnKeyType = .done
        textField.delegate = self
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
    
    private lazy var destinationLocationTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "NN14 7NU"
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 5
        textField.setDimensions(height: 35, width: 150)
        textField.textAlignment = .center
        textField.returnKeyType = .done
        textField.delegate = self
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
        label.text = "01/10/2020"
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
        label.setWidth(width: 125)
        return label
    }()
    
    private lazy var groupSelectorView : GroupSelectorView = {
        let gsv = GroupSelectorView()
        gsv.delegate = self
        gsv.setWidth(width: 350)
        gsv.setHeight(height: 250)
        return gsv
    }()
    
    private let checkLiftAvailabilityButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Check Lift Availability", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 25)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(handleCheckLiftAvailabilityClicked), for: .touchUpInside)

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

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        configureScrollView()
    }

    // MARK: - Selectors
    
    @objc func handleDisclosure() {
        print("DEBUG: handle pickup disclosure clicked")
    }
    
    @objc func handleSelectDateClicked() {
        contentView.addSubview(dateSelectorView)
        dateSelectorView.centerX(inView: contentView)
        dateSelectorView.centerY(inView: contentView, constant: -contentView.frame.size.height / 4.0)
        return
    }
    
    @objc func handleSelectTimeClicked() {
        contentView.addSubview(timeSelectorView)
        timeSelectorView.centerX(inView: contentView)
        timeSelectorView.centerY(inView: contentView, constant: -contentView.frame.size.height / 4.0)
        return
    }
    
    @objc func handlePassengerCountClicked() {
        contentView.addSubview(passengerSelectorView)
        passengerSelectorView.centerX(inView: contentView)
        passengerSelectorView.centerY(inView: contentView, constant: -contentView.frame.size.height / 4.0)
        return
    }
    
    @objc func handleSelectGroupClicked() {
        print("DEBUG: handle select group clicked")
        contentView.addSubview(groupSelectorView)
        groupSelectorView.delegate = self
        groupSelectorView.centerX(inView: contentView)
        groupSelectorView.centerY(inView: contentView, constant: -contentView.frame.size.height / 4.0)
        return
    }
    
    @objc func handleCheckLiftAvailabilityClicked() {
        print("DEBUG: check for lift clicked")
        let controller = LiftAvailabilityVC()
        controller.selectedGroup = selectedGroupLabel.text ?? ""
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        navigationController?.pushViewController(controller, animated: true)        
    }
    
    // MARK: - Helper Functions
    private func configureUI() {
        
        configureGradientLayer()
        
        title = "Lift Request Details"
        navigationItem.backButtonTitle = ""

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

        contentView.addSubview(pickupStackView)
        pickupStackView.anchor(top: contentView.topAnchor,
                               left: contentView.leftAnchor,
                               right: contentView.rightAnchor,
                               paddingTop: 40,
                               paddingLeft: 32,
                               paddingRight: 32,
                               height: 35)
        
        contentView.addSubview(destinationStackView)
        destinationStackView.anchor(top: pickupStackView.bottomAnchor,
                                    left: contentView.leftAnchor,
                                    right: contentView.rightAnchor,
                                    paddingTop: 32.0,
                                    paddingLeft: 32.0,
                                    paddingRight: 32.0,
                                    height: 35.0)

        let dateStackView = UIStackView(arrangedSubviews: [selectDateButton,
                                                           selectedDateLabel])
        dateStackView.axis = .horizontal
        dateStackView.distribution = .fillEqually
        dateStackView.spacing = 20
        
        contentView.addSubview(dateStackView)
        dateStackView.anchor(top: destinationStackView.bottomAnchor,
                                 left: contentView.leftAnchor,
                                 right: contentView.rightAnchor,
                                 paddingTop: 32,
                                 paddingLeft: 32,
                                 paddingRight: 32)

        let timeStackView = UIStackView(arrangedSubviews: [selectTimeButton,
                                                           selectedTimeLabel])
        timeStackView.axis = .horizontal
        timeStackView.distribution = .fillEqually
        timeStackView.spacing = 20
        
        contentView.addSubview(timeStackView)
        timeStackView.anchor(top: dateStackView.bottomAnchor,
                                 left: contentView.leftAnchor,
                                 right: contentView.rightAnchor,
                                 paddingTop: 32,
                                 paddingLeft: 32,
                                 paddingRight: 32)

        let passengerCountStackView = UIStackView(arrangedSubviews: [passengerCountButton,
                                                                     passengerCountLabel])
        passengerCountStackView.axis = .horizontal
        passengerCountStackView.distribution = .fill
        passengerCountStackView.spacing = 20
        
        contentView.addSubview(passengerCountStackView)
        passengerCountStackView.anchor(top: timeStackView.bottomAnchor,
                                       left: contentView.leftAnchor,
                                       right: contentView.rightAnchor,
                                       paddingTop: 32,
                                       paddingLeft: 32,
                                       paddingRight: 32)
        
        let selectedGroupStackView = UIStackView(arrangedSubviews: [groupSelectionButton,
                                                                    selectedGroupLabel])
        selectedGroupStackView.axis = .horizontal
        selectedGroupStackView.distribution = .fill
        selectedGroupStackView.spacing = 20
        
        contentView.addSubview(selectedGroupStackView)
        selectedGroupStackView.anchor(top: passengerCountStackView.bottomAnchor,
                                      left: contentView.leftAnchor,
                                      right: contentView.rightAnchor,
                                      paddingTop: 32,
                                      paddingLeft: 32,
                                      paddingRight: 32)
        
        contentView.addSubview(checkLiftAvailabilityButton)
        checkLiftAvailabilityButton.anchor(top: selectedGroupStackView.bottomAnchor,
                                           left: contentView.leftAnchor,
                                           right: contentView.rightAnchor,
                                           paddingTop: 25.0,
                                           paddingLeft: 32.0,
                                           paddingRight: 32.0,
                                           height: 50.0)
                
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

extension LiftRequestDetailsVC: GroupSelectorDelegate {
    func readGroupSelected(group: String) {
        selectedGroupLabel.text = group
        groupSelectorView.removeFromSuperview()
    }
    
}

extension LiftRequestDetailsVC: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
