//
//  LocationPickerRouter.swift
//  Burb
//
//  Created by Eugene on 04.02.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit


final class LocationPickerRouter {
    
    static let shared = LocationPickerRouter()
    
    private init() {}
    
    func goToSettingsViaPhoneViewController(from source: UIViewController) {
        let destinationVC = BUClientProfileViewController()
            source.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func goToDatePickerViewController(from source: UIViewController) {
            let destinationVC = BUOrderDatePickerViewController()
        source.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
}
