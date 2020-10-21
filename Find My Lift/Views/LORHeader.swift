//
//  LORHeader.swift
//  Find My Lift
//
//  Created by Stephen Learmonth on 21/10/2020.
//  Copyright © 2020 Stephen Learmonth. All rights reserved.
//

import UIKit

// MARK: - Properties

class LORHeaderView: UIView {
    
    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .systemGreen
        label.font = UIFont(name: "AvenirNext-Bold", size: 30)
        label.layer.borderWidth = 0.25
        label.layer.borderColor = UIColor.black.cgColor
        label.setWidth(width: self.frame.width)
        label.setHeight(height: 60.0)
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper Functions
    
    private func configureUI() {
        
        self.addSubview(headerLabel)
        headerLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0)
    }
    
}
