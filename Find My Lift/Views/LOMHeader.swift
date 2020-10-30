//
//  LOMHeader.swift
//  Find My Lift
//
//  Created by Stephen Learmonth on 28/10/2020.
//  Copyright © 2020 Stephen Learmonth. All rights reserved.
//

import UIKit

class LOMHeader: UIView {
    
    // MARK: - Properties
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .systemGreen
        label.font = UIFont(name: "AvenirNext-Bold", size: 18.0)
        label.layer.borderWidth = 0.25
        label.layer.borderColor = UIColor.black.cgColor
        label.setWidth(width: 4.0 * self.frame.width / 16.0)
        return label
    }()

    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "Rating"
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .systemGreen
        label.font = UIFont(name: "AvenirNext-Bold", size: 18.0)
        label.layer.borderWidth = 0.25
        label.layer.borderColor = UIColor.black.cgColor
        label.setWidth(width: 5.0 * self.frame.width / 16.0)
        return label
    }()

    private lazy var footprintLabel: UILabel = {
        let label = UILabel()
        label.text = "Footprint"
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .systemGreen
        label.font = UIFont(name: "AvenirNext-Bold", size: 12.0)
        label.layer.borderWidth = 0.25
        label.layer.borderColor = UIColor.black.cgColor
        label.setWidth(width: 3.5 * self.frame.width / 16.0)
        return label
    }()

    private lazy var feedbackLabel: UILabel = {
        let label = UILabel()
        label.text = "Feedback"
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .systemGreen
        label.font = UIFont(name: "AvenirNext-Bold", size: 12.0)
        label.layer.borderWidth = 0.25
        label.layer.borderColor = UIColor.black.cgColor
        label.setWidth(width: 3.5 * self.frame.width / 16.0)
        return label
    }()

    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let stackView = UIStackView(arrangedSubviews: [nameLabel,
                                                       ratingLabel,
                                                       footprintLabel,
                                                       feedbackLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 0
        
        self.addSubview(stackView)
        stackView.anchor(top: topAnchor,
                           left: leftAnchor,
                           bottom: bottomAnchor,
                           right: rightAnchor,
                           paddingTop: 0.0,
                           paddingLeft: 0.0,
                           paddingBottom: 0.0,
                           paddingRight: 0.0)
        
        print("DEBUG: header width = \(self.frame.width)")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

