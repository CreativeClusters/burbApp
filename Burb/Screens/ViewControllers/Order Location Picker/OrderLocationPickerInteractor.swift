//
//  OrderLocationPickerInteractor.swift
//  Burb
//
//  Created by Eugene on 30.03.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit

final class OrderLocationPickerInteractor {
    
    static let shared = OrderLocationPickerInteractor()
    
    func saveLocationToUserDefaults(city: String, adress: String, longitude: String, latitude: String) {
        let defaults = UserDefaults.standard
        defaults.setValue(city, forKey: "city")
        defaults.setValue(adress, forKey: "adress")
        defaults.setValue(longitude, forKey: "longitude")
        defaults.setValue(latitude, forKey: "latitude")
    }
}
