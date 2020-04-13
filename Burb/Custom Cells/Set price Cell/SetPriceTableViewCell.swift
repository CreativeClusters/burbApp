//
//  SetPriceTableViewCell.swift
//  Burb
//
//  Created by Eugene on 19.02.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class SetPriceTableViewCell: UITableViewCell, NiBLoadable {
    
    @IBOutlet weak var serviceImage: UIImageView!
    @IBOutlet weak var serviceLabel: UILabel!
    @IBOutlet weak var priceTextField: SkyFloatingLabelTextFieldWithIcon!
    
    var textChanged: ItemClosure<String>?

    override func awakeFromNib() {
        super.awakeFromNib()
        Decorator.decorate(self)
        addTarget()
    }
    
    private func addTarget() {
        priceTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }
    
    @objc private func textFieldChanged(sender: UITextField){
        if self.priceTextField == sender {
           textChanged?(sender.text ?? "")
        }
    }

    func setPicture(image: UIImage) {
        serviceImage.image = image
    }
    
    func setTitle(text: String) {
        serviceLabel.text = text
    }
    
    func setColor(color: UIColor) {
        priceTextField.textColor = color
    }
    
    func setPriceImage(image: UIImage) {
        priceTextField.iconImage = image
    }
    
    
    
}
extension SetPriceTableViewCell {
    
    fileprivate class Decorator {
        static func decorate(_ cell: SetPriceTableViewCell) {
            cell.selectionStyle = .none
            cell.serviceLabel.font = UIFont(name: "Open Sans", size: 18)
            cell.priceTextField.font = UIFont(name: "Open Sans", size: 18)
            cell.priceTextField.iconType = .image
            cell.priceTextField.iconMarginBottom = -3
            cell.priceTextField.selectedIconColor = burbColor
            cell.priceTextField.iconColor = burbColor
        }
    }
}

