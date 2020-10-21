//
//  LoginVC.swift
//  Find My Lift
//
//  Created by Stephen Learmonth on 28/09/2020.
//  Copyright © 2020 Stephen Learmonth. All rights reserved.
//

import UIKit

import UIKit
import Firebase
import JGProgressHUD

protocol AuthenticationControllerProtocol {
    func checkFormStatus()
}

protocol AuthenticationDelegate: class {
    func completeAuthentication()
}
class LogInVC: UIViewController {

    // MARK: - Properties
    
    private var viewModel = LogInViewModel()
    
    weak var delegate: AuthenticationDelegate?
    
    private let clouds: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Clouds")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var titleLabelView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGreen
        view.addSubview(titleLabel)
        titleLabel.centerX(inView: view)
        titleLabel.centerY(inView: view, constant: 5)
        view.layer.cornerRadius = 80 / 2
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Find My Lift"
        label.font = UIFont(name: "Rockwell", size: 50)
        label.setHeight(height: 60)
        label.backgroundColor = .clear
        label.textColor = .white
        return label
    }()
    
    private let emailTextField = CustomTextField(placeholder: "Email", isSecureTextEntry: false)

    private let passwordTextField = CustomTextField(placeholder: "Password", isSecureTextEntry: true)
        
    private lazy var emailContainerView = InputContainerView(image:#imageLiteral(resourceName: "Envelope"), textField: emailTextField)

    private lazy var passwordContainerView = InputContainerView(image: #imageLiteral(resourceName: "Lock"), textField: passwordTextField)

    private let forgotPassword: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Forgot Password?", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12.0)
        button.backgroundColor = .clear
        button.setTitleColor(.white, for: .normal)
        button.setHeight(height: 20.0)
        button.isEnabled = true
        button.addTarget(self, action: #selector(handleForgotPassword), for: .touchUpInside)
        return button
    }()
    
    private let logInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.layer.cornerRadius = 10.0
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.setHeight(height: 50.0)
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleLogIn), for: .touchUpInside)
        return button
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.layer.cornerRadius = 10.0
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.setHeight(height: 50.0)
        button.isEnabled = true
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        configureNotificationObservers()
        
    }
    
    // MARK: - Selectors
    
    @objc func handleLogIn() {
        
        guard let emailText = emailTextField.text,
              let passwordText = passwordTextField.text else { return }
        
        showLoader(true, withText: "Logging In")
        
        AuthService.shared.logUserIn(withEmail: emailText, password: passwordText) { (result, error) in
            if let error = error {
                self.showError(error.localizedDescription)
                self.showLoader(false)
                return
            }
            
            self.showLoader(false)
            self.delegate?.completeAuthentication()
        }
    }
    
    @objc func handleForgotPassword() {
        print("DEBUG: forgot password clicked")
    }
    
    @objc func handleSignUp() {
        print("DEBUG: sign up clicked")
        let controller = SignUpVC()
        controller.delegate = delegate
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        present(controller, animated: true, completion: nil)
    }
    
    @objc func textDidChange(sender: UITextField) {
        
        if sender == emailTextField {
            viewModel.email = sender.text
        } else {
            viewModel.password = sender.text
        }
        
        checkFormStatus()
    }
    
    @objc func keyboardWillShow() {
        if view.frame.origin.y == 0 {
            view.frame.origin.y -= 175
        }
    }
    
    @objc func keyboardWillHide() {
        if view.frame.origin.y != 0 {
        view.frame.origin.y = 0
        }
    }

    // MARK: Helper Functions
    
    private func configureUI() {
        
        configureGradientLayer()
        
        view.addSubview(clouds)
        clouds.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 300)
        
        view.addSubview(titleLabelView)
        titleLabelView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 75, width: 375, height: 80)
        titleLabelView.centerX(inView: view)
                
        let stackView = UIStackView(arrangedSubviews: [emailContainerView,
                                                       passwordContainerView])
        stackView.axis = .vertical
        stackView.spacing = 16
        
        view.addSubview(stackView)
        stackView.anchor(top: clouds.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,
                     paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
        view.addSubview(forgotPassword)
        forgotPassword.anchor(top: stackView.bottomAnchor, right: view.rightAnchor, paddingTop: 12, paddingRight: 32)
        
        view.addSubview(logInButton)
        logInButton.anchor(top: forgotPassword.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,
                           paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(signUpButton)
        signUpButton.anchor(top: logInButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,
                           paddingTop: 32, paddingLeft: 32, paddingRight: 32)
    }
    
    private func configureNotificationObservers() {
        
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

    }
}

extension LogInVC: AuthenticationControllerProtocol {
    func checkFormStatus() {
        if viewModel.formIsValid {
            logInButton.isEnabled = true
            logInButton.backgroundColor = .systemBlue
        } else {
            logInButton.isEnabled = false
            logInButton.backgroundColor = .systemGreen
        }
    }
}
