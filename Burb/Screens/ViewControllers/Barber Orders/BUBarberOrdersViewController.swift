//
//  BUBarberOrdersViewController.swift
//  Burb
//
//  Created by Eugene on 30.03.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit

class BUBarberOrdersViewController: UIViewController {
    
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Decorator.decorate(self)
        delegating()
        registerCell()
        
    }
     
    private func registerCell() {
        self.collectionView.register(OrderCollectionViewCell.nib, forCellWithReuseIdentifier: OrderCollectionViewCell.name)
        self.collectionView.register(InboxOrderCVCell.nib, forCellWithReuseIdentifier: InboxOrderCVCell.name)
    }

    private func delegating() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    
}

extension BUBarberOrdersViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InboxOrderCVCell.name, for: indexPath) as? InboxOrderCVCell
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.size.width - 20, height: collectionView.frame.size.height / 2 + 20)
    }
     
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets (top: 16, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           // MyOrdersRouter.shared.goToChooseBarberViewController(from: self)
    }
}

extension BUBarberOrdersViewController {
    fileprivate class Decorator {
        private init() {}
        static func decorate(_ vc: BUBarberOrdersViewController) {
            vc.parent?.navigationController?.isNavigationBarHidden = false
            vc.parent?.navigationController?.navigationBar.barTintColor = UIColor.white
            vc.parent?.navigationController?.navigationBar.shadowImage = UIImage()
            
            vc.segmentControl.setTitle("_inbox", forSegmentAt: 0)
            vc.segmentControl.setTitle("_accepted", forSegmentAt: 1)
            vc.segmentControl.backgroundColor = burbColor
            vc.segmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: burbColor], for: .selected)
            vc.segmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
            
            vc.parent?.title = "_ORDERS"
        }
        
    }
    
}

