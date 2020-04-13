//
//  OrderLocationPickerInteractor.swift
//  Burb
//
//  Created by Eugene on 30.03.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit
import CoreData

final class OrderLocationPickerInteractor {
    
    static let shared = OrderLocationPickerInteractor()
    
    func fetchCustomerSQL(completion: (CustomerSQL) -> ()) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CustomerSQL")
        
        do  {
            let result = try context.fetch(request) as? [CustomerSQL]
            for data in (result)! {
                completion(data)
            }
        } catch let error as NSError {
            print("Could not load \(error), \(error.userInfo)")
        }
    }
    
    
    
    
}
