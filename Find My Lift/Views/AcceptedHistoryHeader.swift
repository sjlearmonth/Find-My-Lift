//
//  LiftsAcceptedHistoryHeader.swift
//  Find My Lift
//
//  Created by Stephen Learmonth on 06/11/2020.
//  Copyright © 2020 Stephen Learmonth. All rights reserved.
//

import UIKit

class AcceptedHistoryHeader: UIView {
    
    // MARK: - Properties
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Lifts Accepted History"
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .systemGreen
        label.font = UIFont(name: "AvenirNext-Bold", size: 25.0)
        label.layer.borderWidth = 0.25
        label.layer.borderColor = UIColor.black.cgColor
        return label
    }()
    
    private lazy var driverLabel: UILabel = {
        let label = UILabel()
        label.text = "Driver"
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .systemGreen
        label.font = UIFont(name: "AvenirNext-Bold", size: 18.0)
        label.layer.borderWidth = 0.25
        label.layer.borderColor = UIColor.black.cgColor
        return label
    }()
    
    private lazy var regLabel: UILabel = {
        let label = UILabel()
        label.text = "Reg"
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .systemGreen
        label.font = UIFont(name: "AvenirNext-Bold", size: 18.0)
        label.layer.borderWidth = 0.25
        label.layer.borderColor = UIColor.black.cgColor
        return label
    }()
    
    private lazy var colourLabel: UILabel = {
        let label = UILabel()
        label.text = "Colour"
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .systemGreen
        label.font = UIFont(name: "AvenirNext-Bold", size: 18.0)
        label.layer.borderWidth = 0.25
        label.layer.borderColor = UIColor.black.cgColor
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Date"
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .systemGreen
        label.font = UIFont(name: "AvenirNext-Bold", size: 18.0)
        label.layer.borderWidth = 0.25
        label.layer.borderColor = UIColor.black.cgColor
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "Time"
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .systemGreen
        label.font = UIFont(name: "AvenirNext-Bold", size: 18.0)
        label.layer.borderWidth = 0.25
        label.layer.borderColor = UIColor.black.cgColor
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(titleLabel)
        titleLabel.anchor(top: self.topAnchor, left: leftAnchor, right: rightAnchor, height: 50.0)
        let stackView = UIStackView(arrangedSubviews: [driverLabel,
                                                       regLabel,
                                                       colourLabel,
                                                       dateLabel,
                                                       timeLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 0
        
        self.addSubview(stackView)
        stackView.anchor(top: titleLabel.bottomAnchor,
                         left: leftAnchor,
                         bottom: bottomAnchor,
                         right: rightAnchor,
                         paddingTop: 0.0,
                         paddingLeft: 0.0,
                         paddingBottom: 0.0,
                         paddingRight: 0.0, height:40.0)
        
        driverLabel.setWidthProportionalToSuperview(by: 4.0 / 20.0)
        regLabel.setWidthProportionalToSuperview(by: 4.0 / 20.0)
        colourLabel.setWidthProportionalToSuperview(by: 4.0 / 20.0)
        dateLabel.setWidthProportionalToSuperview(by: 4.0 / 20.0)
        timeLabel.setWidthProportionalToSuperview(by: 4.0 / 20.0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}




