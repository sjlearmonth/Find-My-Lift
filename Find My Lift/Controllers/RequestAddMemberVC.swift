//
//  RequestAddMemberVC.swift
//  Find My Lift
//
//  Created by Stephen Learmonth on 30/10/2020.
//  Copyright © 2020 Stephen Learmonth. All rights reserved.
//

import UIKit

protocol AddMemberControllerProtocol {
    func checkFormStatus()
}

class RequestAddMemberVC: UIViewController {

    // MARK: - Properties
    
    private lazy var fullnameContainerView = InputContainerView(image: #imageLiteral(resourceName: "ic_person_outline_white_2x"), textField: fullnameTextField)
    private lazy var emailContainerView = InputContainerView(image: #imageLiteral(resourceName: "Envelope"), textField: emailTextField)
    private lazy var addressContainerView = InputContainerView(image: UIImage(systemName: "house"),
                                                               textField: addressTextField)
    private lazy var phoneContainerView = InputContainerView(image: UIImage(systemName: "phone"),
                                                             textField: phoneTextField)
    private lazy var webContainerView = InputContainerView(image: #imageLiteral(resourceName: "Web Address") ,
                                                             textField: webTextField)

    private let fullnameTextField = CustomTextField(placeholder: "Fullname", isSecureTextEntry: false)
    private let emailTextField = CustomTextField(placeholder: "Email", isSecureTextEntry: false)
    private let addressTextField = CustomTextField(placeholder: "Home address", isSecureTextEntry: false)
    private let phoneTextField = CustomTextField(placeholder: "Phone number", isSecureTextEntry: false)
    private let webTextField = CustomTextField(placeholder: "Web Address", isSecureTextEntry: false)
    
    private let addMemberButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add Member", for: .normal)
        button.layer.cornerRadius = 25.0
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleAddMember), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()

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
    
    private let verifyLabel: UILabel = {
        let label = UILabel()
        label.text = "Member verified:"
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

    private lazy var verifySwitch: UISwitch = {
        let sw = UISwitch()
        sw.onTintColor = .systemBlue
        sw.thumbTintColor = .white
        sw.tintColor = .systemBlue
        sw.layer.borderWidth = 0.25
        sw.layer.cornerRadius = 15.5
        return sw
    }()

    private var viewModel = AddMemberViewModel()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        configureScrollView()
        
        configureNotificationObservers()

    }
    
    // MARK: - Helper Functions
    
    private func configureUI() {
        
        configureGradientLayer()
        
        title = "Request add member"

        navigationController?.navigationBar.barTintColor = .systemBlue
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30)]
        navigationController?.navigationBar.barStyle = .black
        
        fullnameTextField.delegate = self
        emailTextField.delegate = self
        addressTextField.delegate = self
        phoneTextField.delegate = self
        webTextField.delegate = self
        
        let stackView = UIStackView(arrangedSubviews: [fullnameContainerView,
                                                   emailContainerView,
                                                   addressContainerView,
                                                   phoneContainerView,
                                                   webContainerView])
        stackView.axis = .vertical
        stackView.spacing = 16
        
        contentView.addSubview(stackView)
        stackView.anchor(top: contentView.topAnchor,
                     left: contentView.leftAnchor,
                     right: contentView.rightAnchor,
                     paddingTop: 40.0,
                     paddingLeft: 32.0,
                     paddingRight: 32.0)
        
        contentView.addSubview(verifyLabel)
        verifyLabel.anchor(top: stackView.bottomAnchor, left: contentView.leftAnchor, paddingTop: 25.0, paddingLeft: 32.0)
        
        contentView.addSubview(verifySwitch)
        verifySwitch.anchor(left: verifyLabel.rightAnchor, paddingLeft: 50.0)
        verifySwitch.centerY(inView: verifyLabel)
        
        contentView.addSubview(noLabel)
        noLabel.anchor(right: verifySwitch.leftAnchor, paddingRight: 8.0)
        noLabel.centerY(inView: verifySwitch)
        
        contentView.addSubview(yesLabel)
        yesLabel.anchor(left: verifySwitch.rightAnchor, paddingLeft: 8.0)
        yesLabel.centerY(inView: verifySwitch)

        
        contentView.addSubview(addMemberButton)
        addMemberButton.anchor(top: verifyLabel.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 25.0, paddingLeft: 32.0, paddingRight: 32.0, height: 50.0)
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

    private func configureNotificationObservers() {
            fullnameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
            emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
            addressTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
            phoneTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
            webTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    // MARK: - Selectors
    
    @objc func handleAddMember() {
        print("DEBUG: add member clicked")
        let alertController = UIAlertController(title: "Member Requested", message: "Admin will verify and send notification", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in self.dismiss(animated: true, completion: nil)
            self.navigationController?.popToRootViewController(animated: true)
        }))
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func textDidChange(sender: UITextField) {
        
        if sender == fullnameTextField {
            viewModel.fullname = sender.text
        } else if sender == emailTextField {
            viewModel.email = sender.text
        } else if sender == addressTextField {
            viewModel.address = sender.text
        } else if sender == phoneTextField {
            viewModel.phone = sender.text
        } else {
            viewModel.web = sender.text
        }
        
        checkFormStatus()
    }
}

extension RequestAddMemberVC: AddMemberControllerProtocol {
    
    func checkFormStatus() {
        
        if viewModel.formIsValid {
            addMemberButton.isEnabled = true
            addMemberButton.backgroundColor = .systemBlue
        } else {
            addMemberButton.isEnabled = false
            addMemberButton.backgroundColor = .systemGreen
        }
    }
}

extension RequestAddMemberVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
