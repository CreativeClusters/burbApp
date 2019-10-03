//
//  CommonSettingsLabelCell.swift
//  Burb
//
//  Created by Eugene on 30/09/2019.
//  Copyright © 2019 CC_Eugene. All rights reserved.
//

import UIKit

class CommonSettingsLabelCell: UITableViewCell, NiBLoadable {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
