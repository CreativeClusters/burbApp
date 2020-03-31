//
//  ServiceCollectionViewCell.swift
//  Burb
//
//  Created by Eugene on 22.02.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit

class ServiceCollectionViewCell: UICollectionViewCell, NiBLoadable {
    

    @IBOutlet weak var nameTitle: UILabel!
    
    
    override var isSelected: Bool {
        didSet {
            self.isSelected ? setSelected(): setUnselected()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        Decorator.decorate(self)
    }

    func setSelected() {
        self.backgroundColor = burbColor
        self.nameTitle.textColor = .white
    }
    
    func setUnselected() {
        self.backgroundColor = .white
        self.nameTitle.textColor = burbColor
        self.layer.borderColor = burbColor.cgColor
        self.layer.borderWidth = 0.1
    }
    
}

extension ServiceCollectionViewCell {
    fileprivate class Decorator {
        
        private init() {}
        
        static func decorate(_ cell: ServiceCollectionViewCell) {
            cell.nameTitle.font = UIFont(name: "OpenSans", size: 18)
            cell.nameTitle.textColor = burbColor
            cell.layer.borderColor = burbColor.cgColor
            cell.layer.borderWidth = 0.3
            cell.layer.cornerRadius = 16
            cell.layer.masksToBounds = true
            cell.clipsToBounds = true
        }
        
    }
    
    
}
