//
//  CreateBarberInteractor.swift
//  Burb
//
//  Created by Eugene on 25.03.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import FirebaseAuth
import FirebaseFirestore

final class CreateBarberInteractor {
    
    static let shared = CreateBarberInteractor()
    
    func saveBarberData(barber: Barber) {
        
        let defaults = UserDefaults.standard
        let userID = defaults.string(forKey: "userID")
        
        FirestoreManager.barbersReference.document(userID!).setData([
            "userId":           barber.id,
            "phoneNumber":      barber.phoneNumber,
            "name":             barber.name,
            "age":              barber.age,
            "avatarReference":  barber.id,
            "avatarReferenceFull": "\(barber.id)_fullImage"
        ])
        
        guard let barberPhoto = barber.photo else { return }
        guard let fullBarberPhoro = barber.fullPhoto else { return }
        
        StorageManager.shared.uploadBarberPhoto(photo: barberPhoto,by: barber)
        StorageManager.shared.uploadFullBarberPhoto(photo: fullBarberPhoro, by: barber)
    }
    
    
    func saveCurrentBarberSQL(with barber: Barber) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let clearBarberSQL = NSBatchDeleteRequest(fetchRequest: NSFetchRequest<NSFetchRequestResult>(entityName: "BarberSQL"))
        
        do {
            try context.execute(clearBarberSQL)
            try context.save()
        }
        catch {
            print(error)
        }
        
        let currentBarber = BarberSQL(entity: BarberSQL.entity(), insertInto: context)
        let currentBarberImage = barber.photo?.pngData()
        
        currentBarber.setValue(barber.id,           forKey: "id")
        currentBarber.setValue(barber.phoneNumber,  forKey: "phoneNumber")
        currentBarber.setValue(barber.name,         forKey: "name")
        currentBarber.setValue(currentBarberImage,  forKey: "photo")
        
        do {
            try context.save()
        } catch let error as NSError {
            print("could not save \(error), \(error.userInfo)")
        }
    }
}
