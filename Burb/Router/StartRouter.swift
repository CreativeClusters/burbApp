//
//  StartRouter.swift
//  Burb
//
//  Created by Eugene on 13.01.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit

class StartRouter {
    
    static let shared = StartRouter()
    
    private init() {}
    
    private let rootViewController: UIViewController = BUChooseBarberViewController()
    
    func root(_ window: inout UIWindow?) {
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(rootViewController: rootViewController)
    }
}
