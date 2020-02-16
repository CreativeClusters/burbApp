//
//  BULabelTableViewCell.swift
//  Burb
//
//  Created by Eugene on 29.01.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit

class BULabelTableViewCell: UITableViewCell, NiBLoadable {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Decorator.decorate(self)
      
    }

    func setText(text: String) {
        self.titleLabel.text = text
    }
    
    func setFont(font: UIFont) {
        self.titleLabel.font = font
    }
    func setTextColor(color: UIColor) {
        self.titleLabel.textColor = color
    }
    
}

extension BULabelTableViewCell {
    fileprivate class Decorator {
        private init() {}
        static func decorate(_ cell: BULabelTableViewCell) {
            cell.selectionStyle = .none
        }
        
    }
    
}
