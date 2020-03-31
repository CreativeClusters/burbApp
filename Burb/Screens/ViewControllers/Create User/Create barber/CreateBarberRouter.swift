//
//  CreateBarberRouter.swift
//  Burb
//
//  Created by Eugene on 31.03.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit

final class CreateBarberRouter {
    
    static  let shared = CreateBarberRouter()
    
    private init() {}
    
    func handleOnboarding(from source: UIViewController) {
        let destinationVC = BUOnboardingViewController()
        source.navigationController?.pushViewController(destinationVC, animated: true)
    }
}
