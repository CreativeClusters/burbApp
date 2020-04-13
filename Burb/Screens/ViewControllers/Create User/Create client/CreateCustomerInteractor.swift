//
//  CreateCustomerInteractor.swift
//  Burb
//
//  Created by Eugene on 18.03.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import FirebaseAuth
import FirebaseFirestore

final class CreateCustomerInteractor {
    
    static let shared = CreateCustomerInteractor()
    
    func createCustomer(customer: Customer) {
        
        let defaults = UserDefaults.standard
        let userID = defaults.string(forKey: "userID")
        
        FirestoreManager.customersReference.document(userID!).setData([
            "userId": customer.id,
            "phoneNumber": customer.phoneNumber!,
            "name": customer.name!,
            "avatarReference": customer.avatarReference!
        ])
        guard let customerPhoto = customer.photo else { return }
        StorageManager.shared.uploadCustomerPhoto(photo: customerPhoto, by: customer)
    }
    
    func saveCurrentCustomerSQL(with customer: Customer) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let clearCustomerSQL = NSBatchDeleteRequest(fetchRequest: NSFetchRequest<NSFetchRequestResult>(entityName: "CustomerSQL"))
        
        do {
            try context.execute(clearCustomerSQL)
            try context.save()
        }
        catch {
            print(error)
        }
        
        let currentCustomer = CustomerSQL(entity: CustomerSQL.entity(), insertInto: context)
        let currentCustomerImage = customer.photo?.pngData()
        
        currentCustomer.setValue(customer.id,           forKey: "id")
        currentCustomer.setValue(customer.phoneNumber,  forKey: "phoneNumber")
        currentCustomer.setValue(customer.name,         forKey: "name")
        currentCustomer.setValue(currentCustomerImage,  forKey: "photo")
        
        do {
            try context.save()
        } catch let error as NSError {
            print("could not save \(error), \(error.userInfo)")
        }
    }
    
}
