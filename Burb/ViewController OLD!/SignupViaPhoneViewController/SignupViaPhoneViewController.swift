//
//  SignupViaPhoneViewController.swift
//  Burb
//
//  Created by Eugene on 21/08/2019.
//  Copyright © 2019 CC_Eugene. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignupViaPhoneViewController: UIViewController, UITextFieldDelegate  {

    @IBOutlet weak var phoneNumber: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        title = "Sign up via phone"
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        phoneNumber.becomeFirstResponder()
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC: ConfirmSignupViewController = segue.destination as! ConfirmSignupViewController
        destinationVC.phoneNumber = phoneNumber.text
    }
    
    
    @IBAction func sendCodeAction(_ sender: UIButton) {
    sendConde()
    }
    
    
    func sendConde() {
        let alert = UIAlertController(title: "Phone number", message: "is this your phone number? \(phoneNumber.text!)", preferredStyle: .alert)
        let action = UIAlertAction(title: "Yes", style: .default) { (UIAlertAction) in
            PhoneAuthProvider.provider().verifyPhoneNumber(self.phoneNumber.text!, uiDelegate: nil) { (verificationID, error) in
                if error != nil {
                    print("error \(String(describing: error))")
                } else {
                    let defaults = UserDefaults.standard
                    defaults.setValue(verificationID, forKey: "authVID")
                    self.performSegue(withIdentifier: "confirmCode", sender: Any?.self)
                }
            }
        }
        
        let cancel = UIAlertAction(title: "No", style: .cancel, handler: nil)
        alert.addAction(action)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    
    
    
}

