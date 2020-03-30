//
//  BUButtonTableViewCell.swift
//  Burb
//
//  Created by Eugene on 16.01.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit

class BUButtonTableViewCell: UITableViewCell, NiBLoadable {

    var buttonHandler: (() -> ())?
    
    @IBOutlet weak var button: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Decorator.decorate(self)
    }

    func setTitle(text: String){
        self.button.setTitle(text, for: .normal)
    }
    
    func setColor(color: UIColor) {
        self.button.backgroundColor = color
    }
    
    func setTitleColor(color: UIColor) {
        self.button.tintColor = color
    }
    
    func setFont(font: UIFont) {
        self.button.titleLabel?.font = font
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        buttonHandler?()
    }
    
}

extension BUButtonTableViewCell {
    fileprivate class Decorator {
        static func decorate(_ cell: BUButtonTableViewCell) {
            cell.selectionStyle = .none
            cell.button.layer.cornerRadius = cell.button.frame.size.height / 2
        }
    }
}
