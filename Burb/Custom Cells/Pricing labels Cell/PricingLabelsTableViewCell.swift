//
//  PricingLabelsTableViewCell.swift
//  Burb
//
//  Created by Eugene on 20.02.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit

class PricingLabelsTableViewCell: UITableViewCell, NiBLoadable {
    
    @IBOutlet weak var serviceLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Decorator.decorate(self)
        
        
    }

    func setText(serviceText: String, priceText: String) {
        serviceLabel.text = serviceText
        priceLabel.text = priceText
    }
    
    func setImage(image: UIImage) {
        
    }
}

extension PricingLabelsTableViewCell {
    
    fileprivate class Decorator {
        static func decorate(_ cell: PricingLabelsTableViewCell) {
            cell.selectionStyle = .none
            cell.serviceLabel.font = UIFont(name: "Open Sans", size: 14)
            cell.priceLabel.font = UIFont(name: "Open Sans", size: 14)
            cell.priceLabel.textColor = UIColor(red: 50.0/255.0, green: 50.0/255.0, blue: 50.0/255.0, alpha: 0.7)
            cell.serviceLabel.textColor = UIColor(red: 50.0/255.0, green: 50.0/255.0, blue: 50.0/255.0, alpha: 0.7)
        }
    }
}
