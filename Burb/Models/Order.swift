//
//  Order.swift
//  Burb
//
//  Created by Eugene on 12/09/2019.
//  Copyright © 2019 CC_Eugene. All rights reserved.
//

import Foundation

class Order: NSObject {

    var orderId:            String
    var customerId:         String
    var services:           [Service]?
    var descriptionOrder:   String
    var date:               Date
    var timestamp:              Date
    var barberId:           String
    var adress:             String
    var city:               String
    var longitude:          Float
    var latitude:           Float

    init?(orderId: String, customerId: String, services: [Service], descriptionOrder: String, date: Date, timestamp: Date, barberId: String, adress: String, city: String, longitude: Float, latitude: Float) {
        
        self.orderId =          orderId
        self.customerId =       customerId
        self.services =         services
        self.descriptionOrder = descriptionOrder
        self.date =             date
        self.barberId =         barberId
        self.adress =           adress
        self.city =             city
        self.longitude =        longitude
        self.latitude =         latitude
        self.timestamp =        timestamp
    }
    
    init?(orderSQL: OrderSQL) {
        self.orderId =          orderSQL.orderId!
        self.customerId =       orderSQL.customerId!
        self.descriptionOrder = orderSQL.descriptions!
        self.date =             orderSQL.date!
        self.barberId =         orderSQL.barberId!
        self.adress =           orderSQL.adress!
        self.city =             orderSQL.city!
        self.longitude =        orderSQL.longitude
        self.latitude =         orderSQL.latitude
        self.timestamp =        orderSQL.timestamp!
    }
    
    func setOrderId(_ id: String) {
        self.orderId = id
    }
    
    
}
