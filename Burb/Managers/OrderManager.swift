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
    
    func createOrder(from customer: Customer, with order: Order, completion: @escaping ItemClosure<CreatedOrderResult>) {
        
        let orderId = UUID().uuidString
        let order = Order(orderId: orderId, userId: customer.id, services: order.services!, descriptionOrder: order.descriptionOrder!, date: order.date!, barber: order.barber!, adress: order.adress!, city: order.city!, longitude: order.longitude!, latitude: order.latitude!)
        

        FirestoreManager.ordersReference.document(orderId).setData([
            "orderId": order.orderId!,
            "userId": order.userId!,
            "services": order.services!,
            "descriptionOrder": order.descriptionOrder!,
            "date": order.date!,
            "barberId": order.barber!.id,
            "adres": order.adress!,
            "city": order.city!,
            "longitude": order.longitude!,
            "latitude": order.latitude!
        ])
    }
    
    
//    func createPost(from user: User, with text: String? = nil, image: UIImage? = nil, completion: @escaping ItemClosure<CreatedPostResult>) {
//        if let text = text, text.isEmpty, image == nil {
//            completion(.error("Can't create empty post"))
//            return
//        }
//
//        let post = Post(text: text, imageData: image?.jpegData(compressionQuality: 0.5))
//
//        guard let dictionary = post.dictionary else {
//            completion(.error("Post model not dicitionary"))
//            return
//        }
//
//        usersRef.child(user.uid).child(Keys.posts.rawValue).child(post.id).setValue(dictionary) { (error, reference) in
//            if let error = error?.localizedDescription {
//                completion(.error(error))
//                return
//            }
//
//            completion(.success(post))
//        }
//    }
    
    
    
    
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
