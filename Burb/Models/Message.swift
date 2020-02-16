//
//  Message.swift
//  Burb
//
//  Created by Eugene on 03/09/2019.
//  Copyright © 2019 CC_Eugene. All rights reserved.
//

import UIKit
import FirebaseAuth

class Message: NSObject {    
    var fromId: String?
    var text: String?
    var timestamp: NSNumber?
    var toId: String?
    
    init(dictionary: [String: Any]) {
        self.fromId = dictionary["fromId"] as? String
        self.text = dictionary["text"] as? String
        self.timestamp = dictionary["timestamp"] as? NSNumber
        self.toId = dictionary["toId"] as? String
    }
    
    func chatPartnerId() -> String? {
        return fromId == Auth.auth().currentUser?.uid ? toId : fromId
    }
}
