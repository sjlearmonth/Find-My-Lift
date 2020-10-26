//
//  LiftAvailabilityVC.swift
//  Find My Lift
//
//  Created by Stephen Learmonth on 02/10/2020.
//  Copyright © 2020 Stephen Learmonth. All rights reserved.
//

import UIKit

class LiftAvailabilityVC: UIViewController {

    // MARK: - Properties
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 40
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LACell.self, forCellReuseIdentifier: cellID)
        tableView.setHeight(height: CGFloat(120.0 + Double(40 * maxNumberOfRows)))
        tableView.setWidth(width: self.view.frame.width - 64.0)
        tableView.bounces = false
        return tableView
    }()
    
    private let liftAvailabilityDetails: [[String:String]] = [ ["Driver":"Lewis", "Pickup Time":"1:50pm"],
                                                               ["Driver":"Laura", "Pickup Time":"2:05pm"],
                                                               ["Driver":"Bill", "Pickup Time":"1:55pm"],
                                                               ["Driver":"Larry", "Pickup Time":"1:50pm"],
                                                               ["Driver":"Louise", "Pickup Time":"2:05pm"],
                                                               ["Driver":"George", "Pickup Time":"1:55pm"],
                                                               ["Driver":"Graham", "Pickup Time":"1:50pm"],
                                                               ["Driver":"Gemma", "Pickup Time":"2:05pm"],
                                                               ["Driver":"Leonard", "Pickup Time":"1:55pm"],
                                                               ["Driver":"Leslie", "Pickup Time":"1:50pm"],
                                                               ["Driver":"Lorna", "Pickup Time":"2:05pm"],
                                                               ["Driver":"Brian", "Pickup Time":"1:55pm"],
                                                               ["Driver":"Bradley", "Pickup Time":"2:15pm"],
                                                               ["Driver":"Bob", "Pickup Time":"2:15pm"],
                                                               ["Driver":"Brendan", "Pickup Time":"2:15pm"],
                                                               ["Driver":"Ben", "Pickup Time":"2:15pm"]]
    
    private var liftAvailabilityDetailsQuerySearch = [[String : String]]()
    
    private var listSearchResults = false
    
    private let cellID = "LiftAvailabilityCell"
    
    private let maxNumberOfRows = 5
    
    private lazy var sortView = LASortView()
    
    var selectedGroup: String = ""
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()

    }
    
    // MARK: - Helper Functions
    
    private func configureUI() {
    
        configureGradientLayer()
        
        title = "Lift Availability"
        navigationItem.backButtonTitle = ""
        
        navigationController?.navigationBar.barTintColor = .systemBlue
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30)]
        navigationController?.navigationBar.barStyle = .black
        
        view.addSubview(tableView)
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 40.0)
        tableView.centerX(inView: view)
        
        sortView.isUserInteractionEnabled = true
        
        view.addSubview(sortView)
        sortView.delegate = self
        sortView.anchor(top: tableView.bottomAnchor,
                        left: view.leftAnchor,
                        right: view.rightAnchor,
                        paddingTop: 40,
                        paddingLeft: 32,
                        paddingRight: 32,
                        width: view.frame.width,
                        height: 100)
    }
    
    @objc func handleClickMe() {
        print("DEBUG: click me clicked")
    }
}

extension LiftAvailabilityVC: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = LiftOfferReviewVC()
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = LAHeader(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 120.0))
        headerView.groupHeaderLabel.text = selectedGroup + " Group"
        return headerView
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 120.0
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }
}

extension LiftAvailabilityVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if listSearchResults == false {
            return liftAvailabilityDetails.count
        } else {
            return liftAvailabilityDetailsQuerySearch.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! LACell
        if listSearchResults == false {
            cell.driverLabel.text = liftAvailabilityDetails[indexPath.row]["Driver"]
            cell.pickupTimeLabel.text = liftAvailabilityDetails[indexPath.row]["Pickup Time"]
        } else {
            cell.driverLabel.text = liftAvailabilityDetailsQuerySearch[indexPath.row]["Driver"]
            cell.pickupTimeLabel.text = liftAvailabilityDetailsQuerySearch[indexPath.row]["Pickup Time"]
        }
        return cell
    }
}

extension LiftAvailabilityVC: LASortViewDelegate {
    
    func executeDynamicSearch(query: String, type: radioButtonStates) {
        
        liftAvailabilityDetailsQuerySearch = [[String:String]]()
        listSearchResults = false
        for tableRow in liftAvailabilityDetails {
            if type == .driver {
                
            guard let driverName = tableRow["Driver"] else { return }
            
            if driverName.contains(query) {
                
                let querySearchResultRow = tableRow
                liftAvailabilityDetailsQuerySearch.append(querySearchResultRow)
             
                listSearchResults = true
            }
            } else {
                guard let pickupTime = tableRow["Pickup Time"] else { return }
                
                if pickupTime.contains(query) {
                    let querySearchResultRow = tableRow
                    liftAvailabilityDetailsQuerySearch.append(querySearchResultRow)
                    
                    listSearchResults = true
                }
            }
        }

        tableView.reloadData()
    }
}
