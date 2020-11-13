//
//  LiftsOffersHistoryVC.swift
//  Find My Lift
//
//  Created by Stephen Learmonth on 09/11/2020.
//  Copyright © 2020 Stephen Learmonth. All rights reserved.
//

import UIKit

class HistoricalLiftsVC: UIViewController {

    // MARK: - Properties
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private let historicalOffersCellID = "historicalOffersCellID"
    
    private lazy var historicalOffersTableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(ActiveOffersAndAcceptsCell.self, forCellReuseIdentifier: historicalOffersCellID)
        tv.bounces = false
        tv.rowHeight = 40.0
        tv.showsVerticalScrollIndicator = false
        return tv
    }()
    
    private let historicalOffers: [[String:String]]
    
    private let historicalAcceptsCellID = "historicalAcceptsCellID"
    
    private lazy var historicalAcceptsTableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(ActiveOffersAndAcceptsCell.self, forCellReuseIdentifier: historicalAcceptsCellID)
        tv.bounces = false
        tv.rowHeight = 40.0
        tv.showsVerticalScrollIndicator = false
        return tv
    }()
    
    private let historicalAccepts: [[String:String]]
    
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
        self.historicalOffers = offers
        self.historicalAccepts = accepts
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
        
        navigationItem.title = "History"
        navigationItem.backButtonTitle = ""

        navigationController?.navigationBar.barTintColor = .systemBlue
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30)]
        navigationController?.navigationBar.barStyle = .black
        
        contentView.addSubview(historicalOffersTableView)
        historicalOffersTableView.anchor(top: contentView.topAnchor,
                                      left: contentView.leftAnchor,
                                      right: contentView.rightAnchor,
                                      paddingTop: 0.0,
                                      paddingLeft: 0.0,
                                      paddingRight: 0.0,
                                      height: 90.0 + 6.0 * 40.0)
        
        contentView.addSubview(historicalAcceptsTableView)
        historicalAcceptsTableView.anchor(top: historicalOffersTableView.bottomAnchor,
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

extension HistoricalLiftsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var header = UIView()
        
        switch tableView {
        case historicalOffersTableView:
            header = OffersHistoryHeader()
            break
        case historicalAcceptsTableView:
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
        
        var liftData = [String:String]()
        switch tableView {
        case historicalOffersTableView:
            
            liftData["HistoricalType"] = "LiftOffered"
            liftData["TableRow"] = String(indexPath.row)
            liftData["Start"] = historicalOffers[indexPath.row]["Start"]
            liftData["End"] = historicalOffers[indexPath.row]["End"]
            liftData["Date"] = historicalOffers[indexPath.row]["Date"]
            liftData["Time"] = historicalOffers[indexPath.row]["Time"]
            liftData["Detour"] = historicalOffers[indexPath.row]["Detour"]
            break
            
        case historicalAcceptsTableView:
            liftData["HistoricalType"] = "LiftAccepted"
            liftData["TableRow"] = String(indexPath.row)
            liftData["Driver"] = historicalAccepts[indexPath.row]["Driver"]
            liftData["Reg"] = historicalAccepts[indexPath.row]["Reg"]
            liftData["Colour"] = historicalAccepts[indexPath.row]["Colour"]
            liftData["Date"] = historicalAccepts[indexPath.row]["Date"]
            liftData["Time"] = historicalAccepts[indexPath.row]["Time"]
            break
        default:
            break
        }
        
        let controller = HistoricalDetailsVC(data: liftData)
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        navigationController?.pushViewController(controller, animated: true)
    }


}

extension HistoricalLiftsVC: UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case historicalOffersTableView:
            return historicalOffers.count
        case historicalAcceptsTableView:
            return historicalAccepts.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var blankCell = UITableViewCell()
        switch tableView {
        case historicalOffersTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: historicalOffersCellID, for: indexPath) as! ActiveOffersAndAcceptsCell
            
            cell.subHeader0Label.text = historicalOffers[indexPath.row]["Start"]
            cell.subHeader1Label.text = historicalOffers[indexPath.row]["End"]
            cell.subHeader2Label.text = historicalOffers[indexPath.row]["Date"]
            cell.subHeader3Label.text = historicalOffers[indexPath.row]["Time"]
            cell.subHeader4Label.text = historicalOffers[indexPath.row]["Detour"]
            blankCell = cell
            break
        case historicalAcceptsTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: historicalAcceptsCellID, for: indexPath) as! ActiveOffersAndAcceptsCell
            
            cell.subHeader0Label.text = historicalAccepts[indexPath.row]["Driver"]
            cell.subHeader1Label.text = historicalAccepts[indexPath.row]["Reg"]
            cell.subHeader2Label.text = historicalAccepts[indexPath.row]["Colour"]
            cell.subHeader3Label.text = historicalAccepts[indexPath.row]["Date"]
            cell.subHeader4Label.text = historicalAccepts[indexPath.row]["Time"]
            blankCell = cell
            break
        default:
            break
        }
        
        return blankCell
    }


}
