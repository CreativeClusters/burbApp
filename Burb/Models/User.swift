//
//  Barber.swift
//  Burb
//
//  Created by Eugene on 29/08/2019.
//  Copyright © 2019 CC_Eugene. All rights reserved.
//

import UIKit

class User: NSObject {
    var id: String?
    var phone: String?
    var name: String?
    var avatarReference: String?
    var notifications: String?
    var language: String?
    
    init(dictionary: [String: Any]) {
        self.id = dictionary["id"] as? String
        self.phone = dictionary["phone"] as? String
        self.name = dictionary["name"] as? String
        self.avatarReference = dictionary["avatarReference"] as? String
        self.notifications = dictionary["notifications"] as? String
        self.language = dictionary["language"] as? String
    }
}
