//
//  Barber.swift
//  Burb
//
//  Created by Eugene on 18.03.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit

class Barber: NSObject {
    var id: String
    var phoneNumber: String?
    var name: String?
    var photo: UIImage?
    var fullPhoto: UIImage?
    var avatarReference: String?
    var fullAvatarReference: String?
    var age: Int?
    var weapon: String?
    var education: String?
    var philosophy: String?
    
    var dict: [String: Any] {
        return [
            "id": id,
            "phone": phoneNumber ?? "",
            "name": name ?? "",
            "avatarReference": avatarReference ?? "",
            "fullAvatarReference": fullAvatarReference ?? "",
            "age": age ?? "",
            "weapon": weapon ?? "",
            "education": education ?? "",
            "philosophy": philosophy ?? "",
        ]}
    
    init(id: String, name: String, photo:UIImage, fullPhoto: UIImage?, phoneNumber: String, avatarReference: String, fullAvatarReference: String, age: Int, weapon: String, education: String, philosophy: String) {
        self.id = id
        self.name = name
        self.phoneNumber = phoneNumber
        self.photo = photo
        self.fullPhoto = fullPhoto
        self.avatarReference = avatarReference
        self.fullAvatarReference = fullAvatarReference
        self.age = age
        self.weapon = weapon
        self.education = education
        self.philosophy = philosophy
    }
    
    var isFilled: Bool {
        guard !(name ?? "").isEmpty,!(phoneNumber ?? "").isEmpty, photo != nil, fullPhoto != nil, age != nil, !(weapon ?? "").isEmpty, !(education ?? "").isEmpty, !(philosophy ?? "").isEmpty else {
            return false
        }
        return true
    }
}
