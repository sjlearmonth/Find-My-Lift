//
//  MLR2Cell.swift
//  Find My Lift
//
//  Created by Stephen Learmonth on 26/10/2020.
//  Copyright © 2020 Stephen Learmonth. All rights reserved.
//

import UIKit

class MLR2Cell: UITableViewCell {

    // MARK: - Properties
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.backgroundColor = .white
        label.font = UIFont(name: "AvenirNext-Regular", size: 15)
        label.layer.borderWidth = 0.25
        label.layer.borderColor = UIColor.black.cgColor
        label.setWidth(width: self.frame.width/2)
        return label
    }()

    lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.backgroundColor = .white
        label.font = UIFont(name: "AvenirNext-Regular", size: 15)
        label.layer.borderWidth = 0.25
        label.layer.borderColor = UIColor.black.cgColor
        label.setWidth(width: self.frame.width/2)
        return label
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
        
        let stackView = UIStackView(arrangedSubviews: [nameLabel,
                                                       valueLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fill
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
}
