//
//  SignupPhoneRouter.swift
//  Burb
//
//  Created by Eugene on 16.01.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit

final class SignupPhoneRouter {

    static let shared = SignupPhoneRouter()
    
    private init() {}
    
    func goToChooseRoleVC(from source: UIViewController) {
        let destinationVC = BUChooseRoleViewController()
        source.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func routeAfterSuccessAuth(from source: UIViewController) {
        let vc = UINavigationController.init(rootViewController: BUOrderLocationPickerViewController())
        source.present(vc, animated: true, completion: nil)
    }
}
