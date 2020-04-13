//
//  BarberPricingInteractor.swift
//  Burb
//
//  Created by Eugene on 13.04.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit
import CoreData

final class BarberPricingInteractor {
    
    static let shared = BarberPricingInteractor()
    
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
    
    func savePricingData(by userID: String, with pricingModel: PricingModel) {
        
        FirestoreManager.pricingModelReference.document(userID).setData([
            "curency":          pricingModel.curency?.rawValue as Any,
            "haircut":          pricingModel.haircut as Any,
            "beardHaircur":     pricingModel.beardHaircur as Any,
            "babyHaircut":      pricingModel.babyHaircut as Any,
            "dangerousShave":   pricingModel.dangerousShave as Any,
            "clipper":          pricingModel.clipper as Any,
            "stacking":         pricingModel.stacking as Any,
        ])
    }
}

