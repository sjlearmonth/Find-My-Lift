//
//  LiftOfferDetailsVC.swift
//  Find My Lift
//
//  Created by Stephen Learmonth on 30/09/2020.
//  Copyright © 2020 Stephen Learmonth. All rights reserved.
//

import UIKit

class LiftOfferDetailsVC: UIViewController {

    // MARK: - Properties
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private let startLocationLabel: UILabel = {
        let label = UILabel()
        label.text = "Start Location:"
        label.textColor = UIColor(white: 1.0, alpha: 1.0)
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 20)
        return label
    }()

    private lazy var startLocationTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "LU6 1AW"
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 5
        textField.setDimensions(height: 35, width: 125)
        textField.textAlignment = .center
        textField.returnKeyType = .done
        textField.delegate = self
        return textField
    }()

    private let startLocationDisclosure: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrowtriangle.down.fill"), for: .normal)
        button.setDimensions(height: 25, width: 25)
        button.addTarget(self, action: #selector(handleDisclosure), for: .touchUpInside)
        button.isHidden = false
        button.isEnabled = true
        button.tintColor = .white
        return button
    }()

    private let endLocationLabel: UILabel = {
        let label = UILabel()
        label.text = "End Location:"
        label.textColor = UIColor(white: 1.0, alpha: 1.0)
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 20)
        return label
    }()
    
    private lazy var endLocationTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "NN14 7NU"
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 5
        textField.setDimensions(height: 35, width: 125)
        textField.textAlignment = .center
        textField.returnKeyType = .done
        textField.delegate = self
        return textField
    }()
    
    private let endLocationDisclosure: UIButton = {
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

    private lazy var dateSelectorView: DateSelectorView = {
        let dsv = DateSelectorView()
        dsv.delegate = self
        dsv.setWidth(width: 350)
        dsv.setHeight(height: 250)
        return dsv
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
    
    private let detourLabel: UILabel = {
        let label = UILabel()
        label.text = "Detour Distance (miles):"
        label.textColor = UIColor(white: 1.0, alpha: 1.0)
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 20)
        return label
    }()
    
    private lazy var detourTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "10 miles"
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 5
        textField.setDimensions(height: 35, width: 100)
        textField.textAlignment = .center
        textField.returnKeyType = .done
        textField.delegate = self
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private lazy var doneButtonItem: UIBarButtonItem = {
        let barButton = UIBarButtonItem()
        barButton.title = "Done"
        barButton.style = .done
        barButton.target = self
        barButton.action = #selector(doneButtonClicked)
        return barButton
    }()

    private let chargeLabel: UILabel = {
        let label = UILabel()
        label.text = "Charge for lift:"
        label.textColor = UIColor(white: 1.0, alpha: 1.0)
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 20)
        return label
    }()
    
    private let yesLabel: UILabel = {
        let label = UILabel()
        label.text = "Yes"
        label.textColor = UIColor(white: 1.0, alpha: 1.0)
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 20)
        return label
    }()
    
    private let noLabel: UILabel = {
        let label = UILabel()
        label.text = "No"
        label.textColor = UIColor(white: 1.0, alpha: 1.0)
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 20)
        return label
    }()

    private lazy var chargeSwitch: UISwitch = {
        let sw = UISwitch()
        sw.onTintColor = .systemBlue
        sw.thumbTintColor = .white
        sw.tintColor = .systemBlue
        sw.layer.borderWidth = 0.25
        sw.layer.cornerRadius = 15.5
        return sw
    }()
    
    private let shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Share Lift", for: .normal)
        button.layer.cornerRadius = 25.0
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.setHeight(height: 50.0)
        button.isEnabled = true
        button.addTarget(self, action: #selector(handleShareClicked), for: .touchUpInside)
        return button
    }()

    lazy var groupSelectorView : GroupSelectorView = {
        let gsv = GroupSelectorView()
        gsv.delegate = self
        gsv.setWidth(width: 350)
        gsv.setHeight(height: 250)
        return gsv
    }()
    
    private lazy var groupsTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.rowHeight = 40.0
        return tableView
    }()
    
    private var groupsShared = [String]()
    
    private let cellID = "groupsSharedCellID"
    
    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.isScrollEnabled = true
        sv.bounces = false
        return sv
    }()
    
    private lazy var contentView: UIView = {
        let cv = UIView()
        cv.frame.size = CGSize(width: self.view.frame.width, height: self.view.frame.height * 2.0)
        return cv
    }()
    
    private let submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Submit Lift Offer", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 25)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 25.0
        button.addTarget(self, action: #selector(handleSubmitClicked), for: .touchUpInside)

        return button
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
        dateSelectorView.centerY(inView: contentView)
        return
    }
    
    @objc func handleSelectTimeClicked() {
        contentView.addSubview(timeSelectorView)
        timeSelectorView.centerX(inView: contentView)
        timeSelectorView.centerY(inView: contentView)
        return
    }
    
    @objc func handlePassengerCountClicked() {
        contentView.addSubview(passengerSelectorView)
        passengerSelectorView.centerX(inView: contentView)
        passengerSelectorView.centerY(inView: contentView)
        return
    }
    
    @objc func doneButtonClicked() {
        print("DEBUG: done button clicked")
        detourTextField.endEditing(true)
        guard let detourText = detourTextField.text else { return }
        if detourText != "" {
            detourTextField.text! += " miles"
        }
        navigationItem.rightBarButtonItem? = UIBarButtonItem()
    }

    @objc func handleShareClicked() {
        print("DEBUG: handle select group clicked")
        contentView.addSubview(groupSelectorView)
        groupSelectorView.delegate = self
        groupSelectorView.centerX(inView: view)
        groupSelectorView.centerY(inView: view)
        return
    }

    @objc func handleSubmitClicked() {
        print("DEBUG: submit lift offer clicked")
        let controller = MatchingLiftRequestsVC()
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        navigationController?.pushViewController(controller, animated: true)
    }

    // MARK: - Helper Functions
    
    private func configureUI() {
        
        configureGradientLayer()
        
        title = "Lift Offer Details"
        navigationItem.backButtonTitle = ""
        
        navigationController?.navigationBar.barTintColor = .systemBlue
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30)]
        navigationController?.navigationBar.barStyle = .black
        
        let startStackView = UIStackView(arrangedSubviews: [startLocationLabel,
                                                             startLocationTextField,
                                                             startLocationDisclosure])
        startStackView.axis = .horizontal
        startStackView.distribution = .fill
        startStackView.spacing = 5
        
        contentView.addSubview(startStackView)
        startStackView.anchor(top: contentView.topAnchor,
                               left: contentView.leftAnchor,
                               right: contentView.rightAnchor, paddingTop: 40, paddingLeft: 32, paddingRight: 32,
                               height: 35)
 
        let endStackView = UIStackView(arrangedSubviews: [endLocationLabel,
                                                          endLocationTextField,
                                                          endLocationDisclosure])

        endStackView.axis = .horizontal
        endStackView.distribution = .fill
        endStackView.spacing = 5

        contentView.addSubview(endStackView)
        endStackView.anchor(top: startStackView.bottomAnchor,
                               left: contentView.leftAnchor,
                               right: contentView.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32,
                               height: 35)

        let dateStackView = UIStackView(arrangedSubviews: [selectDateButton,
                                                           selectedDateLabel])
        dateStackView.axis = .horizontal
        dateStackView.distribution = .fillEqually
        dateStackView.spacing = 20
        
        contentView.addSubview(dateStackView)
        dateStackView.anchor(top: endStackView.bottomAnchor,
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
        
        contentView.addSubview(detourLabel)
        detourLabel.anchor(top: passengerCountStackView.bottomAnchor, left: contentView.leftAnchor, paddingTop: 32.0, paddingLeft: 32.0)
        
        contentView.addSubview(detourTextField)
        detourTextField.anchor(left: detourLabel.rightAnchor, paddingLeft: 8.0)
        detourTextField.centerY(inView: detourLabel)

        contentView.addSubview(chargeLabel)
        chargeLabel.anchor(top: detourLabel.bottomAnchor, left: contentView.leftAnchor, paddingTop: 25.0, paddingLeft: 32.0)
        
        contentView.addSubview(chargeSwitch)
        chargeSwitch.anchor(left: chargeLabel.rightAnchor, paddingLeft: 50.0)
        chargeSwitch.centerY(inView: chargeLabel)
        
        contentView.addSubview(noLabel)
        noLabel.anchor(right: chargeSwitch.leftAnchor, paddingRight: 8.0)
        noLabel.centerY(inView: chargeSwitch)
        
        contentView.addSubview(yesLabel)
        yesLabel.anchor(left: chargeSwitch.rightAnchor, paddingLeft: 8.0)
        yesLabel.centerY(inView: chargeSwitch)
        
        contentView.addSubview(shareButton)
        shareButton.anchor(top: chargeLabel.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 25.0, paddingLeft: 64.0, paddingRight: 64.0)
        
        contentView.addSubview(groupsTableView)
        groupsTableView.anchor(top: shareButton.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 25.0, paddingLeft: 32.0, paddingRight: 32.0, height: 200.0)
        
        contentView.addSubview(submitButton)
        submitButton.anchor(top: groupsTableView.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 25.0, paddingLeft: 32.0, paddingRight: 32.0, height: 50.0)
        
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

extension LiftOfferDetailsVC: DateSelectorDelegate {
    func readDateSelected(date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_GB")
        dateFormatter.setLocalizedDateFormatFromTemplate("dd/MM/YYYY")
        let dateString = dateFormatter.string(from: date)
        selectedDateLabel.text = dateString
        return
    }
}

extension LiftOfferDetailsVC: TimeSelectorDelegate {
    func readTimeSelected(time: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_GB")
        dateFormatter.setLocalizedDateFormatFromTemplate("HH:mm")
        let timeString = dateFormatter.string(from: time)
        selectedTimeLabel.text = timeString + " hrs"
        return
    }
}

extension LiftOfferDetailsVC: PassengerSelectorDelegate {
    func readPassengerCount(count: String) {
        passengerCountLabel.text = count
    }
}

extension LiftOfferDetailsVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.keyboardType == .numberPad {
            navigationItem.rightBarButtonItem = doneButtonItem
        }
    }
}

extension LiftOfferDetailsVC: GroupSelectorDelegate {
    func readGroupSelected(group: String) {
        groupSelectorView.removeFromSuperview()
        
        if groupsShared.contains(group) == false {
            groupsShared.append(group)
        }
        groupsTableView.reloadData()
    }
    
}

extension LiftOfferDetailsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Groups Shared"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }
}

extension LiftOfferDetailsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsShared.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID)!
        cell.textLabel?.text = groupsShared[indexPath.row]
        return cell
    }
    
    
}
