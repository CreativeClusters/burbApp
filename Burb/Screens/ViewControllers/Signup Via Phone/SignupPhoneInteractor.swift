//
//  SignupPhoneInteractor.swift
//  Burb
//
//  Created by Eugene on 19.01.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

final class SignupPhoneInteractor {
    
    static let shared = SignupPhoneInteractor()
    
    func sendPhoneNumber(phoneNumber: String) {
        
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
            if error != nil {
                print("error \(String(describing: error))")
            } else {
                let defaults = UserDefaults.standard
                defaults.setValue(verificationID, forKey: "authVID")
                defaults.setValue(phoneNumber, forKey: "phoneNumber")
            }
        }
    }

    func sendConfirmCode(securityCode: String, phoneNumber: String) {
        let defaults = UserDefaults.standard
        let credential: PhoneAuthCredential = PhoneAuthProvider.provider().credential(withVerificationID: defaults.string(forKey: "authVID")!, verificationCode: securityCode)
        Auth.auth().signIn(with: credential) { (user, error) in
            if error != nil {
                print("error: \(String(describing: error?.localizedDescription))")
            } else {
                print("Phone number: \(String(describing: user?.additionalUserInfo))")
                guard let userID = Auth.auth().currentUser?.uid else { return }
                let defaults = UserDefaults.standard
                defaults.setValue(userID, forKey: "userID")
                defaults.setValue(securityCode, forKey: "securityCode")
                FirestoreManager.registerReference.document(userID).setData([
                    "userId": userID,
                    "phoneNumber": phoneNumber,
                    "securityCode": securityCode,
                ])
            }
        }
    }
    
    func checkIfUserExists(phoneNumber: String) {

        if (phoneNumber.isEmpty == false){
            let databaseReference = FirestoreManager.registerReference
            
            databaseReference.getDocuments { (snapshot, error) in
                if let value = snapshot?.value(forKey: "phoneNumber") {
                    print("we already have \(value)")
                } else {
                    print("user doesnt exist")
                }
            }
        }
    }
    
    
    func signIn() {
        guard let verificationID = UserDefaults.standard.string(forKey: "authVerificationID"), let verificationCode = UserDefaults.standard.string(forKey: "securityCode") else { return }
        
        let credentials = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: verificationCode)
        
        Auth.auth().signIn(with: credentials) { (authResult, error) in
            if let error = error  {
                let authError = error as NSError
                print(authError)
            } else {
                print("user with \(verificationID) is logged in!")
            }
        }
    }
}
