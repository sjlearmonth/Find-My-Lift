//
//  ListOfMembersVC.swift
//  Find My Lift
//
//  Created by Stephen Learmonth on 28/10/2020.
//  Copyright © 2020 Stephen Learmonth. All rights reserved.
//

import UIKit

class ListOfMembersVC: UIViewController {

    // MARK: - Properties
    
    private let cellID = "ListOfMembersCellID"
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.rowHeight = 40.0
        tv.register(ListOfMembersCell.self, forCellReuseIdentifier: cellID)
        tv.delegate = self
        tv.dataSource = self
        tv.bounces = false
        tv.showsVerticalScrollIndicator = false
        return tv
    }()
    
    private let maxNumberOfRows = 6
    
    private let listOfMembers: [[String : Any]] = [["Name":"Louise",
                                                    "Rating":UIImage(imageLiteralResourceName: "Rating Stars 2 out of 5"), "Footprint": 2, "Feedback": "??"],
                                                   ["Name":"Chris", "Rating":UIImage(imageLiteralResourceName: "Rating Stars 4 out of 5"), "Footprint": 5, "Feedback": "??"],
                                                   ["Name":"Sally", "Rating":UIImage(imageLiteralResourceName: "Rating Stars 3 out of 5"), "Footprint": 3, "Feedback": "??"],
                                                   ["Name":"Sharon", "Rating":UIImage(imageLiteralResourceName: "Rating Stars 4 out of 5"), "Footprint": 4, "Feedback": "??"],
                                                   ["Name":"Mark", "Rating":UIImage(imageLiteralResourceName: "Rating Stars 2 out of 5"), "Footprint": 1, "Feedback": "??"],
                                                   ["Name":"Martin", "Rating":UIImage(imageLiteralResourceName: "Rating Stars 3 out of 5"), "Footprint": 2, "Feedback": "??"],
                                                   ["Name":"Christine", "Rating":UIImage(imageLiteralResourceName: "Rating Stars 4 out of 5"), "Footprint": 5, "Feedback": "??"],
                                                   ["Name":"Anne", "Rating":UIImage(imageLiteralResourceName: "Rating Stars 3 out of 5"), "Footprint": 3, "Feedback": "??"]
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
        
        configureGradientLayer()
        
        title = "List of Members"

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
                         paddingRight: 32.0,
                         height: 60.0 + 40.0 * CGFloat(maxNumberOfRows))
        
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

extension ListOfMembersVC: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ListOfMembersHeader(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 60.0))
        print("DEBUG: table width = \(self.tableView.frame.width)")
        return header
    }
}

extension ListOfMembersVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfMembers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! ListOfMembersCell
        cell.nameLabel.text = listOfMembers[indexPath.row]["Name"] as? String
        cell.ratingImageView.image = (listOfMembers[indexPath.row]["Rating"] as? UIImage)
        cell.footprintLabel.text = String((listOfMembers[indexPath.row]["Footprint"] as? Int)!) /**?.withAlignmentRectInsets(UIEdgeInsets(top: -5, left: -10, bottom: -5, right: -10))*/
        cell.feedbackLabel.text = listOfMembers[indexPath.row]["Feedback"] as? String
        print("DEBUG: cell width in cellForRowAt = \(cell.frame.width)")
        
        return cell
    }
    

}
