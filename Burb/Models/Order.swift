//
//  Order.swift
//  Burb
//
//  Created by Eugene on 12/09/2019.
//  Copyright © 2019 CC_Eugene. All rights reserved.
//

import Foundation



class Order: NSObject {
    var orderId: String?
    var userId: String?
    var descriptionOrder: String?
    var date: NSNumber?
    var barberId: String?
    var barberName: String?
    var barberAvatar: String?
    var adress: String?
    var city: String?
    var longitude: Double?
    var latitude: Double?
    
    init(dictionary: [String: Any]) {
        self.orderId = dictionary["orderId"] as? String
        self.userId = dictionary["userId"] as? String
        self.descriptionOrder = dictionary["descriptionOrder"] as? String
        self.date = dictionary["date"] as? NSNumber
        self.barberId = dictionary["barberId"] as? String
        self.barberName = dictionary["barberName"] as? String
        self.barberAvatar = dictionary["barberAvatar"] as? String
        self.adress = dictionary["adress"] as? String
        self.city = dictionary["city"] as? String
        self.longitude = dictionary["longitude"] as? Double
        self.latitude = dictionary["latitude"] as? Double
     }
}

