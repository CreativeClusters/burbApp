//
//  MyOrdersRouter.swift
//  Burb
//
//  Created by Eugene on 07.02.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit

final class MyOrdersRouter {
    
    static let shared = MyOrdersRouter()
    
    private init() {}
    
    func goToChooseBarberViewController(from source: UIViewController) {
        let destinationVC = BUDetailOrderViewController()
            source.navigationController?.pushViewController(destinationVC, animated: true)
    }
}
