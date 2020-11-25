//
//  ActiveOffersAndAcceptsCell.swift
//  Find My Lift
//
//  Created by Stephen Learmonth on 06/11/2020.
//  Copyright © 2020 Stephen Learmonth. All rights reserved.
//

import UIKit

class ActiveOffersAndAcceptsCell: UITableViewCell {

    // MARK: - Properties
    
    lazy var subHeader0Label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: LABEL_FONT_REGULAR, size: 14.0)
        label.backgroundColor = .white
        label.layer.borderWidth = 0.25
        label.layer.borderColor = UIColor.black.cgColor
        return label
    }()
    
    lazy var subHeader1Label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: LABEL_FONT_REGULAR, size: 14.0)
        label.backgroundColor = .white
        label.layer.borderWidth = 0.25
        label.layer.borderColor = UIColor.black.cgColor
        return label
    }()
    
    lazy var subHeader2Label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: LABEL_FONT_REGULAR, size: 14.0)
        label.backgroundColor = .white
        label.layer.borderWidth = 0.25
        label.layer.borderColor = UIColor.black.cgColor
        return label
    }()
    
    lazy var subHeader3Label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: LABEL_FONT_REGULAR, size: 14.0)
        label.textColor = .black
        label.backgroundColor = .white
        label.layer.borderWidth = 0.25
        label.layer.borderColor = UIColor.black.cgColor
        return label
    }()
    
    lazy var subHeader4Label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: LABEL_FONT_REGULAR, size: 14.0)
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
        
        let stackView = UIStackView(arrangedSubviews: [subHeader0Label,
                                                       subHeader1Label,
                                                       subHeader2Label,
                                                       subHeader3Label,
                                                       subHeader4Label])
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
        
        subHeader0Label.setWidthProportionalToSuperview(by: 4.0 / 20.0)
        subHeader1Label.setWidthProportionalToSuperview(by: 4.0 / 20.0)
        subHeader2Label.setWidthProportionalToSuperview(by: 4.0 / 20.0)
        subHeader3Label.setWidthProportionalToSuperview(by: 4.0 / 20.0)
        subHeader4Label.setWidthProportionalToSuperview(by: 4.0 / 20.0)
    }
}

