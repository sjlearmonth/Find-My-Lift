//
//  HomeTitleView.swift
//  Find My Lift
//
//  Created by Stephen Learmonth on 13/11/2020.
//  Copyright © 2020 Stephen Learmonth. All rights reserved.
//

import UIKit

class HomeTitleView: UIView {

    // MARK: - Properties
    
    private let homeTitleImageView: UIImageView = {
        let hiv = UIImageView()
        hiv.image = UIImage(named: "Stephen")
        hiv.contentMode = .scaleAspectFill
        hiv.clipsToBounds = true
        hiv.setHeight(height: 180)
        hiv.backgroundColor = .clear
        return hiv
    }()
    
    var homeTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.backgroundColor = .clear
        label.textColor = .white
        return label
    }()
    
    let gradient = CAGradientLayer()

    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
      super.layoutSubviews()
      gradient.frame = self.bounds
    }
    
    // MARK: - Helper Functions
    
    private func configureUI() {
                        
        self.addSubview(homeTitleImageView)
        homeTitleImageView.anchor(top: safeAreaLayoutGuide.topAnchor, left: leftAnchor,
                               bottom: bottomAnchor, right: rightAnchor,
                               paddingTop: 0, paddingLeft: 0,
                               paddingBottom: 0, paddingRight: 0)
        
        self.addSubview(homeTitleLabel)
        homeTitleLabel.anchor(left: leftAnchor, bottom: bottomAnchor,
                           paddingLeft: 12, paddingBottom: 30)
        
        gradient.colors = [UIColor.clear.cgColor , UIColor.black.cgColor]
        gradient.locations = [0.85, 1]
        self.layer.addSublayer(gradient)

    }
}

