//
//  AuthService.swift
//  Find My Lift
//
//  Created by Stephen Learmonth on 28/09/2020.
//  Copyright © 2020 Stephen Learmonth. All rights reserved.
//

import UIKit
import Firebase

struct RegistrationCredentials {
    let email: String
    let password: String
    let fullname: String
    let username: String
}

struct AuthService {
    
static let shared = AuthService()

    func logUserIn(withEmail email: String, password: String, completion: AuthDataResultCallback?) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    func createUser(credentials: RegistrationCredentials, completion: ((Error?) -> Void)?) {
        
        Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { (result, error) in
            if let error = error {
                completion!(error)
            }
            
            guard let uid = result?.user.uid else { return }
            
            let data = ["email" : credentials.email,
                        "fullname" : credentials.fullname,
                        "uid" : uid,
                        "username" : credentials.username] as [String : Any]
            
            Firestore.firestore().collection("users").document(uid).setData(data, completion: completion)
            
        }
    }
}

