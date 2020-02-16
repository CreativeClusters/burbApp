//
//  AvatarOrderTableViewCell.swift
//  
//
//  Created by Eugene on 07.02.2020.
//

import UIKit

class AvatarOrderTableViewCell: UITableViewCell, NiBLoadable {
    
    let cellGray = UIColor(red: 50.0/255.0, green: 50.0/255.0, blue: 50.0/255.0, alpha: 0.7)
    let cellBlack = UIColor(red: 50.0/255.0, green: 50.0/255.0, blue: 50.0/255.0, alpha: 1.0)
    let cellFont = UIFont(name: "OpenSans", size: 15)
    let cellBigFont = UIFont(name: "OpenSans", size: 21)
    
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        Decorator.decorate(self)
    }


    
}

extension AvatarOrderTableViewCell {
    fileprivate class Decorator {
        private init() {}
        
        static func decorate(_ cell: AvatarOrderTableViewCell) {
            
            
            cell.selectionStyle = .none
            
            
                cell.circleView.layer.cornerRadius = cell.circleView.frame.height / 2
                cell.circleView.layer.borderColor = burbColor.cgColor
                cell.circleView.layer.borderWidth = 2
            
                cell.avatarImage.layer.cornerRadius = cell.avatarImage.frame.height / 2
                
                cell.nameLabel.font = cell.cellBigFont
                cell.dateLabel.font = cell.cellFont
                
                cell.nameLabel.textColor = cell.cellBlack
                cell.dateLabel.textColor = cell.cellGray
        }
        
        
    }
    
    
}
