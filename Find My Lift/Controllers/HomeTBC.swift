//
//  HomeTBC.swift
//  Find My Lift
//
//  Created by Stephen Learmonth on 28/09/2020.
//  Copyright © 2020 Stephen Learmonth. All rights reserved.
//

import UIKit
import Firebase

class HomeTBC: UITabBarController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()

    }
    
    private func configureUI() {
        
        configureGradientLayer()
        
        let homeVC = HomeVC()
        homeVC.title = "Home"
        
        homeVC.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .done, target: self, action: #selector(handleLogOut))
        
        navigationController?.navigationBar.barTintColor = .systemBlue
        navigationController?.navigationBar.layer.borderWidth = 0
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        navigationController?.tabBarItem = .init(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)
        
        let groupsVC = GroupsVC()
        groupsVC.tabBarItem = .init(title: "Groups", image: UIImage(systemName: "person.3.fill"), tag: 1)
        
        let chatVC = ChatVC()
        chatVC.tabBarItem = .init(title: "Chat", image: UIImage(systemName: "bubble.fill"), tag: 2)

        let activeOffersVC = ActiveOffersVC()
        activeOffersVC.tabBarItem = .init(title: "Active Offers", image: UIImage(systemName: "cart"), tag: 3)

        let moreVC = MoreVC()
        moreVC.tabBarItem = .init(title: "More", image: UIImage(systemName: "plus.app.fill"), tag: 4)

        let tabBarItems = [groupsVC, chatVC, activeOffersVC, moreVC]
        viewControllers = tabBarItems

    }
    
    @objc func handleLogOut() {
            do {
                try Auth.auth().signOut()
                DispatchQueue.main.async {
                    let controller = LogInVC()
                    controller.delegate = self
                    controller.modalPresentationStyle = .fullScreen
                    self.present(controller.self, animated: true, completion: nil)
                }
            } catch {
                print("DEBUG: Error signing out. \(error.localizedDescription)")
            }
    }
}

extension HomeTBC: AuthenticationDelegate {
    func completeAuthentication() {
        dismiss(animated: true, completion: nil)
        configureUI()
    }
}


