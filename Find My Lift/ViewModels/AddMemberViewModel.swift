//
//  AddMemberViewModel.swift
//  Find My Lift
//
//  Created by Stephen Learmonth on 30/10/2020.
//  Copyright © 2020 Stephen Learmonth. All rights reserved.
//

import UIKit

protocol FormCompletionProtocol {
    var formIsValid: Bool { get }
}

struct AddMemberViewModel: FormCompletionProtocol {

    var fullname: String?
    var email: String?
    var address: String?
    var phone: String?
    var web: String?

    var formIsValid: Bool {
        return !(fullname?.isEmpty ?? true) &&
               !(email?.isEmpty ?? true) &&
               !(address?.isEmpty ?? true) &&
               !(phone?.isEmpty ?? true) &&
               !(web?.isEmpty ?? true)
    }
}
