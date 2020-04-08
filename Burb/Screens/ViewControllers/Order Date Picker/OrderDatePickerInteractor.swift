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
    
    var services: [Service] = []
    
    func addServicesToUserDefaults(at service: [Int]) {
        let defaults = UserDefaults.standard
        defaults.setValue(service, forKey: "services")
    }
    
    func fetchServices() {
        FirestoreManager.servicesReference.getDocuments { (snapshot, error) in
            if let err = error {
                print("Error getting services: \(err)")
            } else {
                for document in snapshot!.documents {
                    
                    
                    let service = [Service(serviceId: document.data()["serviceId"] as! String, serviceName: document.data()["serviceName"] as! String)]
                    self.services.append(contentsOf: service)
                }
        }
    }
}

}
