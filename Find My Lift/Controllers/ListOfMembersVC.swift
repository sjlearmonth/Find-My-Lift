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
        tv.register(LOMCell.self, forCellReuseIdentifier: cellID)
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
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
    }
    
    // MARK: - Helper Functions
    
    private func configureUI() {
        
        configureGradientLayer()
        
        title = "List of Members"

        navigationController?.navigationBar.barTintColor = .systemBlue
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30)]
        navigationController?.navigationBar.barStyle = .black
        
        view.addSubview(tableView)
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         left: view.leftAnchor,
                         right: view.rightAnchor,
                         paddingTop: 40.0,
                         paddingLeft: 32.0,
                         paddingRight: 32.0,
                         height: 60.0 + 40.0 * CGFloat(maxNumberOfRows))
        
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
        let header = LOMHeader(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 60.0))
        print("DEBUG: table width = \(self.tableView.frame.width)")
        return header
    }
}

extension ListOfMembersVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfMembers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! LOMCell
        cell.nameLabel.text = listOfMembers[indexPath.row]["Name"] as? String
        cell.ratingImageView.image = (listOfMembers[indexPath.row]["Rating"] as? UIImage)
        cell.footprintLabel.text = String((listOfMembers[indexPath.row]["Footprint"] as? Int)!) /**?.withAlignmentRectInsets(UIEdgeInsets(top: -5, left: -10, bottom: -5, right: -10))*/
        cell.feedbackLabel.text = listOfMembers[indexPath.row]["Feedback"] as? String
        print("DEBUG: cell width in cellForRowAt = \(cell.frame.width)")
        
        return cell
    }
    

}
