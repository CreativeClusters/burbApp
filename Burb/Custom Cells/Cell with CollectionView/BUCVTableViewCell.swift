//
//  BUCVTableViewCell.swift
//  Burb
//
//  Created by Eugene on 31.01.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit

class BUCVTableViewCell: UITableViewCell, NiBLoadable {

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Decorator.decorate(self)
        collectionView.register(BarberCollectionViewCell.nib, forCellWithReuseIdentifier: BarberCollectionViewCell.name)
    }

    
}


extension BUCVTableViewCell {
    fileprivate class Decorator {
        private init() {}
        static func decorate(_ cell: BUCVTableViewCell) {
            cell.selectionStyle = .none
        }
    }
}

