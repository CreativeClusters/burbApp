//
//  BUDetailOrderViewController.swift
//  Burb
//
//  Created by Eugene on 07.02.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit

class BUDetailOrderViewController: UIViewController {
    
    
    fileprivate enum CellModel {
        case avatarHeader
        case descriptions
        case buttons
        case adress
        case mapView
        case cancelOrder
        
    }
    
    fileprivate enum HeaderModel {
        
        typealias CellType = CellModel
        case avatarHeader
        case descriptions
        case buttons
        case adress
        case mapView
        case cancelOrder
        
        var cellModels: [BUDetailOrderViewController.CellModel] {
            switch self {
            case .avatarHeader: return [.avatarHeader]
            case .descriptions: return [.descriptions]
            case .buttons: return [.buttons]
            case .adress: return [.adress]
            case .mapView: return [.mapView]
            case .cancelOrder: return [.cancelOrder]
            }
        }
    }
    
    private let HeaderModels: [HeaderModel] = [.avatarHeader, .descriptions, .buttons, .adress, .mapView, .cancelOrder]
    private var models: [CellModel] = [.avatarHeader, .descriptions, .buttons, .adress, .mapView, .cancelOrder]
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Decorator.decorate(self)
        delegating()
        registerCells()
        setupBackBarItem()
        
    }
    
    private func delegating() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    private func registerCells() {
        self.tableView.register(AvatarOrderTableViewCell.nib, forCellReuseIdentifier: AvatarOrderTableViewCell.name)
        self.tableView.register(BUTextViewTableViewCell.nib, forCellReuseIdentifier: BUTextViewTableViewCell.name)
        self.tableView.register(TwoButtonTableViewCell.nib, forCellReuseIdentifier: TwoButtonTableViewCell.name)
        self.tableView.register(BULabelTableViewCell.nib, forCellReuseIdentifier: BULabelTableViewCell.name)
        self.tableView.register(MapViewTableViewCell.nib, forCellReuseIdentifier: MapViewTableViewCell.name)
        self.tableView.register(BUButtonTableViewCell.nib, forCellReuseIdentifier: BUButtonTableViewCell.name)
    }
    
    private func setupBackBarItem() {
        var barButton = UIBarButtonItem(customView: UIImageView(image: UIImage(named: "icBack")))
        barButton = UIBarButtonItem(image: UIImage(named: "icBack"), style: .plain, target: self, action: #selector(goBack))
        barButton.tintColor = UIColor.black
        navigationItem.leftBarButtonItem = barButton
    }
    
    
    @objc private func goBack() {
        navigationController?.popViewController(animated: true)
    }
}


extension BUDetailOrderViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HeaderModels[section].cellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = HeaderModels[indexPath.section].cellModels[indexPath.row]
        switch model {
        case .avatarHeader:
            if let cell = tableView.dequeueReusableCell(withIdentifier: AvatarOrderTableViewCell.name, for: indexPath)  as? AvatarOrderTableViewCell {
                
                
                return cell
            }
        case .descriptions:
            if let cell = tableView.dequeueReusableCell(withIdentifier: BUTextViewTableViewCell.name, for: indexPath)  as? BUTextViewTableViewCell {
                cell.textView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                cell.setFont(font: UIFont(name: "OpenSans", size: 15)!)
                cell.setColor(color: blackburbColor)
                cell.textView.isEditable = false
                cell.setText(text: "I would like beard, moustache, hair cut. Also I need cleaning after cut. Thnx")
                return cell
            }
        case .buttons:
            if let cell = tableView.dequeueReusableCell(withIdentifier: TwoButtonTableViewCell.name, for: indexPath)  as? TwoButtonTableViewCell {
                cell.setTextCallButton(text: "CALL  JIM")
                cell.setTextWriteButton(text: "WRITE JIM")
                return cell
            }
        case .adress:
            if let cell = tableView.dequeueReusableCell(withIdentifier: BULabelTableViewCell.name, for: indexPath)  as? BULabelTableViewCell {
                cell.setText(text: "Zvenigorodskoe Ave, 15")
                cell.setFont(font: UIFont(name: "OpenSans", size: 15)!)
                cell.setTextColor(color: grayBurbColor)
                cell.titleLabel.textAlignment = .left
                return cell
            }
        case .mapView:
            if let cell = tableView.dequeueReusableCell(withIdentifier: MapViewTableViewCell.name, for: indexPath)  as? MapViewTableViewCell {
                
                
                return cell
            }
        case .cancelOrder:
            if let cell = tableView.dequeueReusableCell(withIdentifier: BUButtonTableViewCell.name, for: indexPath)  as? BUButtonTableViewCell {
                cell.setFont(font: UIFont(name: "OpenSans-Semibold", size: 15)!)
                cell.setTitle(text: "_CANCELTHEORDER")
                cell.setTitleColor(color: burbColor)
                return cell
            }
        }
        return UITableViewCell.init()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = HeaderModels[indexPath.section].cellModels[indexPath.row]
        switch model {
        case .avatarHeader:
            return self.tableView.frame.height / 8
        case .descriptions:
            return self.tableView.frame.height / 8
        case .buttons:
            return self.tableView.frame.height / 10
        case .adress:
            return self.tableView.frame.height / 12
        case .mapView:
            return self.tableView.frame.height * 0.47
        case .cancelOrder:
            return self.tableView.frame.height / 10
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let headerModels = HeaderModels[section]
        
        switch headerModels {
        case .avatarHeader:
            return 0
        case .descriptions:
            return 0
        case .buttons:
            return 0
        case .adress:
            return 0
        case .mapView:
            return 2
        case .cancelOrder:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
         let headerModels = HeaderModels[section]
        switch headerModels {
        case .avatarHeader:
            return nil
        case .descriptions:
            return nil
        case .buttons:
            return nil
        case .adress:
            return nil
        case .mapView:
            let view = HeaderView.loadFromNib()
            view.backgroundColor = burbColor
            return view
        case .cancelOrder:
            return nil
        }
    }
    
    
}


extension BUDetailOrderViewController {
    fileprivate class Decorator {
        private init() {}
        
        static func decorate(_ vc:BUDetailOrderViewController) {
            vc.hideKeyboardWhenTappedAround()
            vc.title = "_CURRENTORDER"
        }
        
    }
    
}
