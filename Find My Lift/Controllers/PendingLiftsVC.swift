//
//  PendingLiftsOffersVC.swift
//  Find My Lift
//
//  Created by Stephen Learmonth on 09/11/2020.
//  Copyright © 2020 Stephen Learmonth. All rights reserved.
//

import UIKit

class PendingLiftsVC: UIViewController {

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
    
    private var pendingOffers: [[String:String]]
    
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
    
    private var pendingAccepts: [[String:String]]
    
    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.isScrollEnabled = true
        sv.bounces = false
        sv.showsVerticalScrollIndicator = false
        return sv
    }()
    
    private lazy var contentView: UIView = {
        let cv = UIView()
        cv.frame.size = CGSize(width: self.view.frame.width, height: self.view.frame.height * 1.5)
        return cv
    }()
    
    // MARK: - Lifecycle
    
    init(offers: [[String:String]], accepts: [[String:String]]) {
        self.pendingOffers = offers
        self.pendingAccepts = accepts
        super.init(nibName: nil, bundle: nil)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        configureScrollView()

    }
    
    // MARK: - Helper Functions
    
    private func configureUI() {
        
        configureGradientLayer()
        
        navigationItem.title = "Pending"
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

extension PendingLiftsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var header = UIView()
        
        switch tableView {
        case pendingOffersTableView:
            header = PendingOffersHeader()
            break
        case pendingAcceptsTableView:
            header = PendingAcceptsHeader()
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
        case pendingOffersTableView:
            var offeredLiftData = [String:String]()
            offeredLiftData["PendingType"] = "LiftOffered"
            offeredLiftData["TableRow"] = String(indexPath.row)
            offeredLiftData["Start"] = pendingOffers[indexPath.row]["Start"]
            offeredLiftData["End"] = pendingOffers[indexPath.row]["End"]
            offeredLiftData["Date"] = pendingOffers[indexPath.row]["Date"]
            offeredLiftData["Time"] = pendingOffers[indexPath.row]["Time"]
            offeredLiftData["Detour"] = pendingOffers[indexPath.row]["Detour"]
            let controller = PendingDetailsVC(data: offeredLiftData)
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .crossDissolve
            navigationController?.pushViewController(controller, animated: true)
            break
        case pendingAcceptsTableView:
            var acceptedLiftData = [String:String]()
            acceptedLiftData["PendingType"] = "LiftAccepted"
            acceptedLiftData["TableRow"] = String(indexPath.row)
            acceptedLiftData["TableRow"] = String(indexPath.row)
            acceptedLiftData["Driver"] = pendingAccepts[indexPath.row]["Driver"]
            acceptedLiftData["Reg"] = pendingAccepts[indexPath.row]["Reg"]
            acceptedLiftData["Colour"] = pendingAccepts[indexPath.row]["Colour"]
            acceptedLiftData["Date"] = pendingAccepts[indexPath.row]["Date"]
            acceptedLiftData["Time"] = pendingAccepts[indexPath.row]["Time"]
            let controller = PendingDetailsVC(data: acceptedLiftData)
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .crossDissolve
            navigationController?.pushViewController(controller, animated: true)
            break
        default:
            break
        }
    
    }

}

extension PendingLiftsVC: UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case pendingOffersTableView:
            return pendingOffers.count
        case pendingAcceptsTableView:
            return pendingAccepts.count
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
        default:
            break
        }
        
        return blankCell
    }
    
}
