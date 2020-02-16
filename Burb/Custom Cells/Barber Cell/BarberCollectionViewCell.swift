//
//  BarberCollectionViewCell.swift
//  Burb
//
//  Created by Eugene on 31.01.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit

class BarberCollectionViewCell: UICollectionViewCell, NiBLoadable {

    let cellWhite = UIColor(red: 249.0/255.0, green: 248.0/255.0, blue: 248.0/255.0, alpha: 1.0)
    let cellBlack = UIColor(red: 50.0/255.0, green: 50.0/255.0, blue: 50.0/255.0, alpha: 1.0)
    let cellFont = UIFont(name: "OpenSans", size: 15)
    
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var verticalSeparatorView: UIView!
    
    @IBOutlet weak var genderTitleLabel: UILabel!
    @IBOutlet weak var weaponTitleLabel: UILabel!
    @IBOutlet weak var ageTitleLabel: UILabel!
    @IBOutlet weak var educationTitleLabel: UILabel!
    @IBOutlet weak var philosophyTitleLabel: UILabel!

    
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var weaponLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var educationLabel: UITextView!
    @IBOutlet weak var philosophyLabel: UITextView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Decorator.decorate(self)
    }

}


extension BarberCollectionViewCell {
    fileprivate class Decorator {
        private init() {}
        static func decorate(_ cell: BarberCollectionViewCell) {
            
            
            cell.circleView.layer.cornerRadius = cell.circleView.frame.height / 2
            cell.avatarImage.layer.cornerRadius = cell.avatarImage.frame.height / 2
            cell.circleView.layer.borderColor = burbColor.cgColor
            cell.circleView.layer.borderWidth = 2
            cell.nameLabel.font = UIFont(name: "OpenSans", size: 24)
            cell.nameLabel.textColor = cell.cellBlack
            
            cell.genderTitleLabel.font = cell.cellFont
            cell.weaponTitleLabel.font = cell.cellFont
            cell.ageTitleLabel.font = cell.cellFont
            cell.educationTitleLabel.font = cell.cellFont
            cell.philosophyTitleLabel.font = cell.cellFont
            
            cell.genderLabel.font = cell.cellFont
            cell.weaponLabel.font = cell.cellFont
            cell.ageLabel.font = cell.cellFont
            cell.educationLabel.font = cell.cellFont
            cell.philosophyLabel.font = cell.cellFont
            
            
            cell.genderTitleLabel.textColor = cell.cellWhite
            cell.weaponTitleLabel.textColor = cell.cellWhite
            cell.ageTitleLabel.textColor = cell.cellWhite
            cell.educationTitleLabel.textColor = cell.cellWhite
            cell.philosophyTitleLabel.textColor = cell.cellWhite
            
            cell.genderLabel.textColor = cell.cellWhite
            cell.weaponLabel.textColor = cell.cellWhite
            cell.ageLabel.textColor = cell.cellWhite
            cell.educationLabel.textColor = cell.cellWhite
            cell.philosophyLabel.textColor = cell.cellWhite
            
            cell.educationLabel.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            cell.philosophyLabel.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            
            cell.separatorView.layer.cornerRadius = cell.separatorView.frame.height / 2
            cell.verticalSeparatorView.isHidden = true
            
        }
    }
}

