//
//  ChatVC.swift
//  Find My Lift
//
//  Created by Stephen Learmonth on 29/09/2020.
//  Copyright © 2020 Stephen Learmonth. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {

    // MARK: - Properties
    
    private let cellID = "ChatVCCellID"
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.rowHeight = 60
        tableView.register(ChatVCCell.self, forCellReuseIdentifier: cellID)
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    private let chats:[[String:String]] = [
        ["Name":"Louise", "Message":"Hey Craig, I need a lift tonight", "Timestamp":"14:38 hrs"],
        ["Name":"James", "Message":"Sorry mate, I need to cancel the lift", "Timestamp":"17:59 hrs"],
        ["Name":"Sally", "Message":"Any chance of lift soon Craig?", "Timestamp":"16:29hrs"]
    ]
    
    private let newMessageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.imageView?.setDimensions(height: 24, width: 24)
        button.setDimensions(height: 56, width: 56)
        button.layer.cornerRadius = 56 / 2
        button.addTarget(self, action: #selector(showNewMessage), for: .touchUpInside)
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
        
        title = "Chat Conversations"
        navigationItem.backButtonTitle = ""

        navigationController?.navigationBar.barTintColor = .systemBlue
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30)]
        navigationController?.navigationBar.barStyle = .black
        
        view.addSubview(tableView)
        tableView.frame = view.frame
        
        view.addSubview(newMessageButton)
        newMessageButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,
                                paddingBottom: 16, paddingRight: 24)

    }
    
    // MARK: - Selectors
    
    @objc func showNewMessage() {
        let controller = CreateNewChatVC()
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

extension ChatVC: UITableViewDelegate {
 
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UILabel()
        header.text = "Current Chats"
        header.textColor = .white
        header.textAlignment = .center
        header.font = UIFont(name: "AvenirNext-DemiBold", size: 20.0)
        header.backgroundColor = .clear
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = OpenCurrentChatVC()
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        controller.selectedChat = chats[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension ChatVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        chats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! ChatVCCell
        cell.nameLabel.text = chats[indexPath.row]["Name"]
        cell.messageTextLabel.text = chats[indexPath.row]["Message"]
        cell.timestampLabel.text = chats[indexPath.row]["Timestamp"]
        let backgroundView = UIView()
        backgroundView.backgroundColor = .systemGreen
           cell.selectedBackgroundView = backgroundView
        return cell
    }
    
    
}
