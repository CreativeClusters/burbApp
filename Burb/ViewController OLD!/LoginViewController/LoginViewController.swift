//
//  LoginViewController.swift
//  Burb
//
//  Created by Eugene on 21/08/2019.
//  Copyright © 2019 CC_Eugene. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var termsOfUseLabel: UILabel!
    @IBOutlet weak var signupViaPhoneButton: UIButton!
    @IBOutlet weak var loginAsFacebookButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        decorate()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }

    
    func decorate() {
        let attributedString = NSMutableAttributedString(string: "I agree with terms of use", attributes: [
            .font: UIFont(name: "OpenSans-Light", size: 12.0)!,
            .foregroundColor: UIColor(white: 50.0 / 255.0, alpha: 1.0)
            ])
        attributedString.addAttribute(.font, value: UIFont(name: "OpenSans-Semibold", size: 12.0)!, range: NSRange(location: 13, length: 12))
        termsOfUseLabel.text = attributedString.string
        signupViaPhoneButton.backgroundColor = burbColor
        signupViaPhoneButton.layer.cornerRadius = 25
        loginAsFacebookButton.backgroundColor = blackburbColor
        loginAsFacebookButton.layer.cornerRadius = 25
        termsOfUseLabel.isUserInteractionEnabled = true
        
        
    }
    

    

}
