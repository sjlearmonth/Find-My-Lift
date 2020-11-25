//
//  LiftOfferReviewVC.swift
//  Find My Lift
//
//  Created by Stephen Learmonth on 02/10/2020.
//  Copyright © 2020 Stephen Learmonth. All rights reserved.
//

import UIKit

class LiftOfferReviewVC: UIViewController {

    // MARK: - Properties
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        let tableViewHeight = 120.0 + 200.0 + 240.0
        tv.setDimensions(height: CGFloat(tableViewHeight), width: self.view.frame.width - 64.0)
        return tv
    }()
    
    private let driverDetails : [String:String] = ["Name" : "Louise Philips", "Vehicle Registration" : "KN69 PFY", "Vehicle Colour" : "White", "Vehicle Type" : "MPV", "Smoking Permitted" : "No"]
    
    private let liftDetails : [String:String] = ["Cost" : "£1.10", "From Location" : "LU6 1AW", "To Location" : "MK45 4JN", "Time of Pickup" : "2:05pm", "Time until Pickup" : "13 mins", "Journey Time" : "45 mins"]
    
    private let cellID = "LiftOfferReviewCell"
    
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
    
    private lazy var messageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Message Driver", for: .normal)
        button.layer.cornerRadius = 25.0
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.setHeight(height: 50.0)
        button.isEnabled = true
        button.addTarget(self, action: #selector(handleMessageDriver), for: .touchUpInside)
        return button
    }()

    private lazy var sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send Message", for: .normal)
        button.layer.cornerRadius = 25.0
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.setHeight(height: 50.0)
        button.isEnabled = true
        button.addTarget(self, action: #selector(handleSendMessage), for: .touchUpInside)
        return button
    }()

    private lazy var acceptButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Accept Lift", for: .normal)
        button.layer.cornerRadius = 25.0
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.setHeight(height: 50.0)
        button.isEnabled = true
        button.addTarget(self, action: #selector(handleAcceptLift), for: .touchUpInside)
        return button
    }()
    
    private lazy var messageTextView: UITextView = {
        let tv = UITextView()
        tv.setDimensions(height: 200, width: self.contentView.frame.width - 64.0)
        tv.text = "Type your message here."
        tv.font = UIFont(name: LABEL_FONT_REGULAR, size: 18.0)
        tv.textColor = .black
        tv.textAlignment = .left
        tv.backgroundColor = UIColor.white
        tv.layer.borderWidth = 0.25
        tv.layer.borderColor = UIColor.white.cgColor
        tv.layer.cornerRadius = 5.0
        tv.delegate = self
        return tv
    }()

    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        
        configureUI()
        
        configureScrollView()
        
    }
    
    // MARK: - Helper Functions
    
    private func configureUI() {
        
        configureGradientLayer()
        
        title = "Lift Offer Review"
        navigationItem.backButtonTitle = ""

        navigationController?.navigationBar.barTintColor = .systemBlue
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30)]
        navigationController?.navigationBar.barStyle = .black
        
        contentView.addSubview(tableView)
        tableView.anchor(top: contentView.topAnchor,
                         left: contentView.leftAnchor,
                         right: contentView.rightAnchor,
                         paddingTop: 40.0,
                         paddingLeft: 32.0,
                         paddingRight: 32.0)
        
        contentView.addSubview(messageButton)
        messageButton.anchor(top: tableView.bottomAnchor,
                             left: contentView.leftAnchor,
                             right: contentView.rightAnchor,
                             paddingTop: 40.0,
                             paddingLeft: 32,
                             paddingRight: 32)
        
        contentView.addSubview(acceptButton)
        acceptButton.anchor(top: messageButton.bottomAnchor,
                             left: contentView.leftAnchor,
                             right: contentView.rightAnchor,
                             paddingTop: 40.0,
                             paddingLeft: 32,
                             paddingRight: 32)

    }
    
    private func configureTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LiftOfferReviewCell.self, forCellReuseIdentifier: cellID)
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
    
    @objc func handleMessageDriver() {
        print("DEBUG: message driver clicked")
        
        messageButton.removeFromSuperview()
        acceptButton.removeFromSuperview()
        
        contentView.addSubview(messageTextView)
        messageTextView.anchor(top: tableView.bottomAnchor, paddingTop: 40.0)
        messageTextView.centerX(inView: contentView)
        
        contentView.addSubview(sendButton)
        sendButton.anchor(top: messageTextView.bottomAnchor,
                             left: contentView.leftAnchor,
                             right: contentView.rightAnchor,
                             paddingTop: 25.0,
                             paddingLeft: 32.0,
                             paddingRight: 32.0)

        contentView.addSubview(acceptButton)
        acceptButton.anchor(top: sendButton.bottomAnchor,
                             left: contentView.leftAnchor,
                             right: contentView.rightAnchor,
                             paddingTop: 25.0,
                             paddingLeft: 32.0,
                             paddingRight: 32.0)

    }
    
    @objc func handleDoneClicked() {
        print("DEBUG: done clicked")
        messageTextView.endEditing(true)
        navigationItem.rightBarButtonItem = UIBarButtonItem()
    }
    
    @objc func handleAcceptLift() {
        print("DEBUG: accept lift clicked")
        let controller = LiftOfferAcceptedVC()
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func handleSendMessage() {
        print("DEBUG: send message clicked")
        let controller = ChatVC()
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension LiftOfferReviewVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = LiftOfferReviewHeader()
        switch section {
        case 0:
            headerView.headerLabel.text = "Driver Details"
        case 1:
            headerView.headerLabel.text = "Lift Details"
        default:
            headerView.headerLabel.text = ""
        }
        return headerView
    }
}

extension LiftOfferReviewVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return driverDetails.count
        case 1:
            return liftDetails.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! LiftOfferReviewCell
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                cell.infoTitleLabel.text = "Name:"
                cell.infoValueLabel.text = driverDetails["Name"]
            case 1:
                cell.infoTitleLabel.text = "Vehicle Registration:"
                cell.infoValueLabel.text = driverDetails["Vehicle Registration"]
            case 2:
                cell.infoTitleLabel.text = "Vehicle Colour:"
                cell.infoValueLabel.text = driverDetails["Vehicle Colour"]
            case 3:
                cell.infoTitleLabel.text = "Vehicle Type:"
                cell.infoValueLabel.text = driverDetails["Vehicle Type"]
            case 4:
                cell.infoTitleLabel.text = "Smoking Permitted:"
                cell.infoValueLabel.text = driverDetails["Smoking Permitted"]
            default:
                break
            }
        case 1:
            switch indexPath.row {
            case 0:
                cell.infoTitleLabel.text = "Cost:"
                cell.infoValueLabel.text = liftDetails["Cost"]
            case 1:
                cell.infoTitleLabel.text = "From Location:"
                cell.infoValueLabel.text = liftDetails["From Location"]
            case 2:
                cell.infoTitleLabel.text = "To Location:"
                cell.infoValueLabel.text = liftDetails["To Location"]
            case 3:
                cell.infoTitleLabel.text = "Time of Pickup:"
                cell.infoValueLabel.text = liftDetails["Time of Pickup"]
            case 4:
                cell.infoTitleLabel.text = "Time until Pickup:"
                cell.infoValueLabel.text = liftDetails["Time until Pickup"]
            case 5:
                cell.infoTitleLabel.text = "Journey Time:"
                cell.infoValueLabel.text = liftDetails["Journey Time"]
            default:
                break
            }

        default:
            break
        }
        
        return cell
    }
}

extension LiftOfferReviewVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDoneClicked))
        
    }
}
