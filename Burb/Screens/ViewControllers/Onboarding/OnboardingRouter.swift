//
//  OnboardingRouter.swift
//  Burb
//
//  Created by Eugene on 05.04.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit


final class OnboardingRouter {
    
    static  let shared = OnboardingRouter()
    
    private init() {}
    
    func handleClient(from source: UIViewController) {
        let destinationVC = BUOrderLocationPickerViewController()
        source.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func handleBarber(from source: UIViewController) {
        let destinationVC = BUSpecifyDatesViewController()
        source.navigationController?.pushViewController(destinationVC, animated: true)
    }
}
