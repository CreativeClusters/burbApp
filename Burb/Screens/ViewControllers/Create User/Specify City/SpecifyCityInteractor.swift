//
//  SpecifyCityInteractor.swift
//  Burb
//
//  Created by Eugene on 12.04.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit
import CoreData

final class SpecifyCityInteractor {
    
    static let shared = SpecifyCityInteractor()
    
    func fetchBarberSQL(completion: (BarberSQL) -> ()) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "BarberSQL")
        
        do  {
            let result = try context.fetch(request) as? [BarberSQL]
            for data in (result)! {
                completion(data)
            }
        } catch let error as NSError {
            print("Could not load \(error), \(error.userInfo)")
        }
    }
    
    func saveCityData(with userID: String, city: String) {
            FirestoreManager.barbersReference.document(userID).setData([
                "city":      city
            ])
    }
    
}

