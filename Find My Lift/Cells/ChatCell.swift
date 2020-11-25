//
//  ChatCell.swift
//  Find My Lift
//
//  Created by Stephen Learmonth on 03/11/2020.
//  Copyright © 2020 Stephen Learmonth. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {

    // MARK: - Properties
    
    let timestampLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    
    let messageTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
        
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper Functions
    
    private func configureUI() {
        
        backgroundColor = .clear
        
        let stackView = UIStackView(arrangedSubviews: [nameLabel,
                                                       messageTextLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        
        addSubview(stackView)
        stackView.centerY(inView: self)
        stackView.anchor(left: leftAnchor,
                         right: rightAnchor,
                         paddingLeft: 12,
                         paddingRight: 16)
        
        addSubview(timestampLabel)
        timestampLabel.anchor(top: topAnchor,
                              right: rightAnchor,
                              paddingTop: 20,
                              paddingRight: 12)
    }
    

}
