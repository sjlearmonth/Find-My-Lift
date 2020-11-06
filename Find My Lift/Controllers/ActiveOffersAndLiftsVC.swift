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
        
        configureScrollView()
 
    }
    
    // MARK: - Helper Functions
    
    private func configureUI() {
        
        title = "Active Offers & Lifts"

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
                                      paddingTop: 0.0,
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

        
        
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        var header = UIView()
//        switch section {
//        case 0:
//            header = PendingOffersHeader()
//        case 1:
//            header = PendingLiftsHeader()
//        case 2:
//            header = ConfirmedOffersHeader()
//        case 3:
//            header = ConfirmedLiftsHeader()
//        case 4:
//            header = LiftsOfferedHistoryHeader()
//        case 5:
//            header = LiftsAcceptedHistoryHeader()
//        default:
//            break
//        }
//        return header
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! ActiveOffersAndLiftsCell
//
//        switch indexPath.section {
//        case 0:
//                cell.subHeader0Label.text = pendingOffers[indexPath.row]["Start"]
//                cell.subHeader1Label.text = pendingOffers[indexPath.row]["End"]
//                cell.subHeader2Label.text = pendingOffers[indexPath.row]["Date"]
//                cell.subHeader3Label.text = pendingOffers[indexPath.row]["Time"]
//                cell.subHeader4Label.text = pendingOffers[indexPath.row]["Detour"]
//            break
//        case 1:
//            break
//        case 2:
//            break
//        case 3:
//            break
//        case 4:
//            break
//        case 5:
//            break
//        default:
//            break
//        }
//        return cell
//    }
//
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 40.0
//    }
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
}

extension ActiveOffersAndLiftsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case pendingOffersTableView:
            return pendingOffers.count
        case pendingLiftsTableView:
            return pendingLifts.count
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

        default:
            break
        }
        
        return blankCell
    }
    
    
}
