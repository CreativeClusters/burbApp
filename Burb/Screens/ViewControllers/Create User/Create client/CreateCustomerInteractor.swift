//
//  CreateCustomerInteractor.swift
//  Burb
//
//  Created by Eugene on 18.03.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

final class CreateCustomerInteractor {
    
    static let shared = CreateCustomerInteractor()
    
    func createCustomer(customer: Customer) {
        
        let defaults = UserDefaults.standard
        let userID = defaults.string(forKey: "userID")
        
        FirestoreManager.customersReference.document(userID!).setData([
            "userId": customer.id,
            "phoneNumber": customer.phoneNumber!,
            "name": customer.name!,
            "avatarReference": customer.avatarReference!
        ])
        guard let customerPhoto = customer.photo else { return }
        StorageManager.shared.uploadCustomerPhoto(photo: customerPhoto, by: customer)
    }
}
