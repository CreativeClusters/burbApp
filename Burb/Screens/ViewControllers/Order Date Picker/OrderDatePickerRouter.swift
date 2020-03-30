//
//  ConfirmTimeRouter.swift
//  Burb
//
//  Created by Eugene on 05.02.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//
import UIKit


final class OrderDatePickerRouter {
    
    static let shared = OrderDatePickerRouter()
    
    private init() {}
    
    func goToChooseBarberViewController(from source: UIViewController) {
        let destinationVC = BUChooseBarberViewController()
            source.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
}
