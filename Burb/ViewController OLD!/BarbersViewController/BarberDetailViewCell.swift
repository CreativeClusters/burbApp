//
//  BarberDetailViewCell.swift
//  Burb
//
//  Created by Eugene on 21/09/2019.
//  Copyright © 2019 CC_Eugene. All rights reserved.
//

import UIKit

class BarberDetailViewCell: UICollectionViewCell {

    
    @IBOutlet weak var frameView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameTextField: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("hello my darlings!")
        decorate() 
    }

    
    func decorate() {
        frameView.clipsToBounds = true
        frameView.layer.masksToBounds = true
        frameView.layer.borderColor = burbColor.cgColor
        frameView.layer.borderWidth = 2
        frameView.layer.cornerRadius = frameView.frame.width / 2
        imageView.round(view: imageView)
        statusLabel.applyShadowOnView(statusLabel)
    }
    
}
