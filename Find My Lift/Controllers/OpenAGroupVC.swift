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
    
    // MARK: - Helper Functions
    
    private func configureUI() {
        
        configureGradientLayer()
        
        title = selectedGroup
        navigationItem.backButtonTitle = ""

        navigationController?.navigationBar.barTintColor = .systemBlue
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30)]
        navigationController?.navigationBar.barStyle = .black
        
        contentView.addSubview(listMembersButton)
        listMembersButton.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 40.0, paddingLeft: 32.0, paddingRight: 32.0, height: 50.0)
        
        contentView.addSubview(requestButton)
        requestButton.anchor(top: listMembersButton.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 25.0, paddingLeft: 32.0, paddingRight: 32.0, height: 50.0)

        contentView.addSubview(contactButton)
        contactButton.anchor(top: requestButton.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 25.0, paddingLeft: 32.0, paddingRight: 32.0, height: 50.0)

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
