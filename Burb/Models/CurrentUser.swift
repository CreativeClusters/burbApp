//
//  CurrentUser.swift
//  Burb
//
//  Created by Eugene on 23.03.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit

enum UserType: String {
    case customer = "0"
    case barber   = "1"
}

class CurrentUser {
    static let instance = CurrentUser()
    
    var user: RegisterModel!

    var userType: UserType {
        return UserType(rawValue: user.userType ?? "0") ?? .customer
    }
    
}
