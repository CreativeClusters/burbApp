//
//  OrderManager.swift
//  Burb
//
//  Created by Eugene on 05.04.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore


final class OrderManager: FirestoreManager {
    
    static let shared = OrderManager()
    
    func createOrder(from customer: Customer, with barber: Barber, in order: Order, completion: @escaping ItemClosure<CreatedOrderResult>) {
        
        let orderId = UUID().uuidString
        
        let order = Order(orderId: orderId, customerId: customer.id, services: order.services!, descriptionOrder: order.descriptionOrder, date: order.date, timestamp: order.timestamp, barberId: barber.id, adress: order.adress, city: order.city, longitude: order.longitude, latitude: order.latitude)
        
        FirestoreManager.ordersReference.document(orderId).setData([
            "orderId":              order?.orderId as Any,
            "userId":               order?.customerId as Any,
            "services":             order?.services as Any,
            "descriptionOrder":     order?.descriptionOrder as Any,
            "date":                 order?.date as Any,
            "timestamp":            order?.timestamp as Any,
            "barberId":             order?.barberId as Any,
            "adress":               order?.adress as Any,
            "city":                 order?.city as Any,
            "longitude":            order?.longitude as Any,
            "latitude":             order?.latitude as Any
        ]) { (error) in
            if let error = error?.localizedDescription {
                completion(.error(error))
                return
            }
            completion(.success(order!))
        }
    }
}


extension OrderManager {
    fileprivate enum Keys: String {
        case orders
    }
    
    enum LoadedOrdersResult {
        case success([Order])
        case error(String)
    }
    
    enum CreatedOrderResult {
        case success(Order)
        case error(String)
    }
}
