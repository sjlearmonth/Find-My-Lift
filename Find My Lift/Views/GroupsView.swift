//
//  GroupsView.swift
//  Find My Lift
//
//  Created by Stephen Learmonth on 01/10/2020.
//  Copyright © 2020 Stephen Learmonth. All rights reserved.
//

import UIKit

protocol GroupsViewDelegate : class {
    func readSelectedGroup(group: String)
}

class GroupsView: UITableView {
    
    // MARK: - Properties
    
    private let cellID = "GroupsViewCell"
    
    weak var groupsViewDelegate: GroupsViewDelegate?
    
    private let groupCategories : [String] = ["Work", "Gym", "College", "My Village", "Running Club"]
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        configureTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Helper Functions
    private func configureTableView() {
        backgroundColor = .white
        setHeight(height: 150)
        setWidth(width: 250)
        rowHeight = 30
        dataSource = self
        delegate = self
        tableFooterView = UIView()
        register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
}

extension GroupsView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        groupsViewDelegate?.readSelectedGroup(group: groupCategories[indexPath.row])
        
        return
    }
}

extension GroupsView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groupCategories.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        cell.textLabel?.text = groupCategories[indexPath.row]
        cell.textLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 18)
        cell.layer.borderWidth = 1
        return cell
    }
}
