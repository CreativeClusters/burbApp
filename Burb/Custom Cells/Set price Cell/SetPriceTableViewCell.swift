//
//  SetPriceTableViewCell.swift
//  Burb
//
//  Created by Eugene on 19.02.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit

class SetPriceTableViewCell: UITableViewCell, NiBLoadable {
    
    
    
    @IBOutlet weak var serviceImage: UIImageView!
    @IBOutlet weak var serviceLabel: UILabel!
    @IBOutlet weak var priceTextField: UITextField!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        Decorator.decorate(self)
        
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
    
}
extension SetPriceTableViewCell {
    
    fileprivate class Decorator {
        static func decorate(_ cell: SetPriceTableViewCell) {
            cell.selectionStyle = .none
            cell.serviceLabel.font = UIFont(name: "Open Sans", size: 18)
            cell.priceTextField.font = UIFont(name: "Open Sans", size: 18)
            cell.priceTextField.placeholder = "₽"
        }
    }
}
