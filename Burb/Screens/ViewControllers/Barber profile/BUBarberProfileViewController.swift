//
//  BUBarberProfileViewController.swift
//  Burb
//
//  Created by Eugene on 30.03.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit

class BUBarberProfileViewController: UIViewController {
    
    fileprivate enum CellModel {
        case avatar
        case name
        case phoneNumber
        case age
        case weapon
        case education
        case phylosophy
        case recieveNotifications
        case reminder
        case deleteAccout
        case signOut
    }
    
    fileprivate enum HeaderModel {
        case avatar
        case name
        case phoneNumber
        case age
        case weapon
        case education
        case phylosophy
        case recieveNotifications
        case reminder
        case deleteAccout
        case signOut
        
        var cellModels: [BUBarberProfileViewController.CellModel] {
            switch self {
            case .avatar: return [.avatar]
            case .name: return [.name]
            case .phoneNumber: return [.phoneNumber]
            case .age: return [.age]
            case .weapon: return [.weapon]
            case .education: return [.education]
            case .phylosophy: return [.phylosophy]
            case .recieveNotifications: return [.recieveNotifications]
            case .reminder: return [.reminder]
            case .deleteAccout: return [.deleteAccout]
            case .signOut: return [.signOut]
            }
        }
    }
    
    private let models: [HeaderModel] = [.avatar, .name, .phoneNumber, .age, .weapon, .education, .phylosophy, .recieveNotifications, .reminder, .deleteAccout, .signOut]
    private let HeaderModels: [HeaderModel] = [.avatar, .name, .phoneNumber, .age, .weapon, .education, .phylosophy, .recieveNotifications, .reminder, .deleteAccout, .signOut]
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegating()
        registerCells()
        Decorator.decorate(self)
    }
    
    private func delegating() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    private func registerCells() {
        self.tableView.register(AvatarProfileTableViewCell.nib, forCellReuseIdentifier: AvatarProfileTableViewCell.name)
        self.tableView.register(TumblerTableViewCell.nib, forCellReuseIdentifier: TumblerTableViewCell.name)
        self.tableView.register(BUButtonTableViewCell.nib, forCellReuseIdentifier: BUButtonTableViewCell.name)
        self.tableView.register(LabelButtonTableViewCell.nib, forCellReuseIdentifier: LabelButtonTableViewCell.name)
        self.tableView.register(TextFieldTableViewCell.nib, forCellReuseIdentifier: TextFieldTableViewCell.name)
    }
    
    
}

