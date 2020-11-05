//
//  MessageCell.swift
//  Find My Lift
//
//  Created by Stephen Learmonth on 05/11/2020.
//  Copyright © 2020 Stephen Learmonth. All rights reserved.
//

import UIKit

class MessageCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    var message: [String:String]? {
        didSet {
            configureMessageCell()
        }
    }
    
    var bubbleLeftAnchor: NSLayoutConstraint!
    var bubbleRightAnchor: NSLayoutConstraint!
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 16.0)
        label.backgroundColor = .clear
        return label
    }()
    
    private let messageTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.font = UIFont(name: "AvenirNext-Regular", size: 16.0)
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.textColor = .white
        return textView
    }()
    
    private let bubbleContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPurple
        return view
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(userNameLabel)
        userNameLabel.anchor(left: leftAnchor, paddingLeft: 8)
        userNameLabel.centerY(inView: self)
        
        addSubview(bubbleContainer)
        bubbleContainer.layer.cornerRadius = 12
        bubbleContainer.anchor(top: topAnchor, bottom: bottomAnchor)
        bubbleContainer.widthAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true
        
        bubbleLeftAnchor = bubbleContainer.leftAnchor.constraint(equalTo: userNameLabel.rightAnchor, constant: 12)
        bubbleLeftAnchor.isActive = false
        bubbleRightAnchor = bubbleContainer.rightAnchor.constraint(equalTo: rightAnchor, constant: -12)
        bubbleRightAnchor.isActive = false
        
        bubbleContainer.addSubview(messageTextView)
        messageTextView.anchor(top: bubbleContainer.topAnchor, left: bubbleContainer.leftAnchor,
                        bottom: bubbleContainer.bottomAnchor, right: bubbleContainer.rightAnchor,
                        paddingTop: 4, paddingLeft: 12, paddingBottom: 4, paddingRight: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configureMessageCell() {
        guard let message = message else { return }
        userNameLabel.text = message["Name"]
        if message["Name"] == "currentUser" {
            bubbleContainer.backgroundColor = .lightGray
            messageTextView.textColor = .black
            bubbleLeftAnchor.isActive = false
            bubbleRightAnchor.isActive = true
            userNameLabel.isHidden = true
        } else {
            bubbleContainer.backgroundColor = .systemPurple
            messageTextView.textColor = .white
            bubbleLeftAnchor.isActive = true
            bubbleRightAnchor.isActive = false
            userNameLabel.isHidden = false
        }
        messageTextView.text = message["Message"]
    }
}

