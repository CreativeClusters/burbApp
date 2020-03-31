//
//  ChooseBarberInteractor.swift
//  Burb
//
//  Created by Eugene on 26.02.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

final class chooseBarberInteratcor {
    var barbers: [Barber] = []
    
    static let shared = chooseBarberInteratcor()
    
    func fetchBarbers() {
        let barbersReference = FirestoreManager.barbersReference
        barbersReference.getDocuments { (documents, error) in
            if error != nil {
                print("error with getting documents!")
            } else {
                for document in documents!.documents {
                    print(document.data().compactMap { $0.value })
                }
            }
        }
    }
}
