//
//  BUChooseRoleViewController.swift
//  Burb
//
//  Created by Eugene on 19.01.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit

class BUChooseRoleViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var isfirstTimeTransform:Bool = true
    
    let activeBarberImage = UIImage(named: "barber_a")
    let deactiveBarberImage = UIImage(named: "barber_b")
    let activeClientImage = UIImage(named: "client_a")
    let deactiveClientImage = UIImage(named: "client_b")
    
    fileprivate enum CellModel {
        case client
        case barber
    }
    
    private let model: [CellModel] = [.client, .barber]
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Decorator.decorate(self)
        delegating()
        registerCells()
        addRightBarButton()
        setupBackBarItem()
    }
    
    private func delegating() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func registerCells() {
        collectionView.register(RoleCollectionViewCell.nib, forCellWithReuseIdentifier: RoleCollectionViewCell.name)
    }
    
    @objc private func handleCreateUser() {
        ChooseRoleRouter.shared.goToCreateUserVC(from: self)
    }
    
    private func addRightBarButton() {
        let rightBarBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleCreateUser))
        rightBarBarButton.tintColor = burbColor
        navigationItem.rightBarButtonItem = rightBarBarButton
    }
    
    @objc private func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setupBackBarItem() {
        var barButton = UIBarButtonItem(customView: UIImageView(image: UIImage(named: "icBack")))
        barButton = UIBarButtonItem(image: UIImage(named: "icBack"), style: .plain, target: self, action: #selector(goBack))
        barButton.tintColor = UIColor.black
        navigationItem.leftBarButtonItem = barButton
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let models = model[indexPath.row]
        switch models {
        case .client:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RoleCollectionViewCell.name, for: indexPath) as? RoleCollectionViewCell {
                cell.setTitle(text: "Client")
                cell.setActive(image: deactiveClientImage!, borderColor: UIColor.clear.cgColor)
                cell.setDescription(text: "I would like to look sharp")
                return cell
            }
        case .barber:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RoleCollectionViewCell.name, for: indexPath) as? RoleCollectionViewCell {
                cell.setActive(image: deactiveBarberImage!, borderColor: UIColor.clear.cgColor)
                cell.setTitle(text: "Barber")
                cell.setDescription(text: "I can make you look real cool")
                return cell
            }
            
        }
        return UICollectionViewCell.init()
    }
    
    
    
    //   MARK: - for switching cells
       func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        

        let centerPoint = CGPoint(x: self.collectionView.center.x, y: self.collectionView.center.y)

        let collectionViewCenterPoint = self.view.convert(centerPoint, to: collectionView)

        let indexPath = collectionView.indexPathForItem(at: collectionViewCenterPoint)

        let cell: RoleCollectionViewCell = collectionView.cellForItem(at: indexPath!) as! RoleCollectionViewCell
        
        let models = model[indexPath!.item]
        
        switch models {

        case .client:
            cell.setActive(image: activeClientImage!, borderColor: burbColor.cgColor)
        case .barber:
            cell.setActive(image: activeBarberImage!, borderColor: burbColor.cgColor)
        }
        
    }
    

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.size.width - self.collectionView.frame.size.width / 2.5, height: self.collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets (top: 0, left: 100, bottom: 0, right: 100)
    }
    
}


extension BUChooseRoleViewController {
    fileprivate class Decorator {
        private init() {}
        static func decorate(_ vc: BUChooseRoleViewController) {
            vc.collectionView.bounces = false
            vc.title = "_CHOOSEYOURROLE"
        }
    }
    
    
}
