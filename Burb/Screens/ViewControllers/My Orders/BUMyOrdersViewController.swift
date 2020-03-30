//
//  BUMyOrdersViewController.swift
//  Burb
//
//  Created by Eugene on 03.02.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit

class BUMyOrdersViewController: UIViewController {
    
    var greyColor = UIColor(red: 241.0/255.0, green: 241.0/255.0, blue: 241.0/255.0, alpha: 1.0)
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        Decorator.decorate(self)
        delegating()
        registerCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.parent?.title = "_MYORDERS"
    }
    
    private func delegating() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }

    private func registerCells() {
        self.collectionView.register(OrderCollectionViewCell.nib, forCellWithReuseIdentifier:OrderCollectionViewCell.name)
    }
    
}

extension BUMyOrdersViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OrderCollectionViewCell.name, for: indexPath) as? OrderCollectionViewCell {
            cell.descriptionTextView.isEditable = false
            
         return cell
        }
        return UICollectionViewCell.init()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.size.width - 20, height: collectionView.frame.size.height / 2 + 20)
    }
     
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets (top: 16, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            MyOrdersRouter.shared.goToChooseBarberViewController(from: self)
    }
    
}


extension BUMyOrdersViewController {
    
    fileprivate class Decorator {
        private init() {}
        static func decorate(_ vc: BUMyOrdersViewController) {
            
            vc.view.backgroundColor = vc.greyColor
            vc.hideKeyboardWhenTappedAround()
            vc.title = "_MYORDERS"
            
            
        }
        
        
    }
    
    
}
