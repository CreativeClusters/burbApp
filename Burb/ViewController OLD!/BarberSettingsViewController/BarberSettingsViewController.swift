//
//  BarberSettingsViewController.swift
//  Burb
//
//  Created by Eugene on 29/09/2019.
//  Copyright © 2019 CC_Eugene. All rights reserved.
//

import UIKit

enum ReminderModel {
    case before2h
    case before5h
    case before10h
    case before24h
}

class BarberSettingsViewController: UIViewController {
    
    
    fileprivate enum CellModel {
        case userInfo
        case name
        case phoneNumber
        case personalInfoLabel
        case weapon
        case barberEducation
        case philosophy
        case commonSettingsLabel
        case notifications
        case hidePhone
        case reminder
        case signOut
    }
    
    var reminderSettings: ReminderModel = .before2h
    
    var reminderLabel: String?
    
    var avatarImage : UIImage? { didSet {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            }
        }
    }
    
    private var models: [CellModel] = [.userInfo, .name, .phoneNumber, .personalInfoLabel, .weapon, .barberEducation, .philosophy, .commonSettingsLabel, .notifications, .hidePhone, .reminder, .signOut]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        registerCells()
    }
    
    private func registerCells() {
        tableView.register(SignOutCell.nib, forCellReuseIdentifier: SignOutCell.name)
        tableView.register(HidePhoneNumberCell.nib, forCellReuseIdentifier: HidePhoneNumberCell.name)
        tableView.register(NotificationsCell.nib, forCellReuseIdentifier: NotificationsCell.name)
        tableView.register(ReminderCell.nib, forCellReuseIdentifier: ReminderCell.name)
        tableView.register(PhilosophyCell.nib, forCellReuseIdentifier: PhilosophyCell.name)
        tableView.register(BarberEducationCell.nib, forCellReuseIdentifier: BarberEducationCell.name)
        tableView.register(WeaponCell.nib, forCellReuseIdentifier: WeaponCell.name)
        tableView.register(CommonSettingsLabelCell.nib, forCellReuseIdentifier: CommonSettingsLabelCell.name)
        tableView.register(PhoneNumberCell.nib, forCellReuseIdentifier: PhoneNumberCell.name)
        tableView.register(NameUserCell.nib, forCellReuseIdentifier: NameUserCell.name)
        tableView.register(UserAvatarCell.nib, forCellReuseIdentifier: UserAvatarCell.name)
    }

    override func viewWillAppear(_ animated: Bool) {
        title = "Profile"
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    

    
    @objc func changeAvatar() {
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
    
    @objc func chooseRemindTimer() {
        let changeClientSettingsViewController = self.storyboard!.instantiateViewController(withIdentifier: "changeClientSettingsViewController") as! ChangeClientSettingsViewController
        changeClientSettingsViewController.settingsType = .chooseDateNotification
        changeClientSettingsViewController.modalPresentationStyle = .overFullScreen
        navigationController?.pushViewController(changeClientSettingsViewController, animated: true)
    }
    
    
    @objc func sighOutPressed() {
        print("Sign out?")
    }
    
    func switchLabelOfButton() {
        switch reminderSettings {
        case .before2h : self.reminderLabel = "2h before"
        case .before5h : self.reminderLabel = "5h before"
        case .before10h : self.reminderLabel = "10h before"
        case .before24h : self.reminderLabel = "24h before"
        }
    }
    
}


extension BarberSettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        switch model {
        case .userInfo:
            let cell = tableView.dequeueReusableCell(withIdentifier: UserAvatarCell.name, for: indexPath) as! UserAvatarCell
            let changeAvatarTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(changeAvatar))
            cell.photoViewClicked = self.changeAvatar
            cell.avatarImageView.addGestureRecognizer(changeAvatarTapGestureRecognizer)
            cell.avatarImageView.image = avatarImage
            return cell
        case .name:
            let cell = tableView.dequeueReusableCell(withIdentifier: NameUserCell.name, for: indexPath) as! NameUserCell
                return cell
        case .phoneNumber:
            let cell = tableView.dequeueReusableCell(withIdentifier: PhoneNumberCell.name, for: indexPath) as! PhoneNumberCell
            return cell
        case .personalInfoLabel:
            let cell = tableView.dequeueReusableCell(withIdentifier: CommonSettingsLabelCell.name, for: indexPath) as! CommonSettingsLabelCell
            cell.titleLabel.text = "Personal info"
            return cell
        case .weapon:
            let cell = tableView.dequeueReusableCell(withIdentifier: WeaponCell.name, for: indexPath) as! WeaponCell
            return cell
        case .barberEducation:
            let cell = tableView.dequeueReusableCell(withIdentifier: BarberEducationCell.name, for: indexPath) as! BarberEducationCell
            return cell
        case .philosophy:
            let cell = tableView.dequeueReusableCell(withIdentifier: PhilosophyCell.name, for: indexPath) as! PhilosophyCell
            return cell
        case .commonSettingsLabel:
                let cell = tableView.dequeueReusableCell(withIdentifier: CommonSettingsLabelCell.name, for: indexPath) as! CommonSettingsLabelCell
                return cell
        case .notifications:
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationsCell.name, for: indexPath) as! NotificationsCell
            return cell
        case .hidePhone:
            let cell = tableView.dequeueReusableCell(withIdentifier: HidePhoneNumberCell.name, for: indexPath) as! HidePhoneNumberCell
            return cell
        case .reminder:
            let cell = tableView.dequeueReusableCell(withIdentifier: ReminderCell.name, for: indexPath) as! ReminderCell
            cell.hoursButton.addTarget(self, action: #selector(chooseRemindTimer), for: .touchUpInside)
            
            return cell
            case .signOut:
                let cell = tableView.dequeueReusableCell(withIdentifier: SignOutCell.name, for: indexPath) as! SignOutCell
                cell.signOutButton.addTarget(self, action: #selector(sighOutPressed), for: .touchUpInside)
                return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = models[indexPath.row]
        switch model {
        case .userInfo:
            return self.view.frame.height / 4
        case .name:
            return 40
        case .phoneNumber:
            return 50
        case .personalInfoLabel:
            return 50
        case .weapon:
            return 60
        case .barberEducation:
            return 60
        case .philosophy:
            return 60
        case .commonSettingsLabel:
            return 50
        case .notifications:
            return 50
        case .hidePhone:
            return 50
        case .reminder:
           return 50
        case .signOut:
            return 80
        }
        
    }
    
    
    
}

extension BarberSettingsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectedImageFromPicker: UIImage?
        if let editedImage = info[.editedImage] as? UIImage { selectedImageFromPicker = editedImage; picker.dismiss(animated: true, completion: nil) } else { let originalImage = info[.originalImage] as! UIImage
            selectedImageFromPicker = originalImage
            picker.dismiss(animated: true, completion: nil) }
        
        if let selectedImage = selectedImageFromPicker {
            avatarImage = selectedImage
        }
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}
