//
//  UserAvatarCell.swift
//  Burb
//
//  Created by Eugene on 30/09/2019.
//  Copyright © 2019 CC_Eugene. All rights reserved.
//

import UIKit

class UserAvatarCell: UITableViewCell, NiBLoadable {

    var photoViewClicked: VoidClosure?
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImageView.round(view: avatarImageView)
        selectionStyle = .none
        avatarImageView.isUserInteractionEnabled = true
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

