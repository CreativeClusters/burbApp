//
//  ConfirmSignupViewController.swift
//  Burb
//
//  Created by Eugene on 21/08/2019.
//  Copyright © 2019 CC_Eugene. All rights reserved.
//   roleViewControllerIdentifier

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ConfirmSignupViewController: UIViewController, UITextFieldDelegate {
    
    public var phoneNumber: String?
    
    @IBOutlet weak var codeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        title = "Confirm Sign up"
        checkIfUserExists()
        codeTextField.defaultTextAttributes.updateValue(5.0, forKey: NSAttributedString.Key(rawValue: NSAttributedString.Key.kern.rawValue))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        codeTextField.becomeFirstResponder()
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.shadowImage = UIImage()
    }

    @IBAction func confirmCodeAction(_ sender: Any) {
        
        let defaults = UserDefaults.standard
        let credential: PhoneAuthCredential = PhoneAuthProvider.provider().credential(withVerificationID: defaults.string(forKey: "authVID")!, verificationCode: codeTextField.text!)
        Auth.auth().signIn(with: credential) { (user, error) in
            if error != nil {
                print("error: \(String(describing: error?.localizedDescription))")
            } else {
                print("Phone number: \(String(describing: user?.additionalUserInfo))")
                self.performSegue(withIdentifier: "roleViewControllerIdentifier", sender: Any?.self)
                let ref = Database.database().reference(fromURL: "https://burb-b8940.firebaseio.com/")
                
                guard let userID = Auth.auth().currentUser?.uid, self.phoneNumber != nil else { return }
                let userRefeference = ref.child("users").child(userID)
                
                let userValues = ["phone": self.phoneNumber, "code": self.codeTextField.text!]
                userRefeference.updateChildValues(userValues, withCompletionBlock: { (error, ref) in
                    if error != nil {
                        print(error!)
                        return
                    }
                })
            }
        }
    }
    
    func checkIfUserExists() {
        
        if (phoneNumber!.isEmpty == false){
            let databaseRef = Database.database().reference()
            
            databaseRef.child("users").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
                if let value = snapshot.value as? [String: Any] {
                let phone = value["phone"] as? String ?? ""
                print(phone + " THIS IS IT !")
                } else {
                    print("Nothing here")
                }
                if snapshot.hasChild(self.phoneNumber!){
                    
                    print("User exist")
                    
                }else{
                    
                    print("User doesn't exist")
                }
            })
        }
    }
    
    
    
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
