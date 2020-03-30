//
//  Barber.swift
//  Burb
//
//  Created by Eugene on 29/08/2019.
//  Copyright © 2019 CC_Eugene. All rights reserved.
//

import UIKit

class Customer: NSObject {
    var id: String
    var phoneNumber: String?
    var name: String?
    var photo: UIImage?
    var avatarReference: String?
    
    var dict: [String: Any] {
        return [
            "id": id ,
            "phone": phoneNumber ?? "",
            "name": name ?? "",
            "avatarReference": avatarReference ?? ""
        ]}
    
    init(id: String, name: String, photo:UIImage, phoneNumber: String, avatarReference: String) {
        self.id = id
        self.name = name
        self.phoneNumber = phoneNumber
        self.photo = photo
        self.avatarReference = avatarReference
    }
    
    var isFilled: Bool {
        guard !(name ?? "").isEmpty,!(phoneNumber ?? "").isEmpty, photo != nil else {
            return false
        }
        return true
    }
}
