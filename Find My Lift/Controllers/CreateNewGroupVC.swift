//
//  CreateANewGroupVC.swift
//  Find My Lift
//
//  Created by Stephen Learmonth on 27/10/2020.
//  Copyright © 2020 Stephen Learmonth. All rights reserved.
//

import UIKit

class CreateNewGroupVC: UIViewController {

    // MARK: - Properties
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name of Group:"
        label.textColor = .white
        label.backgroundColor = .clear
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 20.0)
        return label
    }()
    
    private lazy var nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "John Smith"
        tf.textColor = .black
        tf.backgroundColor = .white
        tf.layer.cornerRadius = 5.0
        tf.font = UIFont(name: "AvenirNext-Regular", size: 18.0)
        tf.setWidth(width: 150.0)
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
        tf.leftViewMode = .always
        tf.returnKeyType = .done
        tf.delegate = self
        return tf
    }()

    private let inviteLabel: UILabel = {
        let label = UILabel()
        label.text = "Invite Member:"
        label.textColor = .white
        label.backgroundColor = .clear
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 20.0)
        return label
    }()
    
    private lazy var inviteTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "John Smith"
        tf.textColor = .black
        tf.backgroundColor = .white
        tf.layer.cornerRadius = 5.0
        tf.font = UIFont(name: "AvenirNext-Regular", size: 18.0)
        tf.setWidth(width: 150.0)
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
        tf.leftViewMode = .always
        tf.returnKeyType = .done
        tf.delegate = self
        return tf
    }()

    private let cellID = "MembersCellID"
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 40.0
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    private let maxNumOfRows = 6
    
    private var members = [String]()
    
    private lazy var createButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Create Group", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 20.0)
        button.addTarget(self, action: #selector(handleCreateGroup), for: .touchUpInside)
        button.layer.cornerRadius = 25.0
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


    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        configureScrollView()

    }
    
    // MARK: - Helper Functions
    
    private func configureUI() {
        
        configureGradientLayer()
        
        title = "Create New Group"
        navigationItem.backButtonTitle = ""

        navigationController?.navigationBar.barTintColor = .systemBlue
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30)]
        navigationController?.navigationBar.barStyle = .black
        
        contentView.addSubview(nameLabel)
        nameLabel.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, paddingTop: 40.0, paddingLeft: 32.0)
        
        contentView.addSubview(nameTextField)
        nameTextField.anchor(left: nameLabel.rightAnchor, paddingLeft: 10.0, height: 35.0)
        nameTextField.centerY(inView: nameLabel)
        
        contentView.addSubview(inviteLabel)
        inviteLabel.anchor(top: nameLabel.bottomAnchor, left: contentView.leftAnchor, paddingTop: 40.0, paddingLeft: 32.0)
        
        contentView.addSubview(inviteTextField)
        inviteTextField.anchor(left: inviteLabel.rightAnchor, paddingLeft: 10.0, height: 35.0)
        inviteTextField.centerY(inView: inviteLabel)
        
        contentView.addSubview(tableView)
        tableView.anchor(top: inviteLabel.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 40.0, paddingLeft: 32.0, paddingRight: 32.0, height: 60.0 + 40.0 * CGFloat(maxNumOfRows))
        
        contentView.addSubview(createButton)
        createButton.anchor(top: tableView.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 40.0, paddingLeft: 32.0, paddingRight: 32.0, height: 50.0)
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
    
    @objc func handleCreateGroup() {
        print("DEBUG: create group clicked")
        let controller = OpenAGroupVC()
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        controller.selectedGroup = nameTextField.text ?? ""
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension CreateNewGroupVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Invited Members"
        label.textColor = .white
        label.backgroundColor = .systemGreen
        label.textAlignment = .center
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 30.0)
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60.0
    }
}

extension CreateNewGroupVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID)!
        if members.isEmpty == false {
            cell.textLabel?.text = members[indexPath.row]
            let backgroundView = UIView()
            backgroundView.backgroundColor = UIColor.systemBlue
            cell.selectedBackgroundView = backgroundView
        } else {
            cell.textLabel?.text = ""
        }
        return cell
    }
}

extension CreateNewGroupVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        guard let memberName = textField.text else { return false }
        if textField == inviteTextField {
            members.append(memberName)
            textField.text = ""
            tableView.reloadData()
        }
        
        return false
    }
}
