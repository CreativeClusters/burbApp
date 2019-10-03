//
//  ReminderCell.swift
//  Burb
//
//  Created by Eugene on 30/09/2019.
//  Copyright © 2019 CC_Eugene. All rights reserved.
//

import UIKit

class ReminderCell: UITableViewCell, NiBLoadable {

    @IBOutlet weak var hoursButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        hoursButton.setTitle("24 h before", for: .normal)
        hoursButton.centerTextAndImage(spacing: 300.0)
        hoursButton.setTitleColor(UIColor(red: 50.0/255.0, green: 50.0/255.0, blue: 50.0/255.0, alpha: 0.6), for: .normal)
        hoursButton.titleLabel?.font = UIFont(name: "OpenSans", size: 15.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}

extension UIButton {
    func centerTextAndImage(spacing: CGFloat) {
        let insetAmount = spacing / 2
        imageEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: -insetAmount)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: -insetAmount)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
