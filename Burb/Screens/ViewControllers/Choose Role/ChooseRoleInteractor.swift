//
//  ChooseRoleInteractor.swift
//  Burb
//
//  Created by Eugene on 18.03.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

final class ChooseRoleInteractor {
    
    static let shared = ChooseRoleInteractor()
    
    func setRole(role: String) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        FirestoreManager.registerReference.document(userID).setData([
            "user Role": role.self,
        ])
    }
}
