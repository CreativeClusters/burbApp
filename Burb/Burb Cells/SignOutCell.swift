//
//  SignOutCell.swift
//  Burb
//
//  Created by Eugene on 01/10/2019.
//  Copyright © 2019 CC_Eugene. All rights reserved.
//

import UIKit

class SignOutCell: UITableViewCell, NiBLoadable {

    @IBOutlet weak var signOutButton: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
