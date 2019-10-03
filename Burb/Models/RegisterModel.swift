//
//  RegisterModel.swift
//  Burb
//
//  Created by Eugene on 23/08/2019.
//  Copyright © 2019 CC_Eugene. All rights reserved.
//

import UIKit


class RegisterModel {
    var photoView: UIImage?
    var phoneNumber: String?
    var securityCode: String?
    var name: String?
    var role: Role? = .client
 
    var isFilled: Bool {
        guard !(phoneNumber ?? "").isEmpty, !(securityCode ?? "").isEmpty, !(name ?? "").isEmpty, role != nil else {
            return false
        }
        return true
    }
}


