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
import FirebaseDatabase

final class SignupPhoneInteractor {
    
    static let shared = SignupPhoneInteractor()
    
    private init() {}
    
    
    func sendPhoneNumber(phoneNumber: String) {
        
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
            if error != nil {
                print("error \(String(describing: error))")
            } else {
                let defaults = UserDefaults.standard
                defaults.setValue(verificationID, forKey: "authVID")
            }
        }
    }
    
    
    func sendConfirmCode(code: String, phoneNumber: String) {
        
        let defaults = UserDefaults.standard
        let credential: PhoneAuthCredential = PhoneAuthProvider.provider().credential(withVerificationID: defaults.string(forKey: "authVID")!, verificationCode: code)
        Auth.auth().signIn(with: credential) { (user, error) in
            if error != nil {
                print("error: \(String(describing: error?.localizedDescription))")
            } else {
                print("Phone number: \(String(describing: user?.additionalUserInfo))")
                let ref = Database.database().reference(fromURL: "https://burb-b8940.firebaseio.com/")
                
                guard let userID = Auth.auth().currentUser?.uid, phoneNumber != nil else { return }
                let userRefeference = ref.child("users").child(userID)
                
                let userValues = ["phone": phoneNumber, "code": code]
                userRefeference.updateChildValues(userValues, withCompletionBlock: { (error, ref) in
                    if error != nil {
                        print(error!)
                        return
                    }
                })
            }
        }
    }
    
    
    func checkIfUserExists(phoneNumber: String) {
        
        if (phoneNumber.isEmpty == false){
            let databaseRef = Database.database().reference()
            
            databaseRef.child("users").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
                if let value = snapshot.value as? [String: Any] {
                let phone = value["phone"] as? String ?? ""
                print(phone + " THIS IS IT !")
                } else {
                    print("Nothing here")
                }
                if snapshot.hasChild(phoneNumber){
                    
                    print("User exist")
                    
                }else{
                    
                    print("User doesn't exist")
                }
            })
        }
    }
    
    
    
}
