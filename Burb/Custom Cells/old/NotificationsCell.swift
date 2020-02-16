//
//  NotificationsCell.swift
//  Burb
//
//  Created by Eugene on 01/10/2019.
//  Copyright © 2019 CC_Eugene. All rights reserved.
//

import UIKit

class NotificationsCell: UITableViewCell, NiBLoadable {

    @IBOutlet weak var recieveNotificationsSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    
}
