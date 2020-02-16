//
//  PhoneNumberCollectionViewCell.swift
//  Burb
//
//  Created by Eugene on 16.01.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit

class PhoneNumberCollectionViewCell: UICollectionViewCell, NiBLoadable {

    
    
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var securityLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Decorator.decorate(self)
        
    }

    func setPhoneLabelText(text: String) {
        phoneLabel.text = text
    }
    
    func setSecurityLabel(text: String) {
        securityLabel.text = text
    }
    
    
}

extension PhoneNumberCollectionViewCell {
    
    fileprivate class Decorator {
        static func decorate(_ cell: PhoneNumberCollectionViewCell) {
            cell.phoneLabel.textColor = UIColor(red: 50.0/255.0, green: 50.0/255.0, blue: 50.0/255.0, alpha: 1.0)
            cell.securityLabel.textColor = UIColor(red: 50.0/255.0, green: 50.0/255.0, blue: 50.0/255.0, alpha: 0.6)
            cell.phoneLabel.font = UIFont(name: "OpenSans", size: 15)
            cell.securityLabel.font = UIFont(name: "OpenSans", size: 12)
        }
    }
}

