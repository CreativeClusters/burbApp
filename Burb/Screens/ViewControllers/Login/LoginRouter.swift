//
//  LoginRouter.swift
//  Burb
//
//  Created by Eugene on 16.01.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit
import SPStorkController


final class LoginRouter {
    
    static let shared = LoginRouter()
    
    private init() {}
    
    func goToSignupViaPhoneViewController(from source: UIViewController) {
        let destinationVC = BUSignupViaPhoneViewController()
            source.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func goToLoginViaFacebook(from source: UIViewController) {
       // go to FB
    }
    
    func goToTermsOfUseViewController(from source: UIViewController) {
      let destinationVC = BUTermsOfUseViewController()
        source.presentAsStork(destinationVC, height: source.view.frame.height * 0.7)
    }
}

