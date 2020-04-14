//
//  AuthManager.swift
//  Burb
//
//  Created by Eugene on 26.02.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth

enum FirebaseResult {
    case success(String)
    case error(String)
}

class AuthManager: FirestoreManager {
    
    static let shared = AuthManager()
    var currentUser: User?

    private let auth = Auth.auth()


    func signIn(completion: @escaping ItemClosure<FirebaseResult>) {
        
        guard let verificationID = UserDefaults.standard.string(forKey: "authVID"), let verificationCode = UserDefaults.standard.string(forKey: "securityCode") else { return }
        
        let credentials = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: verificationCode)
        
        Auth.auth().signIn(with: credentials) { (authResult, error) in
            if let error = error  {
                let authError = error as NSError
                print(authError)
            }
            
            guard let user = authResult?.user else {
                completion(FirebaseResult.error(error!.localizedDescription))
                return
            }
            self.currentUser = user
            completion(FirebaseResult.success("user logged in success"))
        }
    }
}

