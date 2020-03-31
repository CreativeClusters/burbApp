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
    var services: [Service]?
    var descriptionOrder: String?
    var date: NSNumber?
    var barber: Barber?
    var adress: String?
    var city: String?
    var longitude: Double?
    var latitude: Double?

    init(orderId: String, userId: String, services: [Service], descriptionOrder: String, date: NSNumber, barber: Barber, adress: String, city: String, longitude: Double, latitude: Double) {
        self.orderId = orderId
        self.userId = userId
        self.services = services
        self.descriptionOrder = descriptionOrder
        self.date = date
        self.barber = barber
        self.adress = adress
        self.city = city
        self.longitude = longitude
        self.latitude = latitude
    }
}
