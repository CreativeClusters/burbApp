//
//  AvatarTableViewCell.swift
//  Burb
//
//  Created by Eugene on 26.01.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit

class AvatarTableViewCell: UITableViewCell, NiBLoadable {
    
    
    
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    var photoViewClicked: VoidClosure?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Decorator.decorate(self)
    }

    func setPicture(image: UIImage) {
        avatarImageView.image = image
    }
    
}

extension AvatarTableViewCell {
    
    fileprivate class Decorator {
        
        private init() {}
        
        static func decorate(_ cell: AvatarTableViewCell) {
            cell.selectionStyle = .none
            cell.circleView.layer.cornerRadius = cell.circleView.frame.size.width / 2
            cell.circleView.layer.borderColor = burbColor.cgColor
            cell.circleView.layer.borderWidth = 2
            cell.avatarImageView.isUserInteractionEnabled = true
        }
    }
}

