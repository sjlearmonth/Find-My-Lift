//
//  HeaderView.swift
//  Find My Lift
//
//  Created by Stephen Learmonth on 02/10/2020.
//  Copyright © 2020 Stephen Learmonth. All rights reserved.
//

import UIKit

class HeaderView: UIView {
    
    // MARK: - Properties
    
    private lazy var groupHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "Group"
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .systemGreen
        label.font = UIFont(name: "AvenirNext-Bold", size: 20)
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.black.cgColor
        label.setWidth(width: self.frame.width/3)
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
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.black.cgColor
        label.setWidth(width: self.frame.width/3)
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
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.black.cgColor
        label.setWidth(width: self.frame.width/3)
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
        
        let headerStackView = UIStackView(arrangedSubviews: [groupHeaderLabel,
                                                             driverHeaderLabel,
                                                             pickupTimeHeaderLabel])
        headerStackView.axis = .horizontal
        headerStackView.distribution = .fill
        headerStackView.spacing = -1
        
        self.addSubview(headerStackView)
        headerStackView.centerX(inView: self)
        headerStackView.centerY(inView: self)
    }
    
}
