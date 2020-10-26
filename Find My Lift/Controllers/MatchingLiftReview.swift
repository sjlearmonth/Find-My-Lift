//
//  MatchingLiftReview.swift
//  Find My Lift
//
//  Created by Stephen Learmonth on 26/10/2020.
//  Copyright © 2020 Stephen Learmonth. All rights reserved.
//

import UIKit

class MatchingLiftReview: UIViewController {

    // MARK: - Properties
    
    var selectedGroup = ""
    var selectedPassenger = ""
    var selectedPickupTime = ""
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.rowHeight = 40.0
        tv.delegate = self
        tv.dataSource = self
        tv.register(MLR2Cell.self, forCellReuseIdentifier: cellID)
        return tv
    }()

    private let cellID = "MatchingLiftReviewCellID"
    
    private let messageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Message Passenger", for: .normal)
        button.layer.cornerRadius = 10.0
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.setHeight(height: 50.0)
        button.addTarget(self, action: #selector(handleMessagePassenger), for: .touchUpInside)
        return button
    }()
 
    private let offerLiftButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Offer Lift", for: .normal)
        button.layer.cornerRadius = 10.0
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.setHeight(height: 50.0)
        button.addTarget(self, action: #selector(handleOfferLift), for: .touchUpInside)
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
        
        title = "Matching Lift Review"
        navigationItem.backButtonTitle = ""

        navigationController?.navigationBar.barTintColor = .systemBlue
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30)]
        navigationController?.navigationBar.barStyle = .black
        
        view.addSubview(tableView)
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 40.0, paddingLeft: 32.0, paddingRight: 32.0, height: 180.0)
        
        view.addSubview(messageButton)
        messageButton.anchor(top: tableView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 25.0, paddingLeft: 32.0, paddingRight: 32.0)

        view.addSubview(offerLiftButton)
        offerLiftButton.anchor(top: messageButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 25.0, paddingLeft: 32.0, paddingRight: 32.0)

    }
    
    // MARK: - Selectors
    
    @objc func handleMessagePassenger() {
        print("DEBUG: message passenger clicked")
        let controller = ChatVC()
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func handleOfferLift() {
        print("DEBUG: offer lift clicked")
        let controller = LiftOfferSent()
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension MatchingLiftReview : UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = MLR2Header(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 60.0))
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60.0
    }
}

extension MatchingLiftReview : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! MLR2Cell
        
        switch indexPath.row {
        case 0:
            cell.nameLabel.text = "Group:"
            cell.valueLabel.text = selectedGroup
        case 1:
            cell.nameLabel.text = "Name:"
            cell.valueLabel.text = selectedPassenger
        case 2:
            cell.nameLabel.text = "Pickup Time:"
            cell.valueLabel.text = selectedPickupTime
        default:
            break
        }
        return cell
    }
    
    
}
