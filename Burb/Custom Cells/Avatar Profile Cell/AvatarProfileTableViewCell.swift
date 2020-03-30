//
//  AvatarProfileTableViewCell.swift
//  Burb
//
//  Created by Eugene on 06.02.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit

class AvatarProfileTableViewCell: UITableViewCell, NiBLoadable {
    
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var avatarImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Decorator.decorate(self)
    }


    
}

extension AvatarProfileTableViewCell {
    
    fileprivate class Decorator {
        
        private init() {}
        
        static func decorate(_ cell: AvatarProfileTableViewCell) {
            cell.selectionStyle = .none
            cell.circleView.layer.cornerRadius = cell.circleView.frame.size.width / 2
            cell.circleView.layer.borderColor = burbColor.cgColor
            cell.circleView.layer.borderWidth = 2
            cell.avatarImage.isUserInteractionEnabled = true
        }
    }
}
