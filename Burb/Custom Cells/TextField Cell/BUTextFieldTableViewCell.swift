//
//  BUTextFieldTableViewCell.swift
//  Burb
//
//  Created by Eugene on 26.01.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit

class BUTextFieldTableViewCell: UITableViewCell, NiBLoadable {

    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var alertLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Decorator.decorate(self)
    }

    
    func setPlaceholder(text: String) {
        self.textField.placeholder = text
    }

    func setFont(font: UIFont) {
        self.textField.font = font
    }
        
    func setLineHidden() {
        self.lineView.isHidden = true
    }
}

extension BUTextFieldTableViewCell {
    fileprivate class Decorator {
        private init() {}
        
        static func decorate(_ cell: BUTextFieldTableViewCell) {
            cell.selectionStyle = .none
            cell.titleLabel.font = UIFont(name: "OpenSans", size: 14)
            cell.titleLabel.textColor = UIColor(red: 106.0/2550.0, green: 112.0/2550.0, blue: 126.0/2550.0, alpha: 1.0)
            cell.alertLabel.font = UIFont(name: "OpenSans-SemiBold", size: 10)
            cell.alertLabel.textColor = burbColor
        }
    }
}