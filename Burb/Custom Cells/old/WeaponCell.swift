//
//  WeaponCell.swift
//  Burb
//
//  Created by Eugene on 30/09/2019.
//  Copyright © 2019 CC_Eugene. All rights reserved.
//

import UIKit
import RaisePlaceholder

class WeaponCell: UITableViewCell, NiBLoadable, UITextFieldDelegate {

    @IBOutlet weak var weaponTextField: RaisePlaceholder!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
    
    
    
}

