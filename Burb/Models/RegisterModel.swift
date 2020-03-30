//
//  RegisterModel.swift
//  Burb
//
//  Created by Eugene on 23/08/2019.
//  Copyright © 2019 CC_Eugene. All rights reserved.
//

import UIKit


class RegisterModel {
   
    var country: String? = "unknowned"
    var phoneNumber: String?
    var securityCode: String?
    var userID: String?
    var facebookId: String?
    var userType : String?
    
    var customer : Customer?
    var barber : Barber?
    
    var phoneIsFilled: Bool {
        guard !(phoneNumber ?? "").isEmpty else {
            return false
        }
        return true
    }
    
    var securityCodeIsFilled: Bool {
        guard !(securityCode ?? "").isEmpty else {
            return false
        }
        return true
    }
    
    init(phoneNumber: String?, securityCode: String?, country: String?) {
        self.phoneNumber = phoneNumber
        self.securityCode = securityCode
        self.country = country
    }
}

