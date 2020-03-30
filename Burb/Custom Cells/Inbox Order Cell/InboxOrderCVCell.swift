//
//  InboxOrderCVCell.swift
//  Burb
//
//  Created by Eugene on 30.03.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit

class InboxOrderCVCell: UICollectionViewCell, NiBLoadable {

    let cellGray = UIColor(red: 50.0/255.0, green: 50.0/255.0, blue: 50.0/255.0, alpha: 0.7)
    let cellBlack = UIColor(red: 50.0/255.0, green: 50.0/255.0, blue: 50.0/255.0, alpha: 1.0)
    
    let cellFont = UIFont(name: "OpenSans", size: 15)
    let cellBigFont = UIFont(name: "OpenSans", size: 21)
    
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var adressLabel: UILabel!
    
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var declineButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        Decorator.decorate(self)
        
    }
    
}

extension InboxOrderCVCell {
    fileprivate class Decorator {
        private init() {}
        static func decorate(_ cell: InboxOrderCVCell) {
            
                cell.circleView.layer.cornerRadius = cell.circleView.frame.height / 2
                cell.circleView.layer.borderColor = burbColor.cgColor
                cell.circleView.layer.borderWidth = 2
            
                cell.avatarImageView.layer.cornerRadius = cell.avatarImageView.frame.height / 2
                
                cell.nameLabel.font = cell.cellBigFont
                cell.dateLabel.font = cell.cellFont
                cell.descTextView.font = cell.cellFont
                cell.adressLabel.font = cell.cellFont
                
                cell.nameLabel.textColor = cell.cellBlack
                cell.dateLabel.textColor = cell.cellGray
                cell.descTextView.textColor = cell.cellBlack
                cell.adressLabel.textColor = cell.cellGray
             
                
                let radius: CGFloat = 10

                cell.contentView.layer.cornerRadius = radius
                // Always mask the inside view
                cell.contentView.layer.masksToBounds = true

                cell.layer.shadowColor = UIColor.black.cgColor
                cell.layer.shadowOffset = CGSize(width: 0, height: 1.0)
                cell.layer.shadowRadius = 3.0
                cell.layer.shadowOpacity = 0.5
                // Never mask the shadow as it falls outside the view
                cell.layer.masksToBounds = false

                // Matching the contentView radius here will keep the shadow
                // in sync with the contentView's rounded shape
                cell.layer.cornerRadius = radius
            
            
        }
        
    }
    
    
}
