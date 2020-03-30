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
    
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout! {
        didSet {
            collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Decorator.decorate(self)
        collectionView.register(BarberCollectionViewCell.nib, forCellWithReuseIdentifier: BarberCollectionViewCell.name)
        collectionView.register(ServiceCollectionViewCell.nib, forCellWithReuseIdentifier: ServiceCollectionViewCell.name)
        selfSizing()
    }

    
    func selfSizing() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.leftAnchor.constraint(equalTo: leftAnchor),
            contentView.rightAnchor.constraint(equalTo: rightAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    
}


extension BUCVTableViewCell {
    fileprivate class Decorator {
        private init() {}
        static func decorate(_ cell: BUCVTableViewCell) {
            cell.selectionStyle = .none
            cell.collectionView.allowsMultipleSelection = true
        }
    }
}

