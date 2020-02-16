//
//  LogoTableViewCell.swift
//  Burb
//
//  Created by Eugene on 13.01.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit

class LogoTableViewCell: UITableViewCell, NiBLoadable {

    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var logoLabel: UILabel!
    @IBOutlet weak var logoBurbImage: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Decorator.decorate(self)
    }
    
    func setLabelFont(font: UIFont) {
        logoLabel.font = font
    }
    
    
    func setTitle(text: String) {
        self.logoLabel.text = text
    }
}

extension LogoTableViewCell {
    fileprivate class Decorator {
        static func decorate(_ cell: LogoTableViewCell) {
            cell.selectionStyle = .none
        }
    }
    
}
