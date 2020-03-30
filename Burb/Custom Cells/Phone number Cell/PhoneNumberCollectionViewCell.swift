//
//  PhoneNumberCollectionViewCell.swift
//  Burb
//
//  Created by Eugene on 16.01.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit
import FlagPhoneNumber

class PhoneNumberCollectionViewCell: UICollectionViewCell, NiBLoadable {

    @IBOutlet weak var phoneLabel: UILabel!

    @IBOutlet weak var phoneNumberTextField: FPNTextField!
    @IBOutlet weak var securityLabel: UILabel!
    
   var textChanged: ItemClosure<String>?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Decorator.decorate(self)
        addTarget()
    }

    func setPhoneLabelText(text: String) {
        phoneLabel.text = text
    }
    
    func setSecurityLabel(text: String) {
        securityLabel.text = text
    }
    
    private func addTarget() {
        phoneNumberTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }
    
    @objc private func textFieldChanged(sender: UITextField){
        if self.phoneNumberTextField == sender {
           textChanged?(sender.text ?? "")
        }
    }

    func setFirstResponder() {
        phoneNumberTextField.resignFirstResponder()
    }
}

extension PhoneNumberCollectionViewCell {
    
    fileprivate class Decorator {
        static func decorate(_ cell: PhoneNumberCollectionViewCell) {
            cell.phoneLabel.textColor = UIColor(red: 50.0/255.0, green: 50.0/255.0, blue: 50.0/255.0, alpha: 1.0)
            cell.securityLabel.textColor = UIColor(red: 50.0/255.0, green: 50.0/255.0, blue: 50.0/255.0, alpha: 0.6)
            cell.phoneLabel.font = UIFont(name: "OpenSans", size: 15)
            cell.securityLabel.font = UIFont(name: "OpenSans", size: 12)
            cell.phoneNumberTextField.font = UIFont(name: "OpenSans", size: 21)
            cell.phoneNumberTextField.textColor = blackburbColor
        }
    }
}

