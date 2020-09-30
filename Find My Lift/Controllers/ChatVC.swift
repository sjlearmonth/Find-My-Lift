//
//  ChatVC.swift
//  Find My Lift
//
//  Created by Stephen Learmonth on 29/09/2020.
//  Copyright © 2020 Stephen Learmonth. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
 
    }
    
    private func configureUI() {
        
        configureGradientLayer()
        
        title = "Chat Conversations"

//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "", style: .done, target: self, action: #selector(handleLogOut))

        navigationController?.navigationBar.barTintColor = .systemBlue
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30)]
        navigationController?.navigationBar.barStyle = .black

    }
}
