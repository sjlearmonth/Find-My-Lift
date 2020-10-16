//
//  LogInViewModel.swift
//  Find My Lift
//
//  Created by Stephen Learmonth on 28/09/2020.
//  Copyright © 2020 Stephen Learmonth. All rights reserved.
//

import UIKit

protocol AuthenticationProtocol {
    var formIsValid: Bool { get }
}

struct LogInViewModel: AuthenticationProtocol {
    var email: String?
    var password: String?

    var formIsValid: Bool {
        return !(email?.isEmpty ?? true) &&
               !(password?.isEmpty ?? true)
    }
}

