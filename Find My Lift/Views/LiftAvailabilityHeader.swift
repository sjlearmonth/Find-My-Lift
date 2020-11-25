//
//  LiftAvailabilityHeader.swift
//  Find My Lift
//
//  Created by Stephen Learmonth on 02/10/2020.
//  Copyright © 2020 Stephen Learmonth. All rights reserved.
//

import UIKit

class LiftAvailabilityHeader: UIView {
    
    // MARK: - Properties
    
    lazy var groupHeaderLabel: UILabel = {
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

    private lazy var driverHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "Driver"
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .systemGreen
        label.font = UIFont(name: "AvenirNext-Bold", size: 20)
        label.layer.borderWidth = 0.25
        label.layer.borderColor = UIColor.black.cgColor
        label.setWidth(width: self.frame.width/2)
        label.setHeight(height: 60.0)
        return label
    }()

    private lazy var pickupTimeHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "Pickup Time"
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .systemGreen
        label.font = UIFont(name: "AvenirNext-Bold", size: 20)
        label.layer.borderWidth = 0.25
        label.layer.borderColor = UIColor.black.cgColor
        label.setWidth(width: self.frame.width/2)
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
        
        self.addSubview(groupHeaderLabel)
        groupHeaderLabel.anchor(top: self.topAnchor)
        groupHeaderLabel.centerX(inView: self)
        
        let headerStackView = UIStackView(arrangedSubviews: [driverHeaderLabel,
                                                             pickupTimeHeaderLabel])
        headerStackView.axis = .horizontal
        headerStackView.distribution = .fill
        headerStackView.spacing = 0
        
        self.addSubview(headerStackView)
        headerStackView.anchor(top:groupHeaderLabel.bottomAnchor,
                               paddingTop: 0,
                               width: self.frame.width)
        headerStackView.centerX(inView: self)
    }
    
}
