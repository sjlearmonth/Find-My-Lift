//
//  SignUpVC.swift
//  Find My Lift
//
//  Created by Stephen Learmonth on 16/10/2020.
//  Copyright © 2020 Stephen Learmonth. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {

    // MARK: - Properties
    
    private var viewModel = SignUpViewModel()
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
        label.font = UIFont(name: "Rockwell", size: 40)
        label.setHeight(height: 60)
        label.backgroundColor = .clear
        label.textColor = .white
        return label
    }()
    
    private lazy var fullnameContainerView = InputContainerView(image: #imageLiteral(resourceName: "ic_person_outline_white_2x"), textField: fullnameTextField)
    private lazy var usernameContainerView = InputContainerView(image: #imageLiteral(resourceName: "ic_person_outline_white_2x"), textField: usernameTextField)
    private lazy var emailContainerView = InputContainerView(image: #imageLiteral(resourceName: "Envelope"), textField: emailTextField)
    private lazy var passwordContainerView = InputContainerView(image: #imageLiteral(resourceName: "Lock"), textField: passwordTextField)

    private let fullnameTextField = CustomTextField(placeholder: "Fullname", isSecureTextEntry: false)
    private let usernameTextField = CustomTextField(placeholder: "Username", isSecureTextEntry: false)
    private let emailTextField = CustomTextField(placeholder: "Email", isSecureTextEntry: false)
    private let passwordTextField = CustomTextField(placeholder: "Password", isSecureTextEntry: true)
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.setHeight(height: 50)
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancel", for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.setHeight(height: 50)
        button.isEnabled = true
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        
        return button
    }()
    
    private let logInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.setHeight(height: 50)
        button.isEnabled = true
        button.addTarget(self, action: #selector(handleLogIn), for: .touchUpInside)
        
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
        
        configureNotificationObservers()
        
        configureScrollView()

    }
    
    // MARK: - Selectors
    
    @objc func handleSignUp() {
        
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              let fullname = fullnameTextField.text,
              let username = usernameTextField.text?.lowercased() else { return }
        
        let credentials = RegistrationCredentials(email: email,
                                                  password: password,
                                                  fullname: fullname,
                                                  username: username)
        
        showLoader(true, withText: "Signing You Up")
        
        AuthService.shared.createUser(credentials: credentials) { error in
            if let error = error {
                self.showLoader(false)
                self.showError(error.localizedDescription)
                return
            }
            
            self.showLoader(false)
            self.delegate?.completeAuthentication()
        }
    }
    
    @objc func handleCancel() {
        let controller = LogInVC()
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        present(controller, animated: true, completion: nil)
    }

    @objc func handleLogIn() {
        let controller = LogInVC()
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        present(controller, animated: true, completion: nil)
    }
    
    @objc func textDidChange(sender: UITextField) {
        
        if sender == emailTextField {
            viewModel.email = sender.text
        } else if sender == passwordTextField {
            viewModel.password = sender.text
        } else if sender == fullnameTextField {
            viewModel.fullname = sender.text
        } else {
            viewModel.username = sender.text
        }
        
        checkFormStatus()
    }
    
    @objc func keyboardWillShow() {
        if view.frame.origin.y == 0 {
            view.frame.origin.y -= 225
        }
    }
    
    @objc func keyboardWillHide() {
        if view.frame.origin.y != 0 {
        view.frame.origin.y = 0
        }
    }

    // MARK: Helper Functions
    
    func configureUI() {
        
        configureGradientLayer()
        
        contentView.addSubview(clouds)
        clouds.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, height: 300)
        
        contentView.addSubview(titleLabelView)
        titleLabelView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 75, paddingLeft: 32.0, paddingRight: 32.0, height: 80)
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        fullnameTextField.delegate = self
        usernameTextField.delegate = self
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView,
                                                   passwordContainerView,
                                                   fullnameContainerView,
                                                   usernameContainerView,
                                                   signUpButton,
                                                   cancelButton,
                                                   logInButton])
        stack.axis = .vertical
        stack.spacing = 16
        
        contentView.addSubview(stack)
        stack.anchor(top: titleLabel.bottomAnchor,
                     left: contentView.leftAnchor,
                     right: contentView.rightAnchor,
                     paddingTop: 120,
                     paddingLeft: 32,
                     paddingRight: 32)
        
    }
    
    func configureNotificationObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fullnameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        usernameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
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

extension SignUpVC: AuthenticationControllerProtocol {
    
    func checkFormStatus() {
        
        if viewModel.formIsValid {
            signUpButton.isEnabled = true
            signUpButton.backgroundColor = .systemBlue
        } else {
            signUpButton.isEnabled = false
            signUpButton.backgroundColor = .systemGreen
        }
    }
}

extension SignUpVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
