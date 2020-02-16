//
//  HeaderTitleView.swift
//  Burb
//
//  Created by Eugene on 06.02.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit

class HeaderTitleView: UIView, NiBLoadable {

    @IBOutlet weak var label: UILabel!
    
    
    func setColor(color: UIColor) {
        self.backgroundColor = color
    }

    func setTitle(text: String) {
        self.label.text = text
    }
    
    func setFont(font: UIFont) {
        self.label.font = font
    }
    
    func setTextColor(color: UIColor) {
        self.label.textColor = color
    }
}

