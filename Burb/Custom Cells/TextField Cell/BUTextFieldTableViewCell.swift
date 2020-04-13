//
//  BUTextFieldTableViewCell.swift
//  Burb
//
//  Created by Eugene on 26.01.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class BUTextFieldTableViewCell: UITableViewCell, NiBLoadable {


    @IBOutlet weak var textField: SkyFloatingLabelTextField!
    
    var textChanged: ItemClosure<String>?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Decorator.decorate(self)
        addTargets()
    }

    
    func setPlaceholder(text: String) {
        self.textField.placeholder = text
    }

    func setFont(font: UIFont) {
        self.textField.font = font
    }
        
    
    private func addTargets() {
        textField.addTarget(self, action: #selector(nameSurnameTextFieldChanged), for: .editingChanged)
    }
    
    @objc private func nameSurnameTextFieldChanged(sender: UITextField){
        textChanged?(sender.text ?? "")
    }
    
}

extension BUTextFieldTableViewCell {
    fileprivate class Decorator {
        private init() {}
        
        static func decorate(_ cell: BUTextFieldTableViewCell) {
            cell.selectionStyle = .none
            cell.textField.textAlignment = .center
            cell.textField.titleLabel.textAlignment = .center
            cell.textField.tintColor =  burbColor// the color of the blinking cursor
            cell.textField.textColor = .darkGray
            cell.textField.lineColor = burbColor
            cell.textField.selectedTitleColor = blackburbColor
            cell.textField.selectedLineColor = burbColor

            cell.textField.lineHeight = 2.0 // bottom line height in points
            cell.textField.selectedLineHeight = 2.0
        }
    }
}
