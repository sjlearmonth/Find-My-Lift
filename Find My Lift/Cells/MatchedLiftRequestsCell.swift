//
//  MatchedLiftRequestsCell.swift
//  Find My Lift
//
//  Created by Stephen Learmonth on 23/10/2020.
//  Copyright © 2020 Stephen Learmonth. All rights reserved.
//

import UIKit

class MatchedLiftRequestsCell: UITableViewCell {

    // MARK: - Properties
    
    lazy var groupLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.backgroundColor = .white
        label.font = UIFont(name: LABEL_FONT_REGULAR, size: 15)
        label.layer.borderWidth = 0.25
        label.layer.borderColor = UIColor.black.cgColor
        label.setWidth(width: self.frame.width/4)
        return label
    }()

    lazy var passengerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.backgroundColor = .white
        label.font = UIFont(name: LABEL_FONT_REGULAR, size: 15)
        label.layer.borderWidth = 0.25
        label.layer.borderColor = UIColor.black.cgColor
        label.setWidth(width: self.frame.width/4)
        return label
    }()

    lazy var pickupTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.backgroundColor = .white
        label.font = UIFont(name: LABEL_FONT_REGULAR, size: 15)
        label.layer.borderWidth = 0.25
        label.layer.borderColor = UIColor.black.cgColor
        label.setWidth(width: self.frame.width/4)
        return label
    }()
    
    private lazy var notesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(handleNotesClicked), for: .touchUpInside)
        button.layer.borderWidth = 0.25
        button.layer.borderColor = UIColor.black.cgColor
        button.tintColor = .black
        button.setWidth(width: self.frame.width/4)
        return button
    }()


    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle , reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper Functions
    
    private func configureUI() {
        
        let stackView = UIStackView(arrangedSubviews: [groupLabel,
                                                       passengerLabel,
                                                       pickupTimeLabel,
                                                       notesButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        
        self.addSubview(stackView)
        stackView.anchor(top: self.topAnchor,
                         left: self.leftAnchor,
                         bottom: self.bottomAnchor,
                         right: self.rightAnchor,
                         paddingTop: 0,
                         paddingLeft: 0,
                         paddingBottom: 0,
                         paddingRight: 0)
    }

    // MARK: - Selectors
    
    @objc func handleNotesClicked() {
        print("DEBUG: notes clicked")
    }
}
