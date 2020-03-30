//
//  Service.swift
//  Burb
//
//  Created by Eugene on 22.02.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import Foundation

class Service: NSObject {
    var serviceId: String?
    var serviceName: String?
    
    init(serviceId: String, serviceName: String) {
        self.serviceId = serviceId
        self.serviceName = serviceName
     }
}
