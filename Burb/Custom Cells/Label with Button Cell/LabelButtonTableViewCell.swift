//
//  LabelButtonTableViewCell.swift
//  Burb
//
//  Created by Eugene on 06.02.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit

class LabelButtonTableViewCell: UITableViewCell, NiBLoadable {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Decorator.decorate(self)
    }

    func setLabelTextLabel(text: String) {
        label.text = text
    }
    
    func setLabelTextColor(color: UIColor) {
        label.textColor = color
    }
    
    func setlabelTextFont(font: UIFont) {
        label.font = font
    }
    
    func setButtonTextLabel(text: String) {
        button.setTitle(text, for: .normal)
    }
    
    func setButtonTextColor(color: UIColor) {
        button.tintColor = color
    }
    
    func setButtonTextFont(font: UIFont) {
        button.titleLabel?.font = font
    }
    
    
}

extension LabelButtonTableViewCell {
    
    fileprivate class Decorator {
        private init() {}
        static func decorate(_ cell: LabelButtonTableViewCell) {
            cell.selectionStyle = .none
        }

    }
    
}
