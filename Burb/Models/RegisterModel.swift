//
//  RegisterModel.swift
//  Burb
//
//  Created by Eugene on 23/08/2019.
//  Copyright © 2019 CC_Eugene. All rights reserved.
//

import UIKit


class RegisterModel {
    
    var phoneNumber: String?
    var securityCode: String?
    var userID: String?
    var facebookId: String?
 
    var isFilled: Bool {
        guard !(phoneNumber ?? "").isEmpty, !(securityCode ?? "").isEmpty, !(userID ?? "").isEmpty else {
            return false
        }
        return true
    }
}


