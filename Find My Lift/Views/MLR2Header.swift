//
//  MLR@Header.swift
//  Find My Lift
//
//  Created by Stephen Learmonth on 26/10/2020.
//  Copyright © 2020 Stephen Learmonth. All rights reserved.
//

import UIKit

class MLR2Header: UIView {
    
    // MARK: - Properties
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Match Details"
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .systemGreen
        label.font = UIFont(name: "AvenirNext-Bold", size: 30)
        label.layer.borderWidth = 0.25
        label.layer.borderColor = UIColor.black.cgColor
        return label
    }()

    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(headerLabel)
        headerLabel.anchor(top: topAnchor,
                           left: leftAnchor,
                           bottom: bottomAnchor,
                           right: rightAnchor,
                           paddingTop: 0.0,
                           paddingLeft: 0.0,
                           paddingBottom: 0.0,
                           paddingRight: 0.0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
