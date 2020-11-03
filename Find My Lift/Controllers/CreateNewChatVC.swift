//
//  CreateNewChatVC.swift
//  Find My Lift
//
//  Created by Stephen Learmonth on 03/11/2020.
//  Copyright © 2020 Stephen Learmonth. All rights reserved.
//

import UIKit

class CreateNewChatVC: UIViewController {

    // MARK: - Properties
    
    private let memberSearchLabel: UILabel = {
        let label = UILabel()
        label.text = "Search for member:"
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 20.0)
        label.textColor = .white
        label.textAlignment = .left
        label.backgroundColor = .clear
        return label
    }()
    
    private lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Type member name"
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.font = UIFont(name: "AvenirNext-Regular", size: 15.0)
        textField.setDimensions(height: 40.0, width: 150.0)
        textField.layer.cornerRadius = 5.0
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 5.0, height: 40.0))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.returnKeyType = .done
        textField.delegate = self
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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()

    }
    
    // MARK: - Helper Functions
    
    private func configureUI() {
        
        configureGradientLayer()
        
        title = "Create New Chat"
        navigationItem.backButtonTitle = ""

        navigationController?.navigationBar.barTintColor = .systemBlue
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30)]
        navigationController?.navigationBar.barStyle = .black
        
        view.addSubview(memberSearchLabel)
        memberSearchLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, paddingTop: 40.0, paddingLeft: 16.0)
        
        view.addSubview(searchTextField)
        searchTextField.anchor(left: memberSearchLabel.rightAnchor, paddingLeft: 8.0)
        searchTextField.centerY(inView: memberSearchLabel)
        
        view.addSubview(messageTextView)
        messageTextView.anchor(top: searchTextField.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 25.0, paddingLeft: 32.0, paddingRight: 32.0)
        
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
        let controller = OpenCurrentChatVC()
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        controller.selectedChat = ["Name":searchTextField.text ?? "Craig", "Message":messageTextView.text, "Timestamp":" 18:06 hrs"]
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension CreateNewChatVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDoneClicked))
    }
}

extension CreateNewChatVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
}
