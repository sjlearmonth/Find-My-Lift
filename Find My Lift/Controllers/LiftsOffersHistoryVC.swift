//
//  LiftsOffersHistoryVC.swift
//  Find My Lift
//
//  Created by Stephen Learmonth on 09/11/2020.
//  Copyright © 2020 Stephen Learmonth. All rights reserved.
//

import UIKit

class LiftsOffersHistoryVC: UIViewController {

    // MARK: - Properties
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private let offersHistoryCellID = "OffersHistoryCellID"
    
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
    
    private let offersHistory: [[String:String]]
    
    private let liftsHistoryCellID = "LiftsHistoryCellID"
    
    private lazy var liftsHistoryTableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(ActiveOffersAndLiftsCell.self, forCellReuseIdentifier: liftsHistoryCellID)
        tv.bounces = false
        tv.rowHeight = 40.0
        tv.showsVerticalScrollIndicator = false
        return tv
    }()
    
    private let liftsHistory: [[String:String]]
    
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
    
    init(offers: [[String:String]], lifts: [[String:String]]) {
        self.offersHistory = offers
        self.liftsHistory = lifts
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
        
        contentView.addSubview(offersHistoryTableView)
        offersHistoryTableView.anchor(top: contentView.topAnchor,
                                      left: contentView.leftAnchor,
                                      right: contentView.rightAnchor,
                                      paddingTop: 0.0,
                                      paddingLeft: 0.0,
                                      paddingRight: 0.0,
                                      height: 90.0 + 6.0 * 40.0)
        
        contentView.addSubview(liftsHistoryTableView)
        liftsHistoryTableView.anchor(top: offersHistoryTableView.bottomAnchor,
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

extension LiftsOffersHistoryVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var header = UIView()
        
        switch tableView {
        case offersHistoryTableView:
            header = OfferedHistoryHeader()
            break
        case liftsHistoryTableView:
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

}

extension LiftsOffersHistoryVC: UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case offersHistoryTableView:
            return offersHistory.count
        case liftsHistoryTableView:
            return liftsHistory.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var blankCell = UITableViewCell()
        switch tableView {
        case offersHistoryTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: offersHistoryCellID, for: indexPath) as! ActiveOffersAndLiftsCell
            
            cell.subHeader0Label.text = offersHistory[indexPath.row]["Start"]
            cell.subHeader1Label.text = offersHistory[indexPath.row]["End"]
            cell.subHeader2Label.text = offersHistory[indexPath.row]["Date"]
            cell.subHeader3Label.text = offersHistory[indexPath.row]["Time"]
            cell.subHeader4Label.text = offersHistory[indexPath.row]["Detour"]
            blankCell = cell
            break
        case liftsHistoryTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: liftsHistoryCellID, for: indexPath) as! ActiveOffersAndLiftsCell
            
            cell.subHeader0Label.text = liftsHistory[indexPath.row]["Driver"]
            cell.subHeader1Label.text = liftsHistory[indexPath.row]["Reg"]
            cell.subHeader2Label.text = liftsHistory[indexPath.row]["Colour"]
            cell.subHeader3Label.text = liftsHistory[indexPath.row]["Date"]
            cell.subHeader4Label.text = liftsHistory[indexPath.row]["Time"]
            blankCell = cell
            break
        default:
            break
        }
        
        return blankCell
    }


}
