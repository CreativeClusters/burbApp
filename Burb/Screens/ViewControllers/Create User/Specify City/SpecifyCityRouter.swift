//
//  SpecifyCityRouter.swift
//  Burb
//
//  Created by Eugene on 10.04.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit

final class SpecifyCityRouter {
    static let shared = SpecifyCityRouter()
    
    
    func handleBarberPricing(from source: UIViewController) {
        let vc = BUBarberPricingViewController()
        source.navigationController?.pushViewController(vc, animated: true)
    }
    
}
