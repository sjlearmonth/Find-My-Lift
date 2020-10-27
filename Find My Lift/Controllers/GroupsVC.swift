//
//  GroupsVC.swift
//  Find My Lift
//
//  Created by Stephen Learmonth on 29/09/2020.
//  Copyright © 2020 Stephen Learmonth. All rights reserved.
//

import UIKit

class GroupsVC: UIViewController {

    // MARK: - Properties
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private let cellID = "GroupsVCCellID"
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 40.0
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .white
        return tableView
    }()
    
    private let groupCategories : [String] = ["Work", "Gym", "College", "My Village", "Running", "Swimming", "Tennis"]
    
    private let maxNumberOfRows = 6
    
    private let createButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Create a new group", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGreen
        button.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 18.0)
        button.layer.cornerRadius = 25.0
        button.addTarget(self, action: #selector(handleCreateNewGroup), for: .touchUpInside)
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
        
        title = "Groups"

        navigationController?.navigationBar.barTintColor = .systemBlue
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30)]
        navigationController?.navigationBar.barStyle = .black
        
        view.addSubview(tableView)
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 40.0, paddingLeft: 32.0, paddingRight: 32.0, height: 60.0 + 40.0 *  CGFloat(maxNumberOfRows))
        
        view.addSubview(createButton)
        createButton.anchor(top: tableView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,
                            paddingTop: 25.0, paddingLeft: 32.0, paddingRight: 32.0, height: 50.0)

    }
    
    // MARK: - Selectors
    
    @objc func handleCreateNewGroup() {
        print("DEBUG: create a new group clicked")
        let controller = CreateNewGroupVC()
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        navigationController?.pushViewController(controller, animated: true)
    }

}

extension GroupsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60.0
    }
    

    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Groups"
        label.textColor = .white
        label.backgroundColor = .systemGreen
        label.textAlignment = .center
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 30.0)
        return label
    }
}

extension GroupsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groupCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID)!
        cell.textLabel?.text = groupCategories[indexPath.row]
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.systemBlue
        cell.selectedBackgroundView = backgroundView
        return cell
    }
    
}
