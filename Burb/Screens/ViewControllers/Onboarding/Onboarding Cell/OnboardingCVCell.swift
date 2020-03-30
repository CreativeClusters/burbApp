//
//  OnboardingCVCell.swift
//  Burb
//
//  Created by Eugene on 28.03.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit

class OnboardingCVCell: UICollectionViewCell, NiBLoadable {
    
    
    @IBOutlet weak var onbImage: UIImageView!
    @IBOutlet weak var onbFirstLabel: UILabel!
    @IBOutlet weak var onbSecondLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Decorator.decorate(self)
    }
    
    
    func fillWith(data: (UIImage, String, String)) {
        onbImage.image = data.0
        onbFirstLabel.text = data.1.uppercased()
        onbSecondLabel.text = data.2.uppercased()
        
    }
    
    

}

extension OnboardingCVCell {
    fileprivate class Decorator {
        private init() {}
        static func decorate(_ cell: OnboardingCVCell) {
            cell.onbFirstLabel.font = UIFont(name: "OpenSans", size: 24)
            cell.onbSecondLabel.font = UIFont(name: "OpenSans", size: 15)
            
            cell.onbFirstLabel.textColor = blackburbColor
            cell.onbSecondLabel.textColor = blackburbColor
        }
        
    }
    
}
