//
//  BUCreateBarberViewController.swift
//  Burb
//
//  Created by Eugene on 19.02.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit
import CoreData

class BUCreateBarberViewController: UIViewController {
    
    fileprivate enum CellModel {
        case avatar
        case name
        case phoneNumber
        case age
    }
    
    fileprivate enum HeaderModel {
        typealias CellType = CellModel
        case avatar
        case name
        case phoneNumber
        case age
        
        var cellModels: [BUCreateBarberViewController.CellModel] {
            switch self {
            case .avatar: return [.avatar]
            case .name: return [.name]
                case .phoneNumber: return [.phoneNumber]
            case .age: return [.age]
            }
        }
    }
    
    private let addImage = UIImage(named: "add_512")
    private var titleVC: String?
    private var headerModel: [HeaderModel] = [.avatar, .name, .phoneNumber, .age]
    private var model: [CellModel] = [.avatar, .name, .phoneNumber, .age]
    
    private var barber: Barber?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initBarber()
        delegating()
        registerCells()
        setupBackBarItem()
        Decorator.decorate(self)
        addRightBarButton()
    }
    
    private func initBarber() {
        let defaults = UserDefaults.standard
        self.barber = Barber(id: defaults.string(forKey: "userID")!,
                             name: "",
                             photo: UIImage.init(),
                             fullPhoto: UIImage.init(),
                             phoneNumber: defaults.string(forKey: "phoneNumber")!,
                             avatarReference: "",
                             fullAvatarReference: "",
                             age: Int.init(),
                             weapon: "",
                             education: "",
                             philosophy: "",
                             city: "")
    }
    
    private func delegating() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    private func registerCells() {
        tableView.register(AvatarTableViewCell.nib, forCellReuseIdentifier: AvatarTableViewCell.name)
        tableView.register(BUTextFieldTableViewCell.nib, forCellReuseIdentifier: BUTextFieldTableViewCell.name)
    }
    
    private func updateDoneButtonStatus() {
        navigationItem.rightBarButtonItem?.isEnabled = self.barber!.isFilled
      }
    
    private func addRightBarButton() {
         let rightBarBarButton = UIBarButtonItem(title: "_DONE", style: .plain, target: self, action: #selector(donePressed))
         rightBarBarButton.tintColor = burbColor
         navigationItem.rightBarButtonItem = rightBarBarButton
     }
    
    @objc private func donePressed() {
        guard let barber = self.barber else { return }
        CreateBarberInteractor.shared.saveBarberData(barber: barber)
        CreateBarberInteractor.shared.saveCurrentBarberSQL(with: barber)
        CreateBarberRouter.shared.handleSpecifyCity(from: self)
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
    
    
    func photoViewClicked() {
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


extension BUCreateBarberViewController: UITableViewDataSource, UITableViewDelegate {
    
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
                cell.avatarImageView.image = self.barber?.photo
                cell.photoViewClicked = {
                    self.photoViewClicked()
                    self.updateDoneButtonStatus()
                }
                return cell
            }
        case .name:
            if let cell = tableView.dequeueReusableCell(withIdentifier: BUTextFieldTableViewCell.name, for: indexPath) as? BUTextFieldTableViewCell {
                cell.textField.font = UIFont(name: "OpenSans", size: 24)
                cell.textField.textColor = UIColor(red: 50.0/255.0, green: 50.0/255.0, blue: 50.0/255.0, alpha: 1.0)
                cell.textField.placeholder = "_YOURNAME"
                cell.textChanged = {
                     text in
                     self.barber?.name = text
                     self.updateDoneButtonStatus()
                 }
                return cell
            }
        case .phoneNumber:
            if let cell = tableView.dequeueReusableCell(withIdentifier: BUTextFieldTableViewCell.name, for: indexPath) as? BUTextFieldTableViewCell {
                cell.textField.font = UIFont(name: "OpenSans", size: 24)
                cell.textField.textColor = UIColor(red: 50.0/255.0, green: 50.0/255.0, blue: 50.0/255.0, alpha: 1.0)
                cell.textField.placeholder = "_PHONENUMBER"
                cell.textField.text = self.barber?.phoneNumber
                cell.textChanged = {
                     text in
                     self.barber?.phoneNumber = text
                     self.updateDoneButtonStatus()
                 }
                return cell
            }
        case .age:
            if let cell = tableView.dequeueReusableCell(withIdentifier: BUTextFieldTableViewCell.name, for: indexPath) as? BUTextFieldTableViewCell {
                cell.textField.font = UIFont(name: "OpenSans", size: 24)
                cell.textField.textColor = UIColor(red: 50.0/255.0, green: 50.0/255.0, blue: 50.0/255.0, alpha: 1.0)
                cell.textField.placeholder = "_YOURAGE"
                cell.textChanged = {
                     text in
                    self.barber?.age = Int(text)!
                     self.updateDoneButtonStatus()
                 }
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
            case .phoneNumber:
                return self.tableView.frame.height / 6
        case .age:
            return self.tableView.frame.height / 6
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let headerModels = headerModel[section]
        switch headerModels {
        case .avatar:
            return 0
        case .name:
            return 0
            case .phoneNumber:
                return 0
        case .age:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerModels = headerModel[section]
        switch headerModels {
        case .avatar:
            return nil
        case .name, .age, .phoneNumber:
            let view = HeaderView.loadFromNib()
            view.setColor(color: .white)
            return view
        }
    }
}

extension BUCreateBarberViewController {
    
    fileprivate class Decorator {
        
        private init() {}
        static func decorate(_ vc: BUCreateBarberViewController) {
            vc.hideKeyboardWhenTappedAround()
            vc.title = "_CREATEBARBER"
            vc.navigationController?.navigationBar.barTintColor = UIColor.white
            vc.navigationController?.navigationBar.shadowImage = UIImage()
            vc.hideKeyboardWhenTappedAround()
        }
    }
}

extension BUCreateBarberViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectedImageFromPicker: UIImage?
        if let editedImage = info[.editedImage] as? UIImage  {
            selectedImageFromPicker = editedImage
            picker.dismiss(animated: true, completion: nil)
        } else {
            let originalImage = info[.originalImage] as! UIImage
            selectedImageFromPicker = originalImage
            self.barber?.fullPhoto = originalImage
            picker.dismiss(animated: true, completion: nil)
        }
        
        if let selectedImage = selectedImageFromPicker {
            self.barber?.photo = selectedImage
        }
        updateDoneButtonStatus()
        self.tableView.reloadData()
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
