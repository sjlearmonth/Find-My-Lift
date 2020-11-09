//
//  ActiveOffersAnfLiftsVC.swift
//  Find My Lift
//
//  Created by Stephen Learmonth on 29/09/2020.
//  Copyright © 2020 Stephen Learmonth. All rights reserved.
//

import UIKit

class ActiveOffersAndLiftsVC: UIViewController {

    // MARK: - Properties
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private let pendingOffersCellID = "PendingOffersCellID"
    
    private lazy var pendingOffersTableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(ActiveOffersAndLiftsCell.self, forCellReuseIdentifier: pendingOffersCellID)
        tv.bounces = false
        tv.rowHeight = 40.0
        tv.showsVerticalScrollIndicator = false
        return tv
    }()
    
    private let pendingOffers: [[String:String]] = [
        ["Start":"LU6 1AW","End":"MK45 4JN", "Date":"06-11-20", "Time":"07:45 hrs", "Detour":"5 miles"],
        ["Start":"LU5 4PQ","End":"MK45 9PR","Date":"08-11-20","Time":"18:45 hrs","Detour":"10 miles"],
        ["Start":"LU6 1AW","End":"MK45 9PR","Date":"12-11-20","Time":"12:15 hrs","Detour":"12 miles"],
        ["Start":"LU2 0KL","End":"LU7 7TR","Date":"14-11-20","Time":"16:35 hrs","Detour":"4 miles"],
        ["Start":"LU5 8RT","End":"MK45 5PY","Date":"16-11-20","Time":"09:45 hrs","Detour":"5 miles"],
        ["Start":"LU5 7UW","End":"MK45 6TQ","Date":"19-11-20","Time":"10:15 hrs","Detour":"15 miles"],
        ["Start":"LU6 1AW","End":"MK45 4JN", "Date":"06-11-20", "Time":"07:45 hrs", "Detour":"5 miles"],
        ["Start":"LU5 4PQ","End":"MK45 9PR","Date":"08-11-20","Time":"18:45 hrs","Detour":"10 miles"],
        ["Start":"LU6 1AW","End":"MK45 9PR","Date":"12-11-20","Time":"12:15 hrs","Detour":"12 miles"],
        ["Start":"LU2 0KL","End":"LU7 7TR","Date":"14-11-20","Time":"16:35 hrs","Detour":"4 miles"],
        ["Start":"LU5 8RT","End":"MK45 5PY","Date":"16-11-20","Time":"09:45 hrs","Detour":"5 miles"],
        ["Start":"LU5 7UW","End":"MK45 6TQ","Date":"19-11-20","Time":"10:15 hrs","Detour":"15 miles"]
    ]
    
    private let pendingLiftsCellID = "PendingLiftsCellID"
    
    private lazy var pendingLiftsTableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(ActiveOffersAndLiftsCell.self, forCellReuseIdentifier: pendingLiftsCellID)
        tv.bounces = false
        tv.rowHeight = 40.0
        tv.showsVerticalScrollIndicator = false
        return tv
    }()
    
    private let pendingLifts: [[String:String]] = [
        ["Driver":"Louise", "Reg":"KN69 PFY", "Colour":"White", "Date":"06-11-20", "Time":"07:45 hrs"],
        ["Driver":"Mark", "Reg":"LP05 TGH", "Colour":"Grey", "Date":"08-11-20", "Time":"18:45 hrs"],
        ["Driver":"John", "Reg":"SY60 PLO", "Colour":"Blue", "Date":"12-11-20", "Time":"12:15 hrs"],
        ["Driver":"Sally", "Reg":"GR08 WAQ", "Colour":"Red", "Date":"14-11-20", "Time":"16:35 hrs"],
        ["Driver":"Bob", "Reg":"RT12 ERQ", "Colour":"Silver", "Date":"16-11-20","Time":"09:45 hrs"],
        ["Driver":"Danny", "Reg":"GH14 HZZ", "Colour":"White", "Date":"19-11-20","Time":"10:15 hrs"],
        ["Driver":"Louise", "Reg":"KN69 PFY", "Colour":"White", "Date":"06-11-20", "Time":"07:45 hrs"],
        ["Driver":"Mark", "Reg":"LP05 TGH", "Colour":"Grey", "Date":"08-11-20", "Time":"18:45 hrs"],
        ["Driver":"John", "Reg":"SY60 PLO", "Colour":"Blue", "Date":"12-11-20", "Time":"12:15 hrs"],
        ["Driver":"Sally", "Reg":"GR08 WAQ", "Colour":"Red", "Date":"14-11-20", "Time":"16:35 hrs"],
        ["Driver":"Bob", "Reg":"RT12 ERQ", "Colour":"Silver", "Date":"16-11-20","Time":"09:45 hrs"],
        ["Driver":"Danny", "Reg":"GH14 HZZ", "Colour":"White", "Date":"19-11-20","Time":"10:15 hrs"]
    ]

    private let confirmedOffersCellID = "ConfirmedOffersCellID"
    
    private lazy var confirmedOffersTableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(ActiveOffersAndLiftsCell.self, forCellReuseIdentifier: confirmedOffersCellID)
        tv.bounces = false
        tv.rowHeight = 40.0
        tv.showsVerticalScrollIndicator = false
        return tv
    }()
    
    private let confirmedOffers: [[String:String]] = [
        ["Start":"LU6 1AW", "End":"MK45 4JN", "Date":"06-11-20", "Time":"07:45 hrs", "Pass":"2"],
        ["Start":"LU5 4PQ", "End":"MK45 9PR", "Date":"08-11-20", "Time":"18:45 hrs", "Pass":"1"],
        ["Start":"LU6 1AW", "End":"MK45 9PR", "Date":"12-11-20", "Time":"12:15 hrs", "Pass":"1"],
        ["Start":"LU2 0KL", "End":"LU7 7TR", "Date":"14-11-20", "Time":"16:35 hrs", "Pass":"2"],
        ["Start":"LU5 8RT", "End":"MK45 5PY", "Date":"16-11-20", "Time":"09:45 hrs", "Pass":"3"],
        ["Start":"LU5 7UW", "End":"MK45 6TQ", "Date":"19-11-20", "Time":"10:15 hrs", "Pass":"2"],
        ["Start":"LU6 1AW", "End":"MK45 4JN", "Date":"06-11-20", "Time":"07:45 hrs", "Pass":"4"],
        ["Start":"LU5 4PQ", "End":"MK45 9PR", "Date":"08-11-20", "Time":"18:45 hrs", "Pass":"1"],
        ["Start":"LU6 1AW", "End":"MK45 9PR", "Date":"12-11-20", "Time":"12:15 hrs", "Pass":"3"],
        ["Start":"LU2 0KL", "End":"LU7 7TR", "Date":"14-11-20", "Time":"16:35 hrs", "Pass":"2"],
        ["Start":"LU5 8RT", "End":"MK45 5PY", "Date":"16-11-20", "Time":"09:45 hrs", "Pass":"4"],
        ["Start":"LU5 7UW", "End":"MK45 6TQ", "Date":"19-11-20", "Time":"10:15 hrs", "Pass":"1"]
    ]

    private let confirmedLiftsCellID = "ConfirmedLiftsCellID"
    
    private lazy var confirmedLiftsTableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(ActiveOffersAndLiftsCell.self, forCellReuseIdentifier: confirmedLiftsCellID)
        tv.bounces = false
        tv.rowHeight = 40.0
        tv.showsVerticalScrollIndicator = false
        return tv
    }()
    
    private let confirmedLifts: [[String:String]] = [
        ["Driver":"Louise", "Reg":"KN69 PFY", "Colour":"White", "Date":"06-11-20", "Time":"07:45 hrs"],
        ["Driver":"Mark", "Reg":"LP05 TGH", "Colour":"Grey", "Date":"08-11-20", "Time":"18:45 hrs"],
        ["Driver":"John", "Reg":"SY60 PLO", "Colour":"Blue", "Date":"12-11-20", "Time":"12:15 hrs"],
        ["Driver":"Sally", "Reg":"GR08 WAQ", "Colour":"Red", "Date":"14-11-20", "Time":"16:35 hrs"],
        ["Driver":"Bob", "Reg":"RT12 ERQ", "Colour":"Silver", "Date":"16-11-20","Time":"09:45 hrs"],
        ["Driver":"Danny", "Reg":"GH14 HZZ", "Colour":"White", "Date":"19-11-20","Time":"10:15 hrs"],
        ["Driver":"Louise", "Reg":"KN69 PFY", "Colour":"White", "Date":"06-11-20", "Time":"07:45 hrs"],
        ["Driver":"Mark", "Reg":"LP05 TGH", "Colour":"Grey", "Date":"08-11-20", "Time":"18:45 hrs"],
        ["Driver":"John", "Reg":"SY60 PLO", "Colour":"Blue", "Date":"12-11-20", "Time":"12:15 hrs"],
        ["Driver":"Sally", "Reg":"GR08 WAQ", "Colour":"Red", "Date":"14-11-20", "Time":"16:35 hrs"],
        ["Driver":"Bob", "Reg":"RT12 ERQ", "Colour":"Silver", "Date":"16-11-20","Time":"09:45 hrs"],
        ["Driver":"Danny", "Reg":"GH14 HZZ", "Colour":"White", "Date":"19-11-20","Time":"10:15 hrs"]
    ]
    
    private let offersHistoryCellID = "offersHistoryCellID"
    
    private lazy var offersHistoryTableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(ActiveOffersAndLiftsCell.self, forCellReuseIdentifier: offersHistoryCellID)
        tv.bounces = false
        tv.rowHeight = 40.0
        tv.showsVerticalScrollIndicator = false
        return tv
    }()
    
    private let offersHistory: [[String:String]] = [
        ["Start":"LU6 1AW","End":"MK45 4JN", "Date":"06-11-20", "Time":"07:45 hrs", "Detour":"5 miles"],
        ["Start":"LU5 4PQ","End":"MK45 9PR","Date":"08-11-20","Time":"18:45 hrs","Detour":"10 miles"],
        ["Start":"LU6 1AW","End":"MK45 9PR","Date":"12-11-20","Time":"12:15 hrs","Detour":"12 miles"],
        ["Start":"LU2 0KL","End":"LU7 7TR","Date":"14-11-20","Time":"16:35 hrs","Detour":"4 miles"],
        ["Start":"LU5 8RT","End":"MK45 5PY","Date":"16-11-20","Time":"09:45 hrs","Detour":"5 miles"],
        ["Start":"LU5 7UW","End":"MK45 6TQ","Date":"19-11-20","Time":"10:15 hrs","Detour":"15 miles"],
        ["Start":"LU6 1AW","End":"MK45 4JN", "Date":"06-11-20", "Time":"07:45 hrs", "Detour":"5 miles"],
        ["Start":"LU5 4PQ","End":"MK45 9PR","Date":"08-11-20","Time":"18:45 hrs","Detour":"10 miles"],
        ["Start":"LU6 1AW","End":"MK45 9PR","Date":"12-11-20","Time":"12:15 hrs","Detour":"12 miles"],
        ["Start":"LU2 0KL","End":"LU7 7TR","Date":"14-11-20","Time":"16:35 hrs","Detour":"4 miles"],
        ["Start":"LU5 8RT","End":"MK45 5PY","Date":"16-11-20","Time":"09:45 hrs","Detour":"5 miles"],
        ["Start":"LU5 7UW","End":"MK45 6TQ","Date":"19-11-20","Time":"10:15 hrs","Detour":"15 miles"]
    ]

    private let acceptedHistoryCellID = "AcceptedHistoryCellID"
    
    private lazy var acceptedHistoryTableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(ActiveOffersAndLiftsCell.self, forCellReuseIdentifier: acceptedHistoryCellID)
        tv.bounces = false
        tv.rowHeight = 40.0
        tv.showsVerticalScrollIndicator = false
        return tv
    }()
    
    private let acceptedHistory: [[String:String]] = [
        ["Driver":"Louise", "Reg":"KN69 PFY", "Colour":"White", "Date":"06-11-20", "Time":"07:45 hrs"],
        ["Driver":"Mark", "Reg":"LP05 TGH", "Colour":"Grey", "Date":"08-11-20", "Time":"18:45 hrs"],
        ["Driver":"John", "Reg":"SY60 PLO", "Colour":"Blue", "Date":"12-11-20", "Time":"12:15 hrs"],
        ["Driver":"Sally", "Reg":"GR08 WAQ", "Colour":"Red", "Date":"14-11-20", "Time":"16:35 hrs"],
        ["Driver":"Bob", "Reg":"RT12 ERQ", "Colour":"Silver", "Date":"16-11-20","Time":"09:45 hrs"],
        ["Driver":"Danny", "Reg":"GH14 HZZ", "Colour":"White", "Date":"19-11-20","Time":"10:15 hrs"],
        ["Driver":"Louise", "Reg":"KN69 PFY", "Colour":"White", "Date":"06-11-20", "Time":"07:45 hrs"],
        ["Driver":"Mark", "Reg":"LP05 TGH", "Colour":"Grey", "Date":"08-11-20", "Time":"18:45 hrs"],
        ["Driver":"John", "Reg":"SY60 PLO", "Colour":"Blue", "Date":"12-11-20", "Time":"12:15 hrs"],
        ["Driver":"Sally", "Reg":"GR08 WAQ", "Colour":"Red", "Date":"14-11-20", "Time":"16:35 hrs"],
        ["Driver":"Bob", "Reg":"RT12 ERQ", "Colour":"Silver", "Date":"16-11-20","Time":"09:45 hrs"],
        ["Driver":"Danny", "Reg":"GH14 HZZ", "Colour":"White", "Date":"19-11-20","Time":"10:15 hrs"]
    ]
    
    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.isScrollEnabled = true
        sv.bounces = false
        sv.showsVerticalScrollIndicator = false
        return sv
    }()
    
    private lazy var contentView: UIView = {
        let cv = UIView()
        cv.frame.size = CGSize(width: self.view.frame.width, height: self.view.frame.height * 4.0)
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
        
        navigationItem.title = "Active Lifts & Offers"
        navigationItem.backButtonTitle = ""

        navigationController?.navigationBar.barTintColor = .systemBlue
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30)]
        navigationController?.navigationBar.barStyle = .black
        
        contentView.addSubview(pendingOffersTableView)
        pendingOffersTableView.anchor(top: contentView.topAnchor,
                                      left: contentView.leftAnchor,
                                      right: contentView.rightAnchor,
                                      paddingTop: 0.0,
                                      paddingLeft: 0.0,
                                      paddingRight: 0.0,
                                      height: 90.0 + 6.0 * 40.0)
        
        contentView.addSubview(pendingLiftsTableView)
        pendingLiftsTableView.anchor(top: pendingOffersTableView.bottomAnchor,
                                      left: contentView.leftAnchor,
                                      right: contentView.rightAnchor,
                                      paddingTop: 75.0,
                                      paddingLeft: 0.0,
                                      paddingRight: 0.0,
                                      height: 90.0 + 6.0 * 40.0)

        contentView.addSubview(confirmedOffersTableView)
        confirmedOffersTableView.anchor(top: pendingLiftsTableView.bottomAnchor,
                                      left: contentView.leftAnchor,
                                      right: contentView.rightAnchor,
                                      paddingTop: 75.0,
                                      paddingLeft: 0.0,
                                      paddingRight: 0.0,
                                      height: 90.0 + 6.0 * 40.0)

        contentView.addSubview(confirmedLiftsTableView)
        confirmedLiftsTableView.anchor(top: confirmedOffersTableView.bottomAnchor,
                                      left: contentView.leftAnchor,
                                      right: contentView.rightAnchor,
                                      paddingTop: 75.0,
                                      paddingLeft: 0.0,
                                      paddingRight: 0.0,
                                      height: 90.0 + 6.0 * 40.0)

        contentView.addSubview(offersHistoryTableView)
        offersHistoryTableView.anchor(top: confirmedLiftsTableView.bottomAnchor,
                                      left: contentView.leftAnchor,
                                      right: contentView.rightAnchor,
                                      paddingTop: 75.0,
                                      paddingLeft: 0.0,
                                      paddingRight: 0.0,
                                      height: 90.0 + 6.0 * 40.0)

        contentView.addSubview(acceptedHistoryTableView)
        acceptedHistoryTableView.anchor(top: offersHistoryTableView.bottomAnchor,
                                      left: contentView.leftAnchor,
                                      right: contentView.rightAnchor,
                                      paddingTop: 75.0,
                                      paddingLeft: 0.0,
                                      paddingRight: 0.0,
                                      height: 90.0 + 6.0 * 40.0)


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
}

extension ActiveOffersAndLiftsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var header = UIView()
        
        switch tableView {
        case pendingOffersTableView:
            header = PendingOffersHeader()
            break
        case pendingLiftsTableView:
            header = PendingLiftsHeader()
            break
        case confirmedOffersTableView:
            header = ConfirmedOffersHeader()
            break
        case confirmedLiftsTableView:
            header = ConfirmedLiftsHeader()
            break
        case offersHistoryTableView:
            header = OfferedHistoryHeader()
            break
        case acceptedHistoryTableView:
            header = AcceptedHistoryHeader()
            break
        default:
            break
        }
        
        return header
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch tableView {
        case pendingOffersTableView, pendingLiftsTableView:
            let controller = PendingLiftsOffersVC(offers: pendingOffers, lifts: pendingLifts)
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .crossDissolve
            navigationController?.pushViewController(controller, animated: true)
            break
        case confirmedOffersTableView, confirmedLiftsTableView:
            let controller = ConfirmedLiftsOffersVC(offers: confirmedOffers, lifts: confirmedLifts)
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .crossDissolve
            navigationController?.pushViewController(controller, animated: true)
            break
        case offersHistoryTableView, acceptedHistoryTableView:
            let controller = LiftsOffersHistoryVC(offers: offersHistory, lifts: acceptedHistory)
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .crossDissolve
            navigationController?.pushViewController(controller, animated: true)
            break
        default:
            break
        }
    }
}

extension ActiveOffersAndLiftsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case pendingOffersTableView:
            return pendingOffers.count
        case pendingLiftsTableView:
            return pendingLifts.count
        case confirmedOffersTableView:
            return confirmedOffers.count
        case confirmedLiftsTableView:
            return confirmedLifts.count
        case offersHistoryTableView:
            return offersHistory.count
        case acceptedHistoryTableView:
            return acceptedHistory.count
        default:
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var blankCell = UITableViewCell()
        switch tableView {
        case pendingOffersTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: pendingOffersCellID, for: indexPath) as! ActiveOffersAndLiftsCell
            
            cell.subHeader0Label.text = pendingOffers[indexPath.row]["Start"]
            cell.subHeader1Label.text = pendingOffers[indexPath.row]["End"]
            cell.subHeader2Label.text = pendingOffers[indexPath.row]["Date"]
            cell.subHeader3Label.text = pendingOffers[indexPath.row]["Time"]
            cell.subHeader4Label.text = pendingOffers[indexPath.row]["Detour"]
            blankCell = cell
            break
        case pendingLiftsTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: pendingLiftsCellID, for: indexPath) as! ActiveOffersAndLiftsCell
            
            cell.subHeader0Label.text = pendingLifts[indexPath.row]["Driver"]
            cell.subHeader1Label.text = pendingLifts[indexPath.row]["Reg"]
            cell.subHeader2Label.text = pendingLifts[indexPath.row]["Colour"]
            cell.subHeader3Label.text = pendingLifts[indexPath.row]["Date"]
            cell.subHeader4Label.text = pendingLifts[indexPath.row]["Time"]
            blankCell = cell
            break
        case confirmedOffersTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: confirmedOffersCellID, for: indexPath) as! ActiveOffersAndLiftsCell
            
            cell.subHeader0Label.text = confirmedOffers[indexPath.row]["Start"]
            cell.subHeader1Label.text = confirmedOffers[indexPath.row]["End"]
            cell.subHeader2Label.text = confirmedOffers[indexPath.row]["Date"]
            cell.subHeader3Label.text = confirmedOffers[indexPath.row]["Time"]
            cell.subHeader4Label.text = confirmedOffers[indexPath.row]["Pass"]
            blankCell = cell
            break
        case confirmedLiftsTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: confirmedLiftsCellID, for: indexPath) as! ActiveOffersAndLiftsCell
            
            cell.subHeader0Label.text = confirmedLifts[indexPath.row]["Driver"]
            cell.subHeader1Label.text = confirmedLifts[indexPath.row]["Reg"]
            cell.subHeader2Label.text = confirmedLifts[indexPath.row]["Colour"]
            cell.subHeader3Label.text = confirmedLifts[indexPath.row]["Date"]
            cell.subHeader4Label.text = confirmedLifts[indexPath.row]["Time"]
            blankCell = cell
            break
            
        case offersHistoryTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: offersHistoryCellID, for: indexPath) as! ActiveOffersAndLiftsCell
            
            cell.subHeader0Label.text = offersHistory[indexPath.row]["Start"]
            cell.subHeader1Label.text = offersHistory[indexPath.row]["End"]
            cell.subHeader2Label.text = offersHistory[indexPath.row]["Date"]
            cell.subHeader3Label.text = offersHistory[indexPath.row]["Time"]
            cell.subHeader4Label.text = offersHistory[indexPath.row]["Detour"]
            blankCell = cell
            break
            
        case acceptedHistoryTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: acceptedHistoryCellID, for: indexPath) as! ActiveOffersAndLiftsCell
            
            cell.subHeader0Label.text = acceptedHistory[indexPath.row]["Driver"]
            cell.subHeader1Label.text = acceptedHistory[indexPath.row]["Reg"]
            cell.subHeader2Label.text = acceptedHistory[indexPath.row]["Colour"]
            cell.subHeader3Label.text = acceptedHistory[indexPath.row]["Date"]
            cell.subHeader4Label.text = acceptedHistory[indexPath.row]["Time"]
            blankCell = cell
            break

        default:
            break
        }
        
        return blankCell
    }
    
    
}
