//
//  MatchedLiftRequestsVC.swift
//  Find My Lift
//
//  Created by Stephen Learmonth on 23/10/2020.
//  Copyright © 2020 Stephen Learmonth. All rights reserved.
//

import UIKit

class MatchedLiftRequestsVC: UIViewController {

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
    
    private lazy var sortView = MLRSortView()

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
        
        configureNotificationObservers()
        
        configureScrollView()
        
    }

    // MARK: - Helper Functions
    
    private func configureUI() {
        
        configureGradientLayer()
        
        title = "Matched Lift Requests"
        navigationItem.backButtonTitle = ""
        
        navigationController?.navigationBar.barTintColor = .systemBlue
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30)]
        navigationController?.navigationBar.barStyle = .black
        
        contentView.addSubview(tableView)
        tableView.anchor(top: contentView.topAnchor, paddingTop: 40.0, width: contentView.frame.width - 16.0)
        tableView.centerX(inView: contentView)
        
        sortView.isUserInteractionEnabled = true
        
        contentView.addSubview(sortView)
        sortView.delegate = self
        sortView.anchor(top: tableView.bottomAnchor,
                        left: contentView.leftAnchor,
                        right: contentView.rightAnchor,
                        paddingTop: 40,
                        paddingLeft: 32,
                        paddingRight: 32,
                        width: contentView.frame.width - 64.0,
                        height: 100.0)
    }
    
    private func configureNotificationObservers() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
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
    
    @objc func keyboardWillShow() {
        if view.frame.origin.y == 64 {
            view.frame.origin.y -= 164
        }
    }
    
    @objc func keyboardWillHide() {
        if view.frame.origin.y != 64 {
        view.frame.origin.y = 64
        }
    }
}

extension MatchedLiftRequestsVC : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = MatchesReview()
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        if listSearchResults == false {
            controller.selectedGroup = liftMatchDetails[indexPath.row]["Group"]!
            controller.selectedPassenger = liftMatchDetails[indexPath.row]["Passenger"]!
            controller.selectedPickupTime = liftMatchDetails[indexPath.row]["Pickup Time"]!
        } else {
            controller.selectedGroup = liftMatchDetailsQuerySearch[indexPath.row]["Group"]!
            controller.selectedPassenger = liftMatchDetailsQuerySearch[indexPath.row]["Passenger"]!
            controller.selectedPickupTime = liftMatchDetailsQuerySearch[indexPath.row]["Pickup Time"]!
        }
        navigationController?.pushViewController(controller, animated: true)
    }
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

extension MatchedLiftRequestsVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if listSearchResults == false {
            return liftMatchDetails.count
        } else {
            return liftMatchDetailsQuerySearch.count
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! MLRCell
        if listSearchResults == false {
            cell.groupLabel.text = liftMatchDetails[indexPath.row]["Group"]
            cell.passengerLabel.text = liftMatchDetails[indexPath.row]["Passenger"]
            cell.pickupTimeLabel.text = liftMatchDetails[indexPath.row]["Pickup Time"]
        } else {
            cell.groupLabel.text = liftMatchDetailsQuerySearch[indexPath.row]["Group"]
            cell.passengerLabel.text = liftMatchDetailsQuerySearch[indexPath.row]["Passenger"]
            cell.pickupTimeLabel.text = liftMatchDetailsQuerySearch[indexPath.row]["Pickup Time"]
        }

        return cell
    }
}

extension MatchedLiftRequestsVC: MLRSortViewDelegate {
    
    func executeDynamicSearch(query: String, type: radioButtonStates) {
        
        liftMatchDetailsQuerySearch.removeAll()
        listSearchResults = false
        for tableRow in liftMatchDetails {
            
            if type == .group {
                
                guard let groupName = tableRow["Group"] else { return }
                
                if groupName.contains(query) {
                    
                    let querySearchResultRow = tableRow
                    liftMatchDetailsQuerySearch.append(querySearchResultRow)
                    
                    listSearchResults = true
                    
                }
            } else if type == .passenger {
                
                guard let passengerName = tableRow["Passenger"] else { return }
                
                if passengerName.contains(query) {
                    
                    let querySearchResultRow = tableRow
                    liftMatchDetailsQuerySearch.append(querySearchResultRow)
                    
                    listSearchResults = true
                }
            } else {
                guard let pickupTime = tableRow["Pickup Time"] else { return }
                
                if pickupTime.contains(query) {
                    let querySearchResultRow = tableRow
                    liftMatchDetailsQuerySearch.append(querySearchResultRow)
                    
                    listSearchResults = true
                }
            }
        }
        
        tableView.reloadData()
    }
}
