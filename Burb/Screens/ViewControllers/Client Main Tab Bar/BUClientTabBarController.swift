//
//  BUClientTabBarController.swift
//  Burb
//
//  Created by Eugene on 29.01.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit

class BUClientTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    var anchorImage: UIImage?
    var profileImage: UIImage?
    
    let selectedColor   = UIColor(red: 63.0/255.0, green: 51.0/255.0, blue: 76.0/255.0, alpha: 1.0)
    let unselectedColor = UIColor(red: 63.0/255.0, green: 51.0/255.0, blue: 76.0/255.0, alpha: 0.6)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupControllers()
        UITabBar.appearance().layer.borderWidth = 0.0
        UITabBar.appearance().clipsToBounds = true
        self.tabBar.tintColor = selectedColor
        self.tabBar.unselectedItemTintColor = unselectedColor
    }

    
    
    fileprivate func setupControllers() {
        
        anchorImage = UIImage(named: "ic_orders.png")
        profileImage = UIImage(named: "ic_profile.png")
    
         let vc1 = BUMyOrdersViewController()
         let vc2 = BUDialogsViewController()
         let vc3 = BUClientProfileViewController()
        
        vc1.tabBarItem.image = anchorImage
        if #available(iOS 13.0, *) {
            vc2.tabBarItem.image = UIImage(systemName: "message")
        } else {
            // Fallback on earlier versions
        }
        vc3.tabBarItem.image = profileImage
        vc1.tabBarItem.title = "_MYORDERS"
        vc2.tabBarItem.title = "_DIALOGS"
        vc3.tabBarItem.title = "_PROFILE"
        setViewControllers([vc1, vc2, vc3], animated: true)
    }
}

extension BUClientTabBarController {
    
    fileprivate class Decorator {
        
        private init() {}
        
        static func decorate(_ vc: BUClientTabBarController) {
            vc.tabBar.barTintColor = .white

        }
    }
}
