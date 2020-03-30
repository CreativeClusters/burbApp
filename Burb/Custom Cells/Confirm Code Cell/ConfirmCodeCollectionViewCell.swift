//
//  ConfirmCodeCollectionViewCell.swift
//  Burb
//
//  Created by Eugene on 10.02.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit

class ConfirmCodeCollectionViewCell: UICollectionViewCell, NiBLoadable {


    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var securityLabel: UILabel!
    
   var textChanged: ItemClosure<String>?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Decorator.decorate(self)
        addTarget()
    }

    
    func setCodeLabelText(text: String) {
        codeLabel.text = text
    }
    
    func setSecurityLabel(text: String) {
        securityLabel.text = text
    }
    
    private func addTarget() {
        codeTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }
    
    @objc private func textFieldChanged(sender: UITextField){
        if self.codeTextField == sender {
           textChanged?(sender.text ?? "")
        }
    }
}


extension ConfirmCodeCollectionViewCell {
    
    fileprivate class Decorator {
        static func decorate(_ cell: ConfirmCodeCollectionViewCell) {
            cell.codeLabel.textColor = UIColor(red: 50.0/255.0, green: 50.0/255.0, blue: 50.0/255.0, alpha: 1.0)
            cell.securityLabel.textColor = UIColor(red: 50.0/255.0, green: 50.0/255.0, blue: 50.0/255.0, alpha: 0.6)
            cell.codeLabel.font = UIFont(name: "OpenSans", size: 15)
            cell.securityLabel.font = UIFont(name: "OpenSans", size: 12)
            cell.codeTextField.font = UIFont(name: "OpenSans", size: 21)
            cell.codeTextField.textColor = blackburbColor
        }
    }
}
