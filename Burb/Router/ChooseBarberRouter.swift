//
//  ChooseBarberRouter.swift
//  Burb
//
//  Created by Eugene on 09.02.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit

final class ChooseBarberRouter {
    
    static let shared = ChooseBarberRouter()
    
    private init() {}
    
    func goToMainTabber(from source: UIViewController) {
        let destinationVC = BUClientTabBarController()
            source.navigationController?.pushViewController(destinationVC, animated: true)
    }
}
