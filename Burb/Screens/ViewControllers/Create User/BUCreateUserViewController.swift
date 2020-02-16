//
//  BUCreateUserViewController.swift
//  Burb
//
//  Created by Eugene on 26.01.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit

class BUCreateUserViewController: UIViewController {
    
    
    fileprivate enum CellModel {
        case avatar
        case name
        case age
        case button
    }
    
    
    fileprivate enum HeaderModel {
        typealias CellType = CellModel
        case avatar
        case name
        case age
        case button
        
        
        var cellModels: [BUCreateUserViewController.CellModel] {
            switch self {
            case .avatar: return [.avatar]
            case .name: return [.name]
            case .age: return [.age]
            case .button: return [.button]
            }
        }
    }
    
    //private var user = User()
    private var titleVC: String?
    private var headerModel: [HeaderModel] = [.avatar, .name, .age, .button]
    private var model: [CellModel] = [.avatar, .name, .age, .button]
    
    private var imageView: UIImageView?
    private var plusImage: UIImage?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegating()
        registerCells()
        setupBackBarItem()
        Decorator.decorate(self)
    }
    
    private func delegating() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    
    private func registerCells() {
        tableView.register(AvatarTableViewCell.nib, forCellReuseIdentifier: AvatarTableViewCell.name)
        tableView.register(BUTextFieldTableViewCell.nib, forCellReuseIdentifier: BUTextFieldTableViewCell.name)
        tableView.register(BUButtonTableViewCell.nib, forCellReuseIdentifier: BUButtonTableViewCell.name)
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
    
    @objc private func handleOnboarding() {
        CreateUserRouter.shared.goToChooseLocation(from: self)
    }
    

    
    @objc func photoViewClicked() {
         let imagePickerController = UIImagePickerController()
         imagePickerController.delegate = self
         imagePickerController.allowsEditing = true
         let actionSheet = UIAlertController(title: "Photo source", message: "choose a source", preferredStyle: .actionSheet)
         actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
             imagePickerController.sourceType = .camera
             self.present(imagePickerController, animated: true, completion: nil)
         }))
         actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
             imagePickerController.sourceType = .photoLibrary
             self.present(imagePickerController, animated: true, completion: nil)
         }))
         actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action:UIAlertAction) in
         }))
         self.present(actionSheet, animated: true, completion: nil)
     }
    
}

extension BUCreateUserViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headerModel[section].cellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let models = headerModel[indexPath.section].cellModels[indexPath.row]
        switch models {
        case .avatar:
            if let cell = tableView.dequeueReusableCell(withIdentifier: AvatarTableViewCell.name, for: indexPath) as? AvatarTableViewCell {
                self.plusImage = UIImage(named: "add_512")
                cell.setPicture(image: plusImage!)
                let tap = UITapGestureRecognizer(target: self, action: #selector(photoViewClicked))
                cell.avatarImageView.addGestureRecognizer(tap)
                //cell.setPicture(image: )
                return cell
            }
        case .name:
            if let cell = tableView.dequeueReusableCell(withIdentifier: BUTextFieldTableViewCell.name, for: indexPath) as? BUTextFieldTableViewCell {
                cell.textField.font = UIFont(name: "OpenSans", size: 24)
                cell.textField.textColor = UIColor(red: 50.0/255.0, green: 50.0/255.0, blue: 50.0/255.0, alpha: 1.0)
                cell.titleLabel.text = "_YOURNAME"
                cell.textField.placeholder = "_ALEXTURNER"
                cell.alertLabel.text = "_FILLALLTHETEXT"
                return cell
            }
        case .age:
            if let cell = tableView.dequeueReusableCell(withIdentifier: BUTextFieldTableViewCell.name, for: indexPath) as? BUTextFieldTableViewCell {
                cell.textField.font = UIFont(name: "OpenSans", size: 24)
                cell.textField.textColor = UIColor(red: 50.0/255.0, green: 50.0/255.0, blue: 50.0/255.0, alpha: 1.0)
                cell.titleLabel.text = "_YOURAGE"
                cell.textField.placeholder = "_33"
                cell.alertLabel.text = "_FILLALLTHETEXT"
                return cell
            }
        case .button:
            if let cell = tableView.dequeueReusableCell(withIdentifier: BUButtonTableViewCell.name, for: indexPath) as? BUButtonTableViewCell {
                cell.button.setTitle("_VERIFYACCOUNT", for: .normal)
                cell.setColor(color: burbColor)
                cell.setFont(font: UIFont(name: "OpenSans-Semibold", size: 15)!)
                cell.button.tintColor = .white
                cell.button.addTarget(self, action: #selector(handleOnboarding), for: .touchUpInside)
                return cell
            }
        }
        return UITableViewCell.init()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let models = headerModel[indexPath.section].cellModels[indexPath.row]
        switch models {
        case .avatar:
            return self.tableView.frame.height / 3
        case .name:
            return self.tableView.frame.height / 6
        case .age:
            return self.tableView.frame.height / 6
        case .button:
            return self.tableView.frame.height / 10
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let headerModels = headerModel[section]
        switch headerModels {
        case .avatar:
            return 0
        case .name:
            return 0
        case .age:
            return 0
        case .button:
            return self.tableView.frame.size.height / 3 - 88
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerModels = headerModel[section]
        switch headerModels {
        case .avatar:
            return nil
        case .name, .age, .button:
            let view = HeaderView.loadFromNib()
            view.setColor(color: .white)
            return view
        }
    }
    
}

extension BUCreateUserViewController {
    
    fileprivate class Decorator {
        
        private init() {}
        static func decorate(_ vc: BUCreateUserViewController) {
            vc.hideKeyboardWhenTappedAround()
            vc.title = "_CREATEUSER"
        }
        
    }
    
}

extension BUCreateUserViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectedImageFromPicker: UIImage?
        if let editedImage = info[.editedImage] as? UIImage  {
            selectedImageFromPicker = editedImage
            picker.dismiss(animated: true, completion: nil)
        } else {
            let originalImage = info[.originalImage] as! UIImage
            selectedImageFromPicker = originalImage
            picker.dismiss(animated: true, completion: nil)
        }
        
        if let selectedImage = selectedImageFromPicker {
        //    self.user.photo = selectedImage
        }
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
}
