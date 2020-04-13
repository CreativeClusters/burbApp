//
//  CityAvatarTableViewCell.swift
//  Burb
//
//  Created by Eugene on 09.04.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit

class CityAvatarTableViewCell: UITableViewCell, NiBLoadable {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Decorator.decorate(self)
    }
    
}

extension CityAvatarTableViewCell {
    fileprivate class Decorator {
        private init() {}
        static func decorate(_ cell: CityAvatarTableViewCell) {
            cell.selectionStyle = .none
            cell.avatarImageView.layer.cornerRadius = cell.avatarImageView.frame.height / 2
        }
    }
}
