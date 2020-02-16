//
//  BUChooseBarberViewController.swift
//  Burb
//
//  Created by Eugene on 31.01.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit

class BUChooseBarberViewController: UIViewController {
    
    fileprivate enum CellModel {
        case adress
        case date
        case barbers
        case button
    }
    
    
    // MARK: - переписать на barber вместо users
    var users = [User]()
    
    
    fileprivate var models: [CellModel] = [.adress, .date, .barbers, .button]
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Decorator.decorate(self)
        delegating()
        registerCells()
        setupBackBarItem()
        decorateBackground()
    }
    
    private func delegating() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    
    private func registerCells() {
        self.tableView.register(BULabelTableViewCell.nib, forCellReuseIdentifier: BULabelTableViewCell.name)
        self.tableView.register(BUCVTableViewCell.nib, forCellReuseIdentifier: BUCVTableViewCell.name)
        self.tableView.register(BUButtonTableViewCell.nib, forCellReuseIdentifier: BUButtonTableViewCell.name)
        
    }
    
    @objc func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setupBackBarItem() {
        var barButton = UIBarButtonItem(customView: UIImageView(image: UIImage(named: "icBack")))
        barButton = UIBarButtonItem(image: UIImage(named: "icBack"), style: .plain, target: self, action: #selector(goBack))
        barButton.tintColor = UIColor.black
        navigationItem.leftBarButtonItem = barButton
    }
    
    private func decorateBackground() {
       let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundImage.addSubview(blurEffectView)
    }
    
    @objc func handleMainVC() {
        ChooseBarberRouter.shared.goToMainTabber(from: self)
    }
    
}

extension BUChooseBarberViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        switch model {
        case .adress:
            if let cell = self.tableView.dequeueReusableCell(withIdentifier: BULabelTableViewCell.name, for: indexPath) as? BULabelTableViewCell {
                cell.titleLabel.font = UIFont(name: "OpenSans", size: 15)
                cell.titleLabel.textColor = UIColor(red: 50.0/255.0, green: 50.0/255.0, blue: 50.0/255.0, alpha: 1.0)
                cell.backgroundColor = .clear
                return cell
            }
        case .date:
            if let cell = self.tableView.dequeueReusableCell(withIdentifier: BULabelTableViewCell.name, for: indexPath) as? BULabelTableViewCell {
                cell.titleLabel.font = UIFont(name: "OpenSans", size: 15)
                cell.titleLabel.textColor = burbColor
                cell.backgroundColor = .clear
                return cell
            }
        case .barbers:
            if let cell = self.tableView.dequeueReusableCell(withIdentifier: BUCVTableViewCell.name, for: indexPath) as? BUCVTableViewCell {
                cell.collectionView.delegate = self
                cell.collectionView.dataSource = self
                
                
                
                
                
                return cell
            }
        case .button:
            if let cell = self.tableView.dequeueReusableCell(withIdentifier: BUButtonTableViewCell.name, for: indexPath) as? BUButtonTableViewCell {
                cell.button.backgroundColor = burbColor
                cell.button.setTitle("_DONE", for: .normal)
                cell.button.tintColor = .white
                cell.backgroundColor = .clear
                cell.button.addTarget(self, action: #selector(handleMainVC), for: .touchUpInside)
                return cell
            }
        }
        return UITableViewCell.init()
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = models[indexPath.row]
        switch model {
        case .adress:
            return self.tableView.frame.height / 20
        case .date:
            return self.tableView.frame.height / 20
        case .barbers:
            return self.tableView.frame.height * 0.8
        case .button:
            return self.tableView.frame.height / 10
        }
    }
    
}


extension BUChooseBarberViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BarberCollectionViewCell.name, for: indexPath) as? BarberCollectionViewCell {
            return cell
        }
        return UICollectionViewCell.init()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets (top: 0, left: 0, bottom: 0, right: 0)
    }
    
    
}


extension BUChooseBarberViewController {
    fileprivate class Decorator {
        
        private init() {}
        static func decorate(_ vc: BUChooseBarberViewController) {
            vc.title = "_AVAILABLEBARBERS"
            vc.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            vc.navigationController?.navigationBar.shadowImage = UIImage()
            vc.navigationController?.navigationBar.isTranslucent = true
            vc.navigationController?.view.backgroundColor = UIColor.clear
            
        }
        
        
    }
    
    
}
