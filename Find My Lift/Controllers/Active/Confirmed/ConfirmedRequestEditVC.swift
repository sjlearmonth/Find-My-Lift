//
//  ConfirmedEditVC.swift
//  Find My Lift
//
//  Created by Stephen Learmonth on 12/11/2020.
//  Copyright © 2020 Stephen Learmonth. All rights reserved.
//

import UIKit

class ConfirmedRequestEditVC: UIViewController {

    // MARK: - Properties
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private var data: [String:String]
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: LABEL_FONT_DEMIBOLD, size: 30.0)
        label.backgroundColor = .systemGreen
        label.setHeight(height: 60.0)
        label.layer.cornerRadius = 30.0
        label.layer.masksToBounds = true
        return label
    }()
    
    private let startLocationLabel: UILabel = {
        let label = UILabel()
        label.text = "Start Location:"
        label.textColor = UIColor(white: 1.0, alpha: 1.0)
        label.font = UIFont(name: LABEL_FONT_DEMIBOLD, size: 20)
        return label
    }()

    private lazy var startLocationTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "LU6 1AW"
        textField.text = data["Start"]
        textField.font = UIFont(name: LABEL_FONT_REGULAR, size: 20.0)
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
        label.font = UIFont(name: LABEL_FONT_DEMIBOLD, size: 20)
        return label
    }()
    
    private lazy var endLocationTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "NN14 7NU"
        textField.text = data["End"]
        textField.textColor = .black
        textField.font = UIFont(name: LABEL_FONT_REGULAR, size: 20.0)
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
        button.titleLabel?.font = UIFont(name: LABEL_FONT_DEMIBOLD, size: 20)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(handleSelectDateClicked), for: .touchUpInside)
        return button
    }()

    private lazy var selectedDateLabel: UILabel = {
        let label = UILabel()
        label.text = data["Date"]
        label.textColor = .black
        label.backgroundColor = .white
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.font = UIFont(name: LABEL_FONT_REGULAR, size: 20)
        return label
    }()

    private lazy var dateSelectorView: DateSelectorView = {
        let dsv = DateSelectorView()
        dsv.delegate = self
        dsv.setWidth(width: 350)
        dsv.setHeight(height: 250)
        return dsv
    }()
    
    private lazy var selectTimeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select Time", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: LABEL_FONT_DEMIBOLD, size: 20)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(handleSelectTimeClicked), for: .touchUpInside)
        return button
    }()

    private lazy var selectedTimeLabel: UILabel = {
        let label = UILabel()
        label.text = data["Time"]
        label.textColor = .black
        label.backgroundColor = .white
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.font = UIFont(name: LABEL_FONT_REGULAR, size: 20)
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
        button.titleLabel?.font = UIFont(name: LABEL_FONT_DEMIBOLD, size: 20)
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
        label.font = UIFont(name: LABEL_FONT_REGULAR, size: 20)
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

    private let driverNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Driver Name:"
        label.textColor = UIColor(white: 1.0, alpha: 1.0)
        label.font = UIFont(name: LABEL_FONT_DEMIBOLD, size: 20)
        return label
    }()
    
    private lazy var driverNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Louise"
        textField.text = data["Driver"]
        textField.textColor = .black
        textField.font = UIFont(name: LABEL_FONT_REGULAR, size: 20.0)
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 5
        textField.setDimensions(height: 35, width: 100)
        textField.textAlignment = .center
        textField.returnKeyType = .done
        textField.delegate = self
        return textField
    }()

    private let regLabel: UILabel = {
        let label = UILabel()
        label.text = "Registration:"
        label.textColor = UIColor(white: 1.0, alpha: 1.0)
        label.font = UIFont(name: LABEL_FONT_DEMIBOLD, size: 20)
        return label
    }()
    
    private lazy var regTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "KN69 PFY"
        textField.text = data["Reg"]
        textField.textColor = .black
        textField.font = UIFont(name: LABEL_FONT_REGULAR, size: 20.0)
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 5
        textField.setDimensions(height: 35, width: 100)
        textField.textAlignment = .center
        textField.returnKeyType = .done
        textField.delegate = self
        return textField
    }()

    private let colourLabel: UILabel = {
        let label = UILabel()
        label.text = "Vehicle Colour:"
        label.textColor = UIColor(white: 1.0, alpha: 1.0)
        label.font = UIFont(name: LABEL_FONT_DEMIBOLD, size: 20)
        return label
    }()
    
    private lazy var colourTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "White"
        textField.text = data["Colour"]
        textField.textColor = .black
        textField.font = UIFont(name: LABEL_FONT_REGULAR, size: 20.0)
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 5
        textField.setDimensions(height: 35, width: 100)
        textField.textAlignment = .center
        textField.returnKeyType = .done
        textField.delegate = self
        return textField
    }()
    
    private lazy var chatButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Chat", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = UIFont(name: LABEL_FONT_DEMIBOLD, size: 20.0)
        button.setHeight(height: 50.0)
        button.layer.cornerRadius = 25.0
        button.addTarget(self, action: #selector(handleChatButton), for: .touchUpInside)
        return button
    }()

    private lazy var requestButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Request Edit", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = UIFont(name: LABEL_FONT_DEMIBOLD, size: 20.0)
        button.setHeight(height: 50.0)
        button.layer.cornerRadius = 25.0
        button.addTarget(self, action: #selector(handleRequestButton), for: .touchUpInside)
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
        
        navigationItem.title = "Edit Confirmed"
        navigationItem.backButtonTitle = ""

        navigationController?.navigationBar.barTintColor = .systemBlue
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30)]
        navigationController?.navigationBar.barStyle = .black
        
        if data["ConfirmedType"] == "LiftOffered" {
            
            titleLabel.text = "Edit Lift Offered"
            
            contentView.addSubview(titleLabel)
            titleLabel.anchor(top: contentView.topAnchor,
                              left: contentView.leftAnchor,
                              right: contentView.rightAnchor,
                              paddingTop: 25.0,
                              paddingLeft: 32.0,
                              paddingRight: 32.0)
            
            let startStackView = UIStackView(arrangedSubviews: [startLocationLabel,
                                                                startLocationTextField,
                                                                startLocationDisclosure])
            startStackView.axis = .horizontal
            startStackView.distribution = .fill
            startStackView.spacing = 5
            
            contentView.addSubview(startStackView)
            startStackView.anchor(top: titleLabel.bottomAnchor,
                                  left: contentView.leftAnchor,
                                  right: contentView.rightAnchor,
                                  paddingTop: 40,
                                  paddingLeft: 32,
                                  paddingRight: 32,
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
                                right: contentView.rightAnchor,
                                paddingTop: 32,
                                paddingLeft: 32,
                                paddingRight: 32,
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
            
            contentView.addSubview(chatButton)
            chatButton.anchor(top: passengerCountStackView.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 25.0, paddingLeft: 32.0, paddingRight: 32.0)

            contentView.addSubview(requestButton)
            requestButton.anchor(top: chatButton.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 25.0, paddingLeft: 32.0, paddingRight: 32.0)


        } else {
            
            titleLabel.text = "Edit Lift Accepted"
            
            contentView.addSubview(titleLabel)
            titleLabel.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 25.0, paddingLeft: 32.0, paddingRight: 32.0)
            
            let driverNameStackView = UIStackView(arrangedSubviews: [driverNameLabel,
                                                                     driverNameTextField])
            driverNameStackView.axis = .horizontal
            driverNameStackView.distribution = .fill
            driverNameStackView.spacing = 5
            
            contentView.addSubview(driverNameStackView)
            driverNameStackView.anchor(top: titleLabel.bottomAnchor,
                                  left: contentView.leftAnchor,
                                  right: contentView.rightAnchor,
                                  paddingTop: 25.0,
                                  paddingLeft: 32.0,
                                  paddingRight: 32.0,
                                  height: 35.0)

            let regStackView = UIStackView(arrangedSubviews: [regLabel,
                                                              regTextField])
            regStackView.axis = .horizontal
            regStackView.distribution = .fill
            regStackView.spacing = 5
            
            contentView.addSubview(regStackView)
            regStackView.anchor(top: driverNameStackView.bottomAnchor,
                                  left: contentView.leftAnchor,
                                  right: contentView.rightAnchor,
                                  paddingTop: 25.0,
                                  paddingLeft: 32.0,
                                  paddingRight: 32.0,
                                  height: 35.0)

            let colourStackView = UIStackView(arrangedSubviews: [colourLabel,
                                                                 colourTextField])
            colourStackView.axis = .horizontal
            colourStackView.distribution = .fill
            colourStackView.spacing = 5
            
            contentView.addSubview(colourStackView)
            colourStackView.anchor(top: regStackView.bottomAnchor,
                                  left: contentView.leftAnchor,
                                  right: contentView.rightAnchor,
                                  paddingTop: 25.0,
                                  paddingLeft: 32.0,
                                  paddingRight: 32.0,
                                  height: 35.0)

            let dateStackView = UIStackView(arrangedSubviews: [selectDateButton,
                                                               selectedDateLabel])
            dateStackView.axis = .horizontal
            dateStackView.distribution = .fillEqually
            dateStackView.spacing = 20
            
            contentView.addSubview(dateStackView)
            dateStackView.anchor(top: colourStackView.bottomAnchor,
                                     left: contentView.leftAnchor,
                                     right: contentView.rightAnchor,
                                     paddingTop: 25.0,
                                     paddingLeft: 32.0,
                                     paddingRight: 32.0,
                                     height: 35.0)
            
            let timeStackView = UIStackView(arrangedSubviews: [selectTimeButton,
                                                               selectedTimeLabel])
            timeStackView.axis = .horizontal
            timeStackView.distribution = .fillEqually
            timeStackView.spacing = 20
            
            contentView.addSubview(timeStackView)
            timeStackView.anchor(top: dateStackView.bottomAnchor,
                                     left: contentView.leftAnchor,
                                     right: contentView.rightAnchor,
                                     paddingTop: 25.0,
                                     paddingLeft: 32.0,
                                     paddingRight: 32.0,
                                     height: 35.0)
            
            contentView.addSubview(chatButton)
            chatButton.anchor(top: timeStackView.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 25.0, paddingLeft: 32.0, paddingRight: 32.0)

            contentView.addSubview(requestButton)
            requestButton.anchor(top: chatButton.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 25.0, paddingLeft: 32.0, paddingRight: 32.0)

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
    
    @objc func handleDisclosure() {
        print("DEBUG: location disclosure clicked")
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
    
    @objc func handleChatButton() {
        print("DEBUG: chat button clicked")
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = windowScene.delegate as? SceneDelegate else { return }
        let tabBarController = sceneDelegate.window?.rootViewController as? UITabBarController
        tabBarController?.selectedIndex = 2
    }
    
    @objc func handleRequestButton() {
        print("DEBUG: request edit lift clicked")
        let alertController = UIAlertController(title: "Edit Request", message: "Edit request sent to admin", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in self.dismiss(animated: true, completion: nil)})
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func handlePassengerCountClicked() {
        contentView.addSubview(passengerSelectorView)
        passengerSelectorView.centerX(inView: contentView)
        passengerSelectorView.centerY(inView: contentView, constant: -contentView.frame.size.height / 4.0)
        return
    }
    

}

extension ConfirmedRequestEditVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case startLocationTextField:
            data["Start"] = textField.text
            break
        case endLocationTextField:
            data["End"] = textField.text
            break
        case driverNameTextField:
            data["Driver"] = textField.text
            break
        case regTextField:
            data["Reg"] = textField.text
            break
        case colourTextField:
            data["Colour"] = textField.text
        default:
            break
        }
        
        textField.endEditing(true)
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }

}

extension ConfirmedRequestEditVC: DateSelectorDelegate {
    func readDateSelected(date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_GB")
        dateFormatter.setLocalizedDateFormatFromTemplate("dd/MM/YY")
        let dateString = dateFormatter.string(from: date)
        selectedDateLabel.text = dateString
        data["Date"] = dateString
        return
    }
}

extension ConfirmedRequestEditVC: TimeSelectorDelegate {
    func readTimeSelected(time: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_GB")
        dateFormatter.setLocalizedDateFormatFromTemplate("HH:mm")
        let timeString = dateFormatter.string(from: time) + " hrs"
        selectedTimeLabel.text = timeString
        data["Time"] = timeString
        return
    }
}

extension ConfirmedRequestEditVC: PassengerSelectorDelegate {
    func readPassengerCount(count: String) {
        passengerCountLabel.text = count
        data["Pass"] = count
    }
}
