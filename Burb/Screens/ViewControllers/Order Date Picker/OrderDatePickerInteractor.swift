//
//  OrderDatePickerInteractor.swift
//  Burb
//
//  Created by Eugene on 31.03.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit


final class OrderDatePickerInteractor {
    
    static let shared = OrderDatePickerInteractor()
    
    func addServicesToUserDefaults(at service: [Int]) {
        let defaults = UserDefaults.standard
        defaults.setValue(service, forKey: "services")
    }
}

