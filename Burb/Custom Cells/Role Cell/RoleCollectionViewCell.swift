//
//  RoleCollectionViewCell.swift
//  Burb
//
//  Created by Eugene on 19.01.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit

class RoleCollectionViewCell: UICollectionViewCell, NiBLoadable {


    @IBOutlet weak var clientView: ClientAnimView!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Decorator.decorate(self)
    }
    
    func setTitle(text: String) {
        roleLabel.text = text
    }
    
    func setDescription(text: String) {
        descriptionTextView.text = text
    }
    
}

extension RoleCollectionViewCell {
    fileprivate class Decorator {
        private init() {}
        
        static func decorate(_ cell: RoleCollectionViewCell) {


            cell.roleLabel.font = UIFont(name: "OpenSans", size: 24)
            cell.roleLabel.tintColor = UIColor(red: 50.0/255.0, green: 50.0/255.0, blue: 50.0/255.0, alpha: 1.0)
            
            cell.descriptionTextView.font = UIFont(name: "OpenSans", size: 15)
            cell.descriptionTextView.tintColor = UIColor(red: 50.0/255.0, green: 50.0/255.0, blue: 50.0/255.0, alpha: 1.0)
        }
    }
}