extension BUBarberProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HeaderModels[section].cellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = HeaderModels[indexPath.section].cellModels[indexPath.row]
        switch model {
        case .avatar:
            if let cell = tableView.dequeueReusableCell(withIdentifier: AvatarProfileTableViewCell.name, for: indexPath) as? AvatarProfileTableViewCell {

                
                return cell
            }
        case .name:
            if let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldTableViewCell.name, for: indexPath) as? TextFieldTableViewCell {
                cell.setFont(font: UIFont(name: "OpenSans", size: 21)!)
                cell.setTextColor(color: blackburbColor)
                cell.setText(text: "Alex Turner")
                return cell
            }
        case .phoneNumber:
            if let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldTableViewCell.name, for: indexPath) as? TextFieldTableViewCell {
                cell.setFont(font: UIFont(name: "OpenSans", size: 15)!)
                cell.setTextColor(color: grayBurbColor)
                cell.setText(text: "+7 (916) 014 52 13")
                return cell
            }
        case .age:
            if let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldTableViewCell.name, for: indexPath) as? TextFieldTableViewCell {
                cell.setFont(font: UIFont(name: "OpenSans", size: 15)!)
                cell.setTextColor(color: grayBurbColor)
                cell.setText(text: "33")
                return cell
            }
        case .weapon:
            if let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldTableViewCell.name, for: indexPath) as? TextFieldTableViewCell {
                cell.setFont(font: UIFont(name: "OpenSans", size: 15)!)
                cell.setTextColor(color: grayBurbColor)
                cell.setText(text: "Moser MX-25")
                return cell
            }
        case .education:
            if let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldTableViewCell.name, for: indexPath) as? TextFieldTableViewCell {
                cell.setFont(font: UIFont(name: "OpenSans", size: 15)!)
                cell.setTextColor(color: grayBurbColor)
                cell.setText(text: "Boston Barber acaedmy")
                return cell
            }
        case .phylosophy:
            if let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldTableViewCell.name, for: indexPath) as? TextFieldTableViewCell {
                cell.setFont(font: UIFont(name: "OpenSans", size: 15)!)
                cell.setTextColor(color: grayBurbColor)
                cell.setText(text: "Live fast, die young")
                return cell
            }
        case .recieveNotifications:
            if let cell = tableView.dequeueReusableCell(withIdentifier: TumblerTableViewCell.name, for: indexPath) as? TumblerTableViewCell {
                cell.setFont(font: UIFont(name: "OpenSans", size: 15)!)
                cell.setText(text: "_RECEIVENOTIFICATIONS")
                return cell
            }
        case .reminder:
            if let cell = tableView.dequeueReusableCell(withIdentifier: LabelButtonTableViewCell.name, for: indexPath) as? LabelButtonTableViewCell {
                cell.setlabelTextFont(font: UIFont(name: "OpenSans", size: 15)!)
                cell.setLabelTextLabel(text: "_REMINDME")
                cell.setLabelTextColor(color: blackburbColor)
                return cell
            }
        case .deleteAccout:
            if let cell = tableView.dequeueReusableCell(withIdentifier: BUButtonTableViewCell.name, for: indexPath) as? BUButtonTableViewCell {
                cell.setTitle(text: "_SIGNOUT")
                cell.setTitleColor(color: blackburbColor)
                cell.setFont(font: UIFont(name: "OpenSans-Semibold", size: 15)!)
                return cell
            }
        case .signOut:
            if let cell = tableView.dequeueReusableCell(withIdentifier: BUButtonTableViewCell.name, for: indexPath) as? BUButtonTableViewCell {
                cell.setTitle(text: "_DELETEACCOUNT")
                cell.setTitleColor(color: burbColor)
                cell.setFont(font: UIFont(name: "OpenSans-Semibold", size: 15)!)
                return cell
            }
        }
        return UITableViewCell.init()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = HeaderModels[indexPath.section].cellModels[indexPath.row]
        switch model {
        case .avatar:
            return 150
        case .name:
            return 44
        case .phoneNumber:
            return 44
        case .age:
            return 44
        case .weapon:
            return 44
        case .education:
            return 44
        case .phylosophy:
            return 44
        case .reminder:
            return 60
        case .recieveNotifications:
            return 60
        case .deleteAccout:
            return 60
        case .signOut:
            return 44
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let headerModels = HeaderModels[section]
        switch headerModels {
        case .avatar:
            return 0
        case .name:
            return 0
        case .phoneNumber:
            return 0
        case .age:
            return 44
        case .weapon:
            return 0
        case .education:
            return 0
        case .phylosophy:
            return 0
        case .reminder:
            return 0
        case .recieveNotifications:
            return 44
        case .deleteAccout:
            return 0
        case .signOut:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerModels = HeaderModels[section]
        switch headerModels {
            
        case .avatar:
            return nil
        case .name:
            return nil
        case .phoneNumber:
            return nil
        case .recieveNotifications:
            let view = HeaderTitleView.loadFromNib()
            view.setTitle(text: "_COMMONSETTINGS")
            view.setTextColor(color: UIColor(red: 50.0/255.0, green: 50.0/255.0, blue: 50.0/255.0, alpha: 0.5))
            view.setFont(font: UIFont(name: "OpenSans", size: 15)!)
            view.setColor(color: lightGrayBurbColor)
            return view
        case .reminder:
            let view = HeaderView.loadFromNib()
            view.setColor(color: .white)
            return view
        case .deleteAccout:
            let view = HeaderView.loadFromNib()
            view.setColor(color: lightGrayBurbColor)
            return view
        case .signOut:
            let view = HeaderView.loadFromNib()
            view.setColor(color: lightGrayBurbColor)
            return view
        case .age:
            let view = HeaderView.loadFromNib()
            view.setColor(color: lightGrayBurbColor)
            return view
        case .weapon:
            let view = HeaderView.loadFromNib()
            view.setColor(color: lightGrayBurbColor)
            return view
        case .education:
            let view = HeaderView.loadFromNib()
            view.setColor(color: lightGrayBurbColor)
            return view
        case .phylosophy:
                        let view = HeaderView.loadFromNib()
            view.setColor(color: lightGrayBurbColor)
            return view
        }
    }
}

extension BUBarberProfileViewController {
    
    fileprivate class Decorator {
        private init() {}
        static func decorate(_ vc: BUBarberProfileViewController) {
            vc.title = "_PROFILE SETTINGS"
            vc.hideKeyboardWhenTappedAround()
            vc.navigationController?.navigationBar.shadowImage = UIImage()
            vc.navigationController?.navigationBar.barTintColor = UIColor.white
        }
    }
}

