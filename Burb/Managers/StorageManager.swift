//
//  StorageManager.swift
//  Burb
//
//  Created by Eugene on 24.03.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit
import FirebaseStorage


class StorageManager {
    
    static let shared = StorageManager()
    
    private init() {}
    
    
    private let storageReference = Storage.storage().reference()
    
    func uploadCustomerPhoto(photo: UIImage, by model: Customer, closure: VoidClosure? = nil) {
        
        guard let data = photo.jpegData(compressionQuality: 0.5) else {
            return
        }
        storageReference.child(Keys.cutomerAvatars.rawValue).child(model.id).putData(data, metadata: nil) { (metadata, error) in
            closure?()
        }
    }
    
    func loadCustomerAvatarUrl(for model: Customer, closure: @escaping OptionalItemClosure<URL>) {
        storageReference.child(Keys.cutomerAvatars.rawValue).child(model.id).downloadURL { (url, error) in
            closure(url)
        }
    }
    
    func uploadBarberPhoto(photo: UIImage, by model: Barber, closure: VoidClosure? = nil) {
        guard let data = photo.jpegData(compressionQuality: 0.5) else {
            return
        }
        storageReference.child(Keys.barberAvatars.rawValue).child(model.id).putData(data, metadata: nil) { (metadata, error) in
            closure?()
        }
    }
    
    func uploadFullBarberPhoto(photo: UIImage, by model: Barber, closure: VoidClosure? = nil) {
        guard let data = photo.jpegData(compressionQuality: 0.5) else {
            return
        }
        storageReference.child(Keys.barberAvatars.rawValue).child("\(model.id)_fullImage").putData(data, metadata: nil) { (metadata, error) in
            closure?()
        }
    }
    
    func loadBarberAvatarUrl(for model: Customer, closure: @escaping OptionalItemClosure<URL>) {
        storageReference.child(Keys.barberAvatars.rawValue).child(model.id).downloadURL { (url, error) in
            closure(url)
        }
    }
    
    func loadFullBarberAvatarUrl(for model: Customer, closure: @escaping OptionalItemClosure<URL>) {
        storageReference.child(Keys.barberAvatars.rawValue).child("\(model.id)_fullImage").downloadURL { (url, error) in
            closure(url)
        }
    }
    
}


extension StorageManager {
    private enum Keys: String {
        case cutomerAvatars
        case barberAvatars
    }
    
}
