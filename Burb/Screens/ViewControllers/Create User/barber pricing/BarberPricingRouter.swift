//
//  BarberPricingRouter.swift
//  Burb
//
//  Created by Eugene on 10.04.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit

final class BarberPricingRouter {
    static let shared = BarberPricingRouter()
    
    
    func handleOnboarding(from source: UIViewController, with userType: UserRole) {
        let vc = BUOnboardingViewController()
        source.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
