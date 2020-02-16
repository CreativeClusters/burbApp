//
//  HidePhoneNumberCell.swift
//  Burb
//
//  Created by Eugene on 01/10/2019.
//  Copyright © 2019 CC_Eugene. All rights reserved.
//

import UIKit

class HidePhoneNumberCell: UITableViewCell, NiBLoadable {

    @IBOutlet weak var hidePhoneNumberSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
