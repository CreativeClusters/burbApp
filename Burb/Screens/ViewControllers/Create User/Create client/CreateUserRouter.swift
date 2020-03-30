//
//  CreateUserRouter.swift
//  Burb
//
//  Created by Eugene on 26.01.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit

final class CreateUserRouter {
    
    static  let shared = CreateUserRouter()
    
    private init() {}
    
    func goToChooseLocation(from source: UIViewController) {
        let destinationVC = BUOnboardingViewController()
        source.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    
}
