//
//  TextFieldTableViewCell.swift
//  Burb
//
//  Created by Eugene on 05.02.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell, NiBLoadable {

    @IBOutlet weak var textField: UITextField!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Decorator.decorate(self)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setText(text: String) {
        textField.text = text
    }
    
    func setFont(font: UIFont) {
        textField.font = font
    }
    
    func setTextColor(color: UIColor) {
        textField.textColor = color
    }
    
}

extension TextFieldTableViewCell {
    fileprivate class Decorator {
        private init() {}
        
        static func decorate(_ cell: TextFieldTableViewCell) {
            
            cell.selectionStyle = .none
            
        }
        
    }
    
}
