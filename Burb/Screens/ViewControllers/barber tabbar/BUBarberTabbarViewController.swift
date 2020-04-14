//
//  BUBarberTabbarViewController.swift
//  Burb
//
//  Created by Eugene on 14.04.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit

class BUBarberTabbarViewController: UITabBarController {
    
    var anchorImage: UIImage?
    var profileImage: UIImage?
    var chatImage: UIImage?
    let selectedColor   = UIColor(red: 63.0/255.0, green: 51.0/255.0, blue: 76.0/255.0, alpha: 1.0)
    let unselectedColor = UIColor(red: 63.0/255.0, green: 51.0/255.0, blue: 76.0/255.0, alpha: 0.6)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupControllers()
        Decorator.decorate(self)
        UITabBar.appearance().layer.borderWidth = 0.0
        UITabBar.appearance().clipsToBounds = true
        self.tabBar.tintColor = selectedColor
        self.tabBar.unselectedItemTintColor = unselectedColor
    }
    
    fileprivate func setupControllers() {
        
        anchorImage = UIImage(named: "anchor")
        profileImage = UIImage(named: "profile")
        chatImage = UIImage(named: "chats")
        
        let vc1 = BUBarberOrdersViewController()
        let vc2 = BUDialogsViewController()
        let vc3 = BUBarberProfileViewController()
        
        vc1.tabBarItem.image = anchorImage
        vc2.tabBarItem.image = chatImage
        vc3.tabBarItem.image = profileImage
        
        vc1.tabBarItem.title = "_ORDERS"
        vc2.tabBarItem.title = "_DIALOGS"
        vc3.tabBarItem.title = "_PROFILE"
        setViewControllers([vc1, vc2, vc3], animated: true)
    }
    
}

extension BUBarberTabbarViewController {
    
    fileprivate class Decorator {
        
        private init() {}
        
        static func decorate(_ vc: BUBarberTabbarViewController) {
            vc.tabBar.barTintColor = .white
            
        }
    }
}
