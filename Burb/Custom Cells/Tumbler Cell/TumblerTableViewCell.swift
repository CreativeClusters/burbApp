//
//  TumblerTableViewCell.swift
//  Burb
//
//  Created by Eugene on 06.02.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit

class TumblerTableViewCell: UITableViewCell, NiBLoadable {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var switcher: UISwitch!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        Decorator.decorate(self)
    }

    func setText(text: String) {
        self.label.text = text
    }
    
    func setFont(font: UIFont) {
        self.label.font = font
    }
    
    func setFont(color: UIColor) {
        self.label.textColor = color
    }
 
    
}

extension TumblerTableViewCell {
    fileprivate class Decorator {
        private init() {}
        static func decorate(_ cell: TumblerTableViewCell) {
            cell.selectionStyle = .none
        }
    }
}
