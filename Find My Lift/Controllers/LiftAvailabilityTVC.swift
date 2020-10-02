//
//  LiftAvailabilityTVC.swift
//  Find My Lift
//
//  Created by Stephen Learmonth on 02/10/2020.
//  Copyright © 2020 Stephen Learmonth. All rights reserved.
//

import UIKit

class LiftAvailabilityTVC: UITableViewController {

    // MARK: - Properties
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private let liftAvailabilityDetails: [[String:String]] = [ ["Group":"Work", "Driver":"Mark", "Pickup Time":"2pm"],
                                                               ["Group":"Gym", "Driver":"Louise", "Pickup Time":"11:15am"],
                                                               ["Group":"My Village", "Driver":"Bill", "Pickup Time":"3:45pm"],
                                                               ["Group":"Swimming Club", "Driver":"John", "Pickup Time":"8:00am"]]
    private let cellID = "LiftAvailabilityCell"
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        
        configureTableView()
        
    }
    
    // MARK: - Helper Functions
    
    private func configureUI() {
    
        title = "Lift Availability"
        navigationItem.backButtonTitle = ""
        
        navigationController?.navigationBar.barTintColor = .systemBlue
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30)]
        navigationController?.navigationBar.barStyle = .black
    }
    
    private func configureTableView() {
        
        tableView.rowHeight = 40
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LiftAvailabilityCell.self, forCellReuseIdentifier: cellID)
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! LiftAvailabilityCell
        cell.groupLabel.text = liftAvailabilityDetails[indexPath.row]["Group"]
        cell.driverLabel.text = liftAvailabilityDetails[indexPath.row]["Driver"]
        cell.pickupTimeLabel.text = liftAvailabilityDetails[indexPath.row]["Pickup Time"]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return liftAvailabilityDetails.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = HeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 60.0))
        
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = FooterView(frame: CGRect(x: 10, y: 10, width: tableView.frame.width-20, height: 200))
        return footerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60.0
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 200.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = LiftOfferReviewVC()
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        navigationController?.pushViewController(controller, animated: true)
    }
}

