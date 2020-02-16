//
//  BUDatePickerTableViewCell.swift
//  Burb
//
//  Created by Eugene on 30.01.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit

class BUDatePickerTableViewCell: UITableViewCell, NiBLoadable {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        Decorator.decorate(self)
        
        
        
        
    }


    
}

extension BUDatePickerTableViewCell {
    fileprivate class Decorator {
        private init() {}
        
        static func decorate(_ cell: BUDatePickerTableViewCell) {
            cell.selectionStyle = .none
        }
        
        
        
    }
    
    
}
