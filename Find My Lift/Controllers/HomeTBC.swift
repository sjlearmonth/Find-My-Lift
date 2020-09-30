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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()

    }
    
    private func configureUI() {
        
        let homeVC = HomeVC()
        homeVC.tabBarItem = .init(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        let homeNav = UINavigationController(rootViewController: homeVC)
        
        let groupsVC = GroupsVC()
        groupsVC.tabBarItem = .init(title: "Groups", image: UIImage(systemName: "person.3.fill"), tag: 1)
        let groupsNav = UINavigationController(rootViewController: groupsVC)
        
        let chatVC = ChatVC()
        chatVC.tabBarItem = .init(title: "Chat", image: UIImage(systemName: "bubble.right"), tag: 2)
        let chatNav = UINavigationController(rootViewController: chatVC)

        let activeOffersVC = ActiveOffersVC()
        activeOffersVC.tabBarItem = .init(title: "Active Offers", image: UIImage(systemName: "cart"), tag: 3)
        let activeOffersNav = UINavigationController(rootViewController: activeOffersVC)

        let moreVC = MoreVC()
        moreVC.tabBarItem = .init(title: "More", image: UIImage(systemName: "plus.app.fill"), tag: 4)
        let moreNav = UINavigationController(rootViewController: moreVC)

        let tabBarItems = [homeNav, groupsNav, chatNav, activeOffersNav, moreNav]
        viewControllers = tabBarItems

    }
    
}


