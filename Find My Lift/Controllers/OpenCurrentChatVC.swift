//
//  OpenCurrentChatVC.swift
//  Find My Lift
//
//  Created by Stephen Learmonth on 03/11/2020.
//  Copyright © 2020 Stephen Learmonth. All rights reserved.
//

import UIKit

class OpenCurrentChatVC: UIViewController {

    // MARK: - Properties
    
    var selectedChat = [String:String]()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    // MARK: - Helper Functions
    
    private func configureUI() {
        configureGradientLayer()
        
        title = "Current Chat"
        navigationItem.backButtonTitle = ""

        navigationController?.navigationBar.barTintColor = .systemBlue
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30)]
        navigationController?.navigationBar.barStyle = .black

    }


}
