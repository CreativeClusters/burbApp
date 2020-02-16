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
        case button
    }
    
    fileprivate enum HeaderModel {
        typealias CellType = CellModel
        case adressLabel
        case datePicker
        case button
        
        var cellModels: [BUOrderDatePickerViewController.CellModel] {
            switch self {
            case .adressLabel: return [.adressLabel]
            case .datePicker: return [.datePicker]
            case .button: return [.button]
            }
        }
    }
    
    private let models: [HeaderModel] = [.adressLabel, .datePicker, .button]
    private let HeaderModels: [HeaderModel] = [.adressLabel, .datePicker, .button]
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate()
        registerCells()

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
    }
    
    @objc func handleNext() {
        ConfirmTimeRouter.shared.goToChooseBarberViewController(from: self)
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
        case .button:
            return self.tableView.frame.height / 5
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
      }
}
    

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           
           let models = HeaderModels[indexPath.section].cellModels[indexPath.row]
           switch models {
           case .adressLabel:
               return self.tableView.frame.height / 8
           case .datePicker:
               return self.tableView.frame.height / 2
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
