//
//  FirebaseMager.swift
//  Burb
//
//  Created by Eugene on 26.02.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import Foundation

import Firebase
import FirebaseDatabase
import FirebaseFirestore



class FirestoreManager {
    
    static let register = "registerModel"
    static let customers = "customers"
    static let barbers = "barbers"
    static let orders = "orders"
    static let services = "services"
    static let pricingModel = "pricingModel"
    
    static let sourceReference = Firestore.firestore()
    
    static let registerReference = sourceReference.collection(register)
    static let customersReference = sourceReference.collection(customers)
    static let barbersReference = sourceReference.collection(barbers)
    static let ordersReference = sourceReference.collection(orders)
    static let servicesReference = sourceReference.collection(services)
    static let pricingModelReference = sourceReference.collection(pricingModel)
}


