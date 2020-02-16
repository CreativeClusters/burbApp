//
//  BUTextViewTableViewCell.swift
//  Burb
//
//  Created by Eugene on 08.02.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit

class BUTextViewTableViewCell: UITableViewCell, NiBLoadable {

    @IBOutlet weak var textView: UITextView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Decorator.decorate(self)
    }

    func setText(text: String) {
        self.textView.text = text
    }
    
    func setFont(font: UIFont) {
        self.textView.font = font
    }
    
    func setColor(color: UIColor) {
        self.textView.textColor = color
    }
}

extension BUTextViewTableViewCell {
    fileprivate class Decorator {
        private init() {}
        
        static func decorate(_ cell: BUTextViewTableViewCell) {
            cell.selectionStyle = .none
            
        }
        
    }
    
    
    
}
