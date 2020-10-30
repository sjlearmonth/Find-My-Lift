//
//  OpenAGroupVC.swift
//  Find My Lift
//
//  Created by Stephen Learmonth on 27/10/2020.
//  Copyright © 2020 Stephen Learmonth. All rights reserved.
//

import UIKit

class OpenAGroupVC: UIViewController {

    // MARK: - Properties
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var selectedGroup = ""
    
    private lazy var listMembersButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("List of Members", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGreen
        button.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 20.0)
        button.addTarget(self, action: #selector(handleListOfMembers), for: .touchUpInside)
        button.layer.cornerRadius = 25.0
        return button
    }()

    private lazy var requestButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Request to add Member", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGreen
        button.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 20.0)
        button.addTarget(self, action: #selector(handleRequestToAdd), for: .touchUpInside)
        button.layer.cornerRadius = 25.0
        return button
    }()

    private lazy var contactButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Contact Admin", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGreen
        button.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 20.0)
        button.addTarget(self, action: #selector(handleContactAdmin), for: .touchUpInside)
        button.layer.cornerRadius = 25.0
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
        
        title = selectedGroup
        navigationItem.backButtonTitle = ""

        navigationController?.navigationBar.barTintColor = .systemBlue
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30)]
        navigationController?.navigationBar.barStyle = .black
        
        view.addSubview(listMembersButton)
        listMembersButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 40.0, paddingLeft: 32.0, paddingRight: 32.0, height: 50.0)
        
        view.addSubview(requestButton)
        requestButton.anchor(top: listMembersButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 25.0, paddingLeft: 32.0, paddingRight: 32.0, height: 50.0)

        view.addSubview(contactButton)
        contactButton.anchor(top: requestButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 25.0, paddingLeft: 32.0, paddingRight: 32.0, height: 50.0)

    }

    // MARK: - Selectors
    
    @objc func handleListOfMembers() {
        print("DEBUG: list of members clicked")
        let controller = ListOfMembersVC()
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func handleRequestToAdd() {
        print("DEBUG: request to add clicked")
        let controller = RequestAddMemberVC()
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func handleContactAdmin() {
        print("DEBUG: contact admin clicked")
        let controller = ContactAdminVC()
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        navigationController?.pushViewController(controller, animated: true)
    }

}
