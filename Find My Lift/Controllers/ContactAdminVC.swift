//
//  ContactAdminVC.swift
//  Find My Lift
//
//  Created by Stephen Learmonth on 30/10/2020.
//  Copyright © 2020 Stephen Learmonth. All rights reserved.
//

import UIKit

class ContactAdminVC: UIViewController {

    // MARK: - Properties
    
    private let subjectLabel: UILabel = {
        let label = UILabel()
        label.text = "Subject:"
        label.textColor = UIColor(white: 1.0, alpha: 1.0)
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 20)
        return label
    }()

    private lazy var subjectTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Please Add Member"
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 5
        textField.setDimensions(height: 35, width: 250)
        textField.textAlignment = .left
        textField.returnKeyType = .done
        textField.delegate = self
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 8.0, height: 35.0))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        return textField
    }()

    private lazy var messageTextView: UITextView = {
        let tv = UITextView()
        tv.setDimensions(height: 200, width: view.frame.width - 64.0)
        tv.text = "Type your message here."
        tv.font = UIFont(name: "AvenirNext-Regular", size: 18.0)
        tv.textColor = .black
        tv.textAlignment = .left
        tv.backgroundColor = UIColor.white
        tv.layer.borderWidth = 0.25
        tv.layer.borderColor = UIColor.white.cgColor
        tv.layer.cornerRadius = 5.0
        tv.delegate = self
        return tv
    }()

    private lazy var sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send Message", for: .normal)
        button.layer.cornerRadius = 25.0
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.setHeight(height: 50.0)
        button.isEnabled = true
        button.addTarget(self, action: #selector(handleSendMessage), for: .touchUpInside)
        return button
    }()

    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()

    }
    
    // MARK: - Helper Functions
    
    private func configureUI() {
        
        configureGradientLayer()
        
        title = "Contact Admin"
        navigationItem.backButtonTitle = ""

        navigationController?.navigationBar.barTintColor = .systemBlue
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30)]
        navigationController?.navigationBar.barStyle = .black
        
        view.addSubview(subjectLabel)
        subjectLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, paddingTop: 40.0, paddingLeft: 16.0)
        
        view.addSubview(subjectTextField)
        subjectTextField.anchor(left: subjectLabel.rightAnchor, paddingLeft: 8.0)
        subjectTextField.centerY(inView: subjectLabel)
        
        view.addSubview(messageTextView)
        messageTextView.anchor(top: subjectLabel.bottomAnchor, paddingTop: 25.0)
        messageTextView.centerX(inView: view)
        
        view.addSubview(sendButton)
        sendButton.anchor(top: messageTextView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 25.0, paddingLeft: 32.0, paddingRight: 32.0)
    }
    
    // MARK: - Selectors
    
    @objc func handleDoneClicked() {
        print("DEBUG: done clicked")
        messageTextView.endEditing(true)
        navigationItem.rightBarButtonItem = UIBarButtonItem()
    }
    
    @objc func handleSendMessage() {
        print("DEBUG: send message clicked")
        let alertController = UIAlertController(title: "Message Sent", message: "Your message has been sent to admin", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { (_) in
            let alertController = UIAlertController(title: "Message Received", message: "Your message has been received and and a response will arrive soon", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: {_ in self.navigationController?.popToRootViewController(animated: true)})
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)
        }
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
        
    }
}

extension ContactAdminVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        subjectTextField.text = ""
    }
}

extension ContactAdminVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDoneClicked))
    }
}
