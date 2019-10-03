//
//  BarberViewCell.swift
//  Burb
//
//  Created by Eugene on 29/08/2019.
//  Copyright © 2019 CC_Eugene. All rights reserved.
//

import UIKit

class BarberViewCell: UICollectionViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!    
    @IBOutlet weak var nameTextView: UITextView!
    @IBOutlet weak var frameView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        frameView.clipsToBounds = true
        frameView.layer.masksToBounds = true
        frameView.layer.borderColor = burbColor.cgColor
        frameView.layer.borderWidth = 3
        frameView.layer.cornerRadius = self.frameView.frame.width / 2
        
        
        
        
    }
    
}



