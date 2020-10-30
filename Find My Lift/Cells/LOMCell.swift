//
//  LOMCell.swift
//  Find My Lift
//
//  Created by Stephen Learmonth on 28/10/2020.
//  Copyright © 2020 Stephen Learmonth. All rights reserved.
//

import UIKit

class LOMCell: UITableViewCell {

    // MARK: - Properties
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "AvenirNext-Regular", size: 12.0)
        label.backgroundColor = .white
        label.layer.borderWidth = 0.25
        label.layer.borderColor = UIColor.black.cgColor
        return label
    }()

    private lazy var containerView: UIView = {
        let cv = UIView()
        cv.addSubview(ratingImageView)
        ratingImageView.anchor(top: cv.topAnchor, left: cv.leftAnchor, bottom: cv.bottomAnchor, right: cv.rightAnchor, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0)
        cv.layer.borderWidth = 0.25
        cv.layer.borderColor = UIColor.black.cgColor
        return cv
    }()
    
    lazy var ratingImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .white
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    lazy var footprintLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "AvenirNext-Regular", size: 12.0)
        label.backgroundColor = .white
        label.layer.borderWidth = 0.25
        label.layer.borderColor = UIColor.black.cgColor
        return label
    }()
    
    lazy var feedbackLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "AvenirNext-Regular", size: 12.0)
        label.textColor = .black
        label.backgroundColor = .white
        label.layer.borderWidth = 0.25
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
        
        let stackView = UIStackView(arrangedSubviews: [nameLabel,
                                                       containerView,
                                                       footprintLabel,
                                                       feedbackLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        
        contentView.addSubview(stackView)
        stackView.anchor(top: self.topAnchor,
                         left: self.leftAnchor,
                         bottom: self.bottomAnchor,
                         right: self.rightAnchor,
                         paddingTop: 0.0,
                         paddingLeft: 0.0,
                         paddingBottom: 0.0,
                         paddingRight: 0.0)
        
        nameLabel.setWidthProportionalToSuperview(by: 4.0 / 16.0)
        containerView.setWidthProportionalToSuperview(by: 5.0 / 16.0)
        footprintLabel.setWidthProportionalToSuperview(by: 3.5 / 16.0)
        feedbackLabel.setWidthProportionalToSuperview(by: 3.5 / 16.0)
        
        print("DEBUG: cell width = \(self.frame.width)")
    }
}
