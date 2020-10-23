//
//  MatchingLiftRequestsVC.swift
//  Find My Lift
//
//  Created by Stephen Learmonth on 23/10/2020.
//  Copyright © 2020 Stephen Learmonth. All rights reserved.
//

import UIKit

class MatchingLiftRequestsVC: UIViewController {

    // MARK: - Properties
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 40
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MLRCell.self, forCellReuseIdentifier: cellID)
        tableView.setHeight(height: CGFloat(60.0 + Double(40 * maxNumberOfRows)))
        tableView.setWidth(width: self.view.frame.width - 16.0)
        tableView.bounces = false
        return tableView
    }()
    
    private let liftMatchDetails: [[String:String]] = [
        ["Group" : "Work", "Passenger" : "Lewis", "Pickup Time" : "1:50pm"],
        ["Group" : "Gym", "Passenger" : "Laura", "Pickup Time" : "2:35pm"],
        ["Group" : "Swimming", "Passenger" : "Bill", "Pickup Time" : "1:55pm"],
        ["Group" : "Running", "Passenger" : "Larry", "Pickup Time" : "2:20pm"],
        ["Group" : "Work", "Passenger" : "Louise", "Pickup Time" : "2:45pm"],
        ["Group" : "My Village", "Passenger" : "George", "Pickup Time" : "1:40pm"],
        ["Group" : "Gym", "Passenger" : "Graham", "Pickup Time" : "2:20pm"],
        ["Group" : "College", "Passenger" : "Gemma", "Pickup Time" : "2:10pm"],
        ["Group" : "Tennis", "Passenger" : "Leonard", "Pickup Time" : "1:25pm"],
        ["Group" : "Work", "Passenger" : "Leslie", "Pickup Time" : "1:40pm"],
        ["Group" : "Work", "Passenger":"Lorna", "Pickup Time" : "2:05pm"],
        ["Group" : "Tennis", "Passenger" : "Brian", "Pickup Time" : "1:55pm"],
        ["Group" : "Work", "Passenger" : "Bradley", "Pickup Time" : "2:15pm"],
        ["Group" : "Collge", "Passenger" : "Bob", "Pickup Time" : "1:40pm"],
        ["Group" : "Gym", "Passenger" : "Brendan", "Pickup Time" : "2:15pm"],
        ["Group" : "My Village", "Passenger" : "Ben", "Pickup Time" : "2:20pm"]]
    
    private var liftMatchDetailsQuerySearch = [[String : String]]()
    
    private var listSearchResults = false
    
    private let cellID = "LiftMatchCell"
    
    private let maxNumberOfRows = 5
    
    private lazy var sortView = LASortView()

  
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
    }

    // MARK: - Helper Functions
    
    private func configureUI() {
        
        configureGradientLayer()
        
        title = "Matching Lift Requests"
        navigationItem.backButtonTitle = ""
        
        navigationController?.navigationBar.barTintColor = .systemBlue
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30)]
        navigationController?.navigationBar.barStyle = .black
        
        view.addSubview(tableView)
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 40.0, width: view.frame.width - 16.0)
        tableView.centerX(inView: view)

    }

}

extension MatchingLiftRequestsVC : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = MLRHeader(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 60.0))
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60.0
    }
}

extension MatchingLiftRequestsVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        liftMatchDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! MLRCell
        if listSearchResults == false {
            cell.groupLabel.text = liftMatchDetails[indexPath.row]["Group"]
            cell.passengerLabel.text = liftMatchDetails[indexPath.row]["Passenger"]
            cell.pickupTimeLabel.text = liftMatchDetails[indexPath.row]["Pickup Time"]
        } else {
//            cell.driverLabel.text = liftMatchDetailsQuerySearch[indexPath.row]["Driver"]
//            cell.pickupTimeLabel.text = liftAvailabilityDetailsQuerySearch[indexPath.row]["Pickup Time"]
        }

        return cell
    }
    

}
