//
//  LiftAvailabilityCell.swift
//  Find My Lift
//
//  Created by Stephen Learmonth on 02/10/2020.
//  Copyright © 2020 Stephen Learmonth. All rights reserved.
//

import UIKit

class LACell: UITableViewCell {
    
    // MARK: - Properties
    
    lazy var driverLabel: UILabel = {
        let label = UILabel()
        label.text = "Driver"
        label.textColor = .black
        label.textAlignment = .center
        label.backgroundColor = .white
        label.font = UIFont(name: "AvenirNext-Regular", size: 18)
        label.layer.borderWidth = 0.5
        label.layer.borderColor = UIColor.black.cgColor
        return label
    }()

    lazy var pickupTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "Pickup Time"
        label.textColor = .black
        label.textAlignment = .center
        label.backgroundColor = .white
        label.font = UIFont(name: "AvenirNext-Regular", size: 18)
        label.layer.borderWidth = 0.5
        label.layer.borderColor = UIColor.black.cgColor
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
        
        let stackView = UIStackView(arrangedSubviews: [driverLabel,
                                                       pickupTimeLabel])
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

    
}
