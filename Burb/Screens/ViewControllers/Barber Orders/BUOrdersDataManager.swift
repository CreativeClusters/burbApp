//
//  BUOrdersDataManager.swift
//  Burb
//
//  Created by Eugene on 30.03.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit

enum BUOrderType {
    case inbox
    case accepted
}

protocol HYUsersRelationsDMProtocol {

    var updatedBlock: (()->())? {get set}
    var startRequestBlock: (()->())? {get set}
    var orderType: BUOrderType {get}
    var previousContentOffset: CGPoint? {get set}
    
    func dataCount() -> Int
}

class BUOrdersDataManager: NSObject {
    
    var updateBlock: (() -> ())?
    
    
    
    
}
