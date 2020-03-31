//
//  CreateBarberInteractor.swift
//  Burb
//
//  Created by Eugene on 25.03.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

final class CreateBarberInteractor {
    
    static let shared = CreateBarberInteractor()
    
    func createBarber(barber: Barber) {
        
        let defaults = UserDefaults.standard
        let userID = defaults.string(forKey: "userID")
        
        FirestoreManager.barbersReference.document(userID!).setData([
            "userId": barber.id,
            "phoneNumber": barber.phoneNumber!,
            "name": barber.name!,
            "avatarReference": barber.id,
            "avatarReferenceFull": "\(barber.id)_fullImage"
        ])
        guard let barberPhoto = barber.photo else { return }
        guard let fullBarberPhoro = barber.fullPhoto else { return }
        StorageManager.shared.uploadBarberPhoto(photo: barberPhoto,by: barber)
        StorageManager.shared.uploadFullBarberPhoto(photo: fullBarberPhoro, by: barber)
    }
}
