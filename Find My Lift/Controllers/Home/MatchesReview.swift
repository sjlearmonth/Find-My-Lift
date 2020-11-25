//
//  MatchedLiftReview.swift
//  Find My Lift
//
//  Created by Stephen Learmonth on 26/10/2020.
//  Copyright © 2020 Stephen Learmonth. All rights reserved.
//

import UIKit

class MatchesReview: UIViewController {

    // MARK: - Properties
    
    var selectedGroup = ""
    var selectedPassenger = ""
    var selectedPickupTime = ""
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.rowHeight = 40.0
        tv.delegate = self
        tv.dataSource = self
        tv.register(MatchesReviewCell.self, forCellReuseIdentifier: cellID)
        return tv
    }()

    private let cellID = "MatchesReviewCellID"
    
    private let messagePassengerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Message Passenger", for: .normal)
        button.layer.cornerRadius = 25.0
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.setHeight(height: 50.0)
        button.addTarget(self, action: #selector(handleMessagePassenger), for: .touchUpInside)
        return button
    }()
 
    private let offerLiftButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Offer Lift", for: .normal)
        button.layer.cornerRadius = 25.0
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.setHeight(height: 50.0)
        button.addTarget(self, action: #selector(handleOfferLift), for: .touchUpInside)
        return button
    }()
    
    private lazy var messageTextView: UITextView = {
        let tv = UITextView()
        tv.setDimensions(height: 200, width: self.view.frame.width - 64.0)
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
    
    private let sendMessageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send Message", for: .normal)
        button.layer.cornerRadius = 25.0
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.setHeight(height: 50.0)
        button.addTarget(self, action: #selector(handleSendMessage), for: .touchUpInside)
        return button
    }()

 
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
        
        configureGradientLayer()
        
        title = "Matches Review"
        navigationItem.backButtonTitle = ""

        navigationController?.navigationBar.barTintColor = .systemBlue
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30)]
        navigationController?.navigationBar.barStyle = .black
        
        contentView.addSubview(tableView)
        tableView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 40.0, paddingLeft: 32.0, paddingRight: 32.0, height: 180.0)
        
        contentView.addSubview(messagePassengerButton)
        messagePassengerButton.anchor(top: tableView.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 25.0, paddingLeft: 32.0, paddingRight: 32.0)

        contentView.addSubview(offerLiftButton)
        offerLiftButton.anchor(top: messagePassengerButton.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 25.0, paddingLeft: 32.0, paddingRight: 32.0)

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
    
    @objc func handleMessagePassenger() {
        print("DEBUG: message passenger clicked")
        
        messagePassengerButton.removeFromSuperview()
        offerLiftButton.removeFromSuperview()
        
        contentView.addSubview(messageTextView)
        messageTextView.anchor(top: tableView.bottomAnchor, paddingTop: 25.0)
        messageTextView.centerX(inView: contentView)
        
        contentView.addSubview(sendMessageButton)
        sendMessageButton.anchor(top: messageTextView.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 25.0, paddingLeft: 32.0, paddingRight: 32.0)
        sendMessageButton.centerX(inView: contentView)
        
        contentView.addSubview(offerLiftButton)
        offerLiftButton.anchor(top: sendMessageButton.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 25.0, paddingLeft: 32.0, paddingRight: 32.0)
        offerLiftButton.centerX(inView: contentView)
        
//        let controller = ChatVC()
//        controller.modalPresentationStyle = .fullScreen
//        controller.modalTransitionStyle = .crossDissolve
//        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func handleOfferLift() {
        print("DEBUG: offer lift clicked")
        let controller = LiftOfferSentVC()
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
    
    @objc func handleDoneClicked() {
        print("DEBUG: done clicked")
        messageTextView.endEditing(true)
        navigationItem.rightBarButtonItem = UIBarButtonItem()
    }

}

extension MatchesReview : UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = MatchesReviewHeader(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 60.0))
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60.0
    }
}

extension MatchesReview : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! MatchesReviewCell
        
        switch indexPath.row {
        case 0:
            cell.nameLabel.text = "Group:"
            cell.valueLabel.text = selectedGroup
        case 1:
            cell.nameLabel.text = "Name:"
            cell.valueLabel.text = selectedPassenger
        case 2:
            cell.nameLabel.text = "Pickup Time:"
            cell.valueLabel.text = selectedPickupTime
        default:
            break
        }
        return cell
    }
}

extension MatchesReview: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDoneClicked))
    }
}
