//
//  CustomTextField.swift
//  Find My Lift
//
//  Created by Stephen Learmonth on 28/09/2020.
//  Copyright © 2020 Stephen Learmonth. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    
    init(placeholder: String, isSecureTextEntry: Bool) {
        super.init(frame: .zero)
        
        borderStyle = .none
        font = UIFont.systemFont(ofSize: 16)
        textColor = .white
        keyboardAppearance = .dark
        attributedPlaceholder = NSAttributedString(string: placeholder,
                                                   attributes: [.foregroundColor : UIColor.white])
        self.isSecureTextEntry = isSecureTextEntry
        returnKeyType = .done
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


