//
//  MLRHeader.swift
//  Find My Lift
//
//  Created by Stephen Learmonth on 23/10/2020.
//  Copyright © 2020 Stephen Learmonth. All rights reserved.
//

import UIKit

class MLRHeader: UIView {
    
    // MARK: - Properties
    
    lazy var groupHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "Group"
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .systemGreen
        label.font = UIFont(name: "AvenirNext-Bold", size: 18)
        label.layer.borderWidth = 0.25
        label.layer.borderColor = UIColor.black.cgColor
        label.setWidth(width: self.frame.width/4)
        label.setHeight(height: 60.0)
        return label
    }()

    private lazy var passengerHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "Passenger"
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .systemGreen
        label.font = UIFont(name: "AvenirNext-Bold", size: 18)
        label.layer.borderWidth = 0.25
        label.layer.borderColor = UIColor.black.cgColor
        label.setWidth(width: self.frame.width/4)
        label.setHeight(height: 60.0)
        return label
    }()

    private lazy var pickupTimeHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "Pickup Time"
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .systemGreen
        label.font = UIFont(name: "AvenirNext-Bold", size: 18)
        label.layer.borderWidth = 0.25
        label.layer.borderColor = UIColor.black.cgColor
        label.setWidth(width: self.frame.width/4)
        label.setHeight(height: 60.0)
        label.numberOfLines = 0
        return label
    }()

    private lazy var notesHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "Notes"
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .systemGreen
        label.font = UIFont(name: "AvenirNext-Bold", size: 18)
        label.layer.borderWidth = 0.25
        label.layer.borderColor = UIColor.black.cgColor
        label.setWidth(width: self.frame.width/4)
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
                                                             passengerHeaderLabel,
                                                             pickupTimeHeaderLabel,
                                                             notesHeaderLabel])
        headerStackView.axis = .horizontal
        headerStackView.distribution = .fill
        headerStackView.spacing = 0
        
        self.addSubview(headerStackView)
        headerStackView.anchor(top: topAnchor,
                               left: leftAnchor,
                               bottom: bottomAnchor,
                               right: rightAnchor,
                               paddingTop: 0.0,
                               paddingLeft: 0.0,
                               paddingBottom: 0.0,
                               paddingRight: 0.0)
        
    }
}
