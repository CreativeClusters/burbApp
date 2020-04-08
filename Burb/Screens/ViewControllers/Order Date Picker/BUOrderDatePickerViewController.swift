//
//  BUOrderDatePickerViewController.swift
//  Burb
//
//  Created by Eugene on 29.01.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit

class BUOrderDatePickerViewController: UIViewController {
    
    fileprivate enum CellModel {
        case adressLabel
        case datePicker
        case servicePicker
        case button
    }
    
    fileprivate enum HeaderModel {
        typealias CellType = CellModel
        case adressLabel
        case datePicker
        case servicePicker
        case button
        
        var cellModels: [BUOrderDatePickerViewController.CellModel] {
            switch self {
            case .adressLabel: return [.adressLabel]
            case .datePicker: return [.datePicker]
            case .servicePicker: return [.servicePicker]
            case .button: return [.button]
            }
        }
    }
    
    private let models: [HeaderModel] = [.adressLabel, .datePicker, .servicePicker, .button]
    private let HeaderModels: [HeaderModel] = [.adressLabel, .datePicker, .servicePicker, .button]
    private var services: [Service] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate()
        registerCells()
        setupBackBarItem()
        OrderDatePickerInteractor.shared.fetchServices()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.barTintColor = .white
        self.title = "_DATEPICKER"
    }
    
    private func delegate() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    private func registerCells() {
        self.tableView.register(BULabelTableViewCell.nib, forCellReuseIdentifier: BULabelTableViewCell.name)
        self.tableView.register(BUDatePickerTableViewCell.nib, forCellReuseIdentifier: BUDatePickerTableViewCell.name)
        self.tableView.register(BUButtonTableViewCell.nib, forCellReuseIdentifier: BUButtonTableViewCell.name)
        self.tableView.register(BUCVTableViewCell.nib, forCellReuseIdentifier: BUCVTableViewCell.name)
    }
    
    @objc func handleNext() {
        OrderDatePickerRouter.shared.goToChooseBarberViewController(from: self)
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    
    private func setupBackBarItem() {
        var barButton = UIBarButtonItem(customView: UIImageView(image: UIImage(named: "icBack")))
        barButton = UIBarButtonItem(image: UIImage(named: "icBack"), style: .plain, target: self, action: #selector(goBack))
        barButton.tintColor = UIColor.black
        navigationItem.leftBarButtonItem = barButton
    }
    
}

extension BUOrderDatePickerViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HeaderModels[section].cellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = HeaderModels[indexPath.section].cellModels[indexPath.row]
        
        switch  model {
        case .adressLabel:
            if let cell = self.tableView.dequeueReusableCell(withIdentifier: BULabelTableViewCell.name, for: indexPath) as? BULabelTableViewCell {
                cell.setFont(font: UIFont(name: "OpenSans-Light", size: 18)!)
                cell.textLabel?.textColor = UIColor(red: 50.0/255.0, green: 50.0/255.0, blue: 50.0/255.0, alpha: 1.0)
                
                return cell
            }
        case .datePicker:
                if let cell = self.tableView.dequeueReusableCell(withIdentifier: BUDatePickerTableViewCell.name, for: indexPath) as? BUDatePickerTableViewCell {
                    
                    
                    
                    return cell
                }
        case .servicePicker:
            if let cell = self.tableView.dequeueReusableCell(withIdentifier: BUCVTableViewCell.name, for: indexPath) as? BUCVTableViewCell {
                cell.collectionView.delegate = self
                cell.collectionView.dataSource = self
                
                return cell
            }
            case .button:
                if let cell = self.tableView.dequeueReusableCell(withIdentifier: BUButtonTableViewCell.name, for: indexPath) as? BUButtonTableViewCell {
                    cell.button.setTitle("_CONFIRMTIME", for: .normal)
                    cell.setColor(color: burbColor)
                    cell.setFont(font: UIFont(name: "OpenSans-Semibold", size: 15)!)
                    cell.setTitleColor(color: .white)
                    cell.button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
                    return cell
                }
        }
        return UITableViewCell.init()
    }
    

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let headerModel = HeaderModels[section]
        switch headerModel {
        case .adressLabel:
            return 0
        case .datePicker:
            return 0
            case .servicePicker:
                return 0
        case .button:
            return 44
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
          let headerModel = HeaderModels[section]
          switch headerModel {
          case .adressLabel:
              return nil
          case .datePicker:
              let view = HeaderView.loadFromNib()
              return view
          case .button:
              let view = HeaderView.loadFromNib()
              return view
          case .servicePicker:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           
           let models = HeaderModels[indexPath.section].cellModels[indexPath.row]
           switch models {
           case .adressLabel:
               return self.tableView.frame.height / 10
           case .datePicker:
            return self.tableView.frame.height / 2.5
           case .servicePicker:
            return 180
           case .button:
               return self.tableView.frame.height / 9
           }
       }
    
    
}

extension BUOrderDatePickerViewController {
    fileprivate class Decorator {
        private init() {}
        static func decorate(_ vc: BUOrderDatePickerViewController) {
            
        }
    }
}

extension BUOrderDatePickerViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return services.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ServiceCollectionViewCell.name, for: indexPath) as? ServiceCollectionViewCell {
            let service = self.services[indexPath.item]
            cell.nameTitle.text = service.serviceName
            return cell
        }
        return UICollectionViewCell.init()
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        OrderDatePickerInteractor.shared.addServicesToUserDefaults(at: [indexPath.row])
        return (collectionView.indexPathsForSelectedItems?.count ?? 0) < 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ServiceCollectionViewCell.name, for: indexPath) as? ServiceCollectionViewCell
        let width = cell?.nameTitle.frame.width
        return CGSize(width: width!, height: 32)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 40, left: 16, bottom: 0, right: 16)
    }
}

