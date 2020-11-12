//
//  ActiveOffersAnfLiftsVC.swift
//  Find My Lift
//
//  Created by Stephen Learmonth on 29/09/2020.
//  Copyright © 2020 Stephen Learmonth. All rights reserved.
//

import UIKit

class ActiveOffersAndAcceptsVC: UIViewController {

    // MARK: - Properties
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private let pendingOffersCellID = "PendingOffersCellID"
    
    private lazy var pendingOffersTableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(ActiveOffersAndAcceptsCell.self, forCellReuseIdentifier: pendingOffersCellID)
        tv.bounces = false
        tv.rowHeight = 40.0
        tv.showsVerticalScrollIndicator = false
        return tv
    }()
    
    private var pendingOffers: [[String:String]] = [
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
    
    private let pendingAcceptsCellID = "PendingAcceptsCellID"
    
    private lazy var pendingAcceptsTableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(ActiveOffersAndAcceptsCell.self, forCellReuseIdentifier: pendingAcceptsCellID)
        tv.bounces = false
        tv.rowHeight = 40.0
        tv.showsVerticalScrollIndicator = false
        return tv
    }()
    
    private var pendingAccepts: [[String:String]] = [
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
        tv.register(ActiveOffersAndAcceptsCell.self, forCellReuseIdentifier: confirmedOffersCellID)
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

    private let confirmedAcceptsCellID = "ConfirmedAcceptsCellID"
    
    private lazy var confirmedAcceptsTableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(ActiveOffersAndAcceptsCell.self, forCellReuseIdentifier: confirmedAcceptsCellID)
        tv.bounces = false
        tv.rowHeight = 40.0
        tv.showsVerticalScrollIndicator = false
        return tv
    }()
    
    private let confirmedAccepts: [[String:String]] = [
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
        tv.register(ActiveOffersAndAcceptsCell.self, forCellReuseIdentifier: offersHistoryCellID)
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

    private let acceptsHistoryCellID = "AcceptsHistoryCellID"
    
    private lazy var acceptsHistoryTableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(ActiveOffersAndAcceptsCell.self, forCellReuseIdentifier: acceptsHistoryCellID)
        tv.bounces = false
        tv.rowHeight = 40.0
        tv.showsVerticalScrollIndicator = false
        return tv
    }()
    
    private let acceptsHistory: [[String:String]] = [
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
 
    let pendingLiftsEdited = Notification.Name(rawValue: pendingLiftsEditedNotificationKey)

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        configureScrollView()
        
        createObserver()
 
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    
    // MARK: - Helper Functions
    
    private func configureUI() {
        
        configureGradientLayer()
        
        navigationItem.title = "Offers and Accepts"
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
        
        contentView.addSubview(pendingAcceptsTableView)
        pendingAcceptsTableView.anchor(top: pendingOffersTableView.bottomAnchor,
                                      left: contentView.leftAnchor,
                                      right: contentView.rightAnchor,
                                      paddingTop: 75.0,
                                      paddingLeft: 0.0,
                                      paddingRight: 0.0,
                                      height: 90.0 + 6.0 * 40.0)

        contentView.addSubview(confirmedOffersTableView)
        confirmedOffersTableView.anchor(top: pendingAcceptsTableView.bottomAnchor,
                                      left: contentView.leftAnchor,
                                      right: contentView.rightAnchor,
                                      paddingTop: 75.0,
                                      paddingLeft: 0.0,
                                      paddingRight: 0.0,
                                      height: 90.0 + 6.0 * 40.0)

        contentView.addSubview(confirmedAcceptsTableView)
        confirmedAcceptsTableView.anchor(top: confirmedOffersTableView.bottomAnchor,
                                      left: contentView.leftAnchor,
                                      right: contentView.rightAnchor,
                                      paddingTop: 75.0,
                                      paddingLeft: 0.0,
                                      paddingRight: 0.0,
                                      height: 90.0 + 6.0 * 40.0)

        contentView.addSubview(offersHistoryTableView)
        offersHistoryTableView.anchor(top: confirmedAcceptsTableView.bottomAnchor,
                                      left: contentView.leftAnchor,
                                      right: contentView.rightAnchor,
                                      paddingTop: 75.0,
                                      paddingLeft: 0.0,
                                      paddingRight: 0.0,
                                      height: 90.0 + 6.0 * 40.0)

        contentView.addSubview(acceptsHistoryTableView)
        acceptsHistoryTableView.anchor(top: offersHistoryTableView.bottomAnchor,
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
    
    private func createObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(ActiveOffersAndAcceptsVC.updatePendingTableView), name: pendingLiftsEdited, object: nil)
    }
    
    // MARK: - Selectors
    
    @objc func updatePendingTableView(notification: NSNotification) {
        let data = notification.userInfo as! [String:String]
        guard let tableRow = Int(data["TableRow"] ?? "0") else { return }
        print("DEBUG: data = \(data)")
        if data["PendingType"] == "LiftOffered" {
            
            pendingOffers.remove(at: tableRow)
            pendingOffers.insert(data, at: tableRow)
            pendingOffersTableView.reloadData()
        } else {
            pendingAccepts.remove(at: tableRow)
            pendingAccepts.insert(data, at: tableRow)
            pendingAcceptsTableView.reloadData()

        }
            
    }

}

extension ActiveOffersAndAcceptsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var header = UIView()
        
        switch tableView {
        case pendingOffersTableView:
            header = PendingOffersHeader()
            break
        case pendingAcceptsTableView:
            header = PendingAcceptsHeader()
            break
        case confirmedOffersTableView:
            header = ConfirmedOffersHeader()
            break
        case confirmedAcceptsTableView:
            header = ConfirmedAcceptsHeader()
            break
        case offersHistoryTableView:
            header = OffersHistoryHeader()
            break
        case acceptsHistoryTableView:
            header = AcceptsHistoryHeader()
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
        case pendingOffersTableView, pendingAcceptsTableView:
            let controller = PendingLiftsVC(offers: pendingOffers, accepts: pendingAccepts)
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .crossDissolve
            navigationController?.pushViewController(controller, animated: true)
            break
        case confirmedOffersTableView, confirmedAcceptsTableView:
            let controller = ConfirmedLiftsVC(offers: confirmedOffers, accepts: confirmedAccepts)
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .crossDissolve
            navigationController?.pushViewController(controller, animated: true)
            break
        case offersHistoryTableView, acceptsHistoryTableView:
            let controller = LiftsHistoryVC(offers: offersHistory, accepts: acceptsHistory)
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .crossDissolve
            navigationController?.pushViewController(controller, animated: true)
            break
        default:
            break
        }
    }
}

extension ActiveOffersAndAcceptsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case pendingOffersTableView:
            return pendingOffers.count
        case pendingAcceptsTableView:
            return pendingAccepts.count
        case confirmedOffersTableView:
            return confirmedOffers.count
        case confirmedAcceptsTableView:
            return confirmedAccepts.count
        case offersHistoryTableView:
            return offersHistory.count
        case acceptsHistoryTableView:
            return acceptsHistory.count
        default:
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var blankCell = UITableViewCell()
        switch tableView {
        case pendingOffersTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: pendingOffersCellID, for: indexPath) as! ActiveOffersAndAcceptsCell
            
            cell.subHeader0Label.text = pendingOffers[indexPath.row]["Start"]
            cell.subHeader1Label.text = pendingOffers[indexPath.row]["End"]
            cell.subHeader2Label.text = pendingOffers[indexPath.row]["Date"]
            cell.subHeader3Label.text = pendingOffers[indexPath.row]["Time"]
            cell.subHeader4Label.text = pendingOffers[indexPath.row]["Detour"]
            blankCell = cell
            break
        case pendingAcceptsTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: pendingAcceptsCellID, for: indexPath) as! ActiveOffersAndAcceptsCell
            
            cell.subHeader0Label.text = pendingAccepts[indexPath.row]["Driver"]
            cell.subHeader1Label.text = pendingAccepts[indexPath.row]["Reg"]
            cell.subHeader2Label.text = pendingAccepts[indexPath.row]["Colour"]
            cell.subHeader3Label.text = pendingAccepts[indexPath.row]["Date"]
            cell.subHeader4Label.text = pendingAccepts[indexPath.row]["Time"]
            blankCell = cell
            break
        case confirmedOffersTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: confirmedOffersCellID, for: indexPath) as! ActiveOffersAndAcceptsCell
            
            cell.subHeader0Label.text = confirmedOffers[indexPath.row]["Start"]
            cell.subHeader1Label.text = confirmedOffers[indexPath.row]["End"]
            cell.subHeader2Label.text = confirmedOffers[indexPath.row]["Date"]
            cell.subHeader3Label.text = confirmedOffers[indexPath.row]["Time"]
            cell.subHeader4Label.text = confirmedOffers[indexPath.row]["Pass"]
            blankCell = cell
            break
        case confirmedAcceptsTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: confirmedAcceptsCellID, for: indexPath) as! ActiveOffersAndAcceptsCell
            
            cell.subHeader0Label.text = confirmedAccepts[indexPath.row]["Driver"]
            cell.subHeader1Label.text = confirmedAccepts[indexPath.row]["Reg"]
            cell.subHeader2Label.text = confirmedAccepts[indexPath.row]["Colour"]
            cell.subHeader3Label.text = confirmedAccepts[indexPath.row]["Date"]
            cell.subHeader4Label.text = confirmedAccepts[indexPath.row]["Time"]
            blankCell = cell
            break
            
        case offersHistoryTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: offersHistoryCellID, for: indexPath) as! ActiveOffersAndAcceptsCell
            
            cell.subHeader0Label.text = offersHistory[indexPath.row]["Start"]
            cell.subHeader1Label.text = offersHistory[indexPath.row]["End"]
            cell.subHeader2Label.text = offersHistory[indexPath.row]["Date"]
            cell.subHeader3Label.text = offersHistory[indexPath.row]["Time"]
            cell.subHeader4Label.text = offersHistory[indexPath.row]["Detour"]
            blankCell = cell
            break
            
        case acceptsHistoryTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: acceptsHistoryCellID, for: indexPath) as! ActiveOffersAndAcceptsCell
            
            cell.subHeader0Label.text = acceptsHistory[indexPath.row]["Driver"]
            cell.subHeader1Label.text = acceptsHistory[indexPath.row]["Reg"]
            cell.subHeader2Label.text = acceptsHistory[indexPath.row]["Colour"]
            cell.subHeader3Label.text = acceptsHistory[indexPath.row]["Date"]
            cell.subHeader4Label.text = acceptsHistory[indexPath.row]["Time"]
            blankCell = cell
            break

        default:
            break
        }
        
        return blankCell
    }
    
    
}
