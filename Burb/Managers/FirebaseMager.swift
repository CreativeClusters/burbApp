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

    static let sourceReference = Firestore.firestore()
    
    static let registerReference = sourceReference.collection(register)
    static let customersReference = sourceReference.collection(customers)
    static let barbersReference = sourceReference.collection(barbers)
}


