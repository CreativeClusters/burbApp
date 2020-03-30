//
//  ChooseRoleRouter.swift
//  Burb
//
//  Created by Eugene on 26.01.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit

final class ChooseRoleRouter {
    
    static let shared = ChooseRoleRouter()
    private init() {}
    
    func handleCreateCustomerVC(from source: UIViewController) {
        let destinationVC = BUCreateUserViewController()
        source.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func handleCreateBarberVC(from source: UIViewController) {
        let destinationVC = BUCreateBarberViewController()
        source.navigationController?.pushViewController(destinationVC, animated: true)
    }
}
