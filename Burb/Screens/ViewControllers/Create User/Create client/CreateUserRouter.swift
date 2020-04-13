//
//  CreateUserRouter.swift
//  Burb
//
//  Created by Eugene on 26.01.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit

final class CreateCustomerRouter {
    
    static  let shared = CreateCustomerRouter()
    
    private init() {}
    
    func handleOnboarding(from source: UIViewController) {
        let destinationVC = BUOnboardingViewController()
        source.navigationController?.pushViewController(destinationVC, animated: true)
    }
}

