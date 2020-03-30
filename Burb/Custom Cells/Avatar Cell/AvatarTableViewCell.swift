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
    
    var percent = 0
    var timer: Timer!
    
    var photoViewClicked: VoidClosure?
    var photoViewUpload: VoidClosure?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Decorator.decorate(self)
        addTargets()
    }

    func setPicture(image: UIImage) {
        avatarImageView.image = image
    }
    
    func addTargets() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        self.avatarImageView.addGestureRecognizer(tap)
    }
    
    @objc func imageViewTapped() {
        photoViewClicked!()
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
            cell.avatarImageView.layer.cornerRadius = cell.avatarImageView.frame.size.width / 2
            cell.avatarImageView.isUserInteractionEnabled = true
        }
    }
}
