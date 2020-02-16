//
//  TwoButtonTableViewCell.swift
//  Burb
//
//  Created by Eugene on 08.02.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit

class TwoButtonTableViewCell: UITableViewCell, NiBLoadable {
    
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var writeButton: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        Decorator.decorate(self)
    }

    func setTextCallButton(text: String) {
        callButton.setTitle(text, for: .normal)
    }
    
    func setTextWriteButton(text: String) {
        writeButton.setTitle(text, for: .normal)
    }
    
}

extension TwoButtonTableViewCell {
    fileprivate class Decorator {
        private init() {}
        
        static func decorate(_ cell: TwoButtonTableViewCell) {
            cell.selectionStyle = .none
            
            cell.callButton.layer.cornerRadius = cell.callButton.frame.height / 2
            cell.callButton.backgroundColor = burbColor
            cell.callButton.titleLabel?.font = UIFont(name: "OpenSans-Semibold", size: 15)
            cell.callButton.tintColor = .white
            
            
            cell.writeButton.layer.cornerRadius = cell.writeButton.frame.height / 2
            cell.writeButton.backgroundColor = burbColor
            cell.writeButton.titleLabel?.font = UIFont(name: "OpenSans-Semibold", size: 15)
            cell.writeButton.tintColor = .white
        }
        
    }
    
    
    
}
