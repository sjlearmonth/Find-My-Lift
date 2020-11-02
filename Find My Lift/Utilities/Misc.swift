//
//  Misc.swift
//  Find My Lift
//
//  Created by Stephen Learmonth on 02/11/2020.
//  Copyright © 2020 Stephen Learmonth. All rights reserved.
//

import UIKit

class FontList: UIFont {
    
    func printSystemFonts() {
        for family in UIFont.familyNames {
            print("family:", family)
            for font in UIFont.fontNames(forFamilyName: family) {
                print("font:", font)
            }
        }
    }
}


