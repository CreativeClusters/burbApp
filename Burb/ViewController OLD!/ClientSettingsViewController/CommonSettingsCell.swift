//
//  CommonSettingsCell.swift
//  Burb
//
//  Created by Eugene on 16/09/2019.
//  Copyright © 2019 CC_Eugene. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
class CommonSettingsCell: UITableViewCell {

    
    
    @IBOutlet weak var hidePhoneSwitcher: UISwitch!
    @IBOutlet weak var notificationSwitcher: UISwitch!
    @IBOutlet weak var reminderLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        reminderLabel.isUserInteractionEnabled = true
        languageLabel.isUserInteractionEnabled = true
        addTargets()
        fillCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    
    func addTargets() {
        let languageTap = UITapGestureRecognizer(target: self, action: #selector(showSettingsMenu))
        let reminderTap = UITapGestureRecognizer(target: self, action: #selector(showSettingsMenu))
        reminderLabel.addGestureRecognizer(reminderTap)
        languageLabel.addGestureRecognizer(languageTap)
        reminderLabel.isUserInteractionEnabled = true
        languageLabel.isUserInteractionEnabled = true
        reminderLabel.tag = 1
        languageLabel.tag = 2
    }
    
    
    @objc func showSettingsMenu(_ recognizer: UITapGestureRecognizer) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let changeClientSettingsViewController = storyboard.instantiateViewController(withIdentifier: "changeClientSettingsViewController") as! ChangeClientSettingsViewController
        
        if recognizer.view?.tag == 1 {
            changeClientSettingsViewController.settingsType = .chooseDateNotification
        } else if recognizer.view?.tag == 2 {
            changeClientSettingsViewController.settingsType = .chooseLanguage
        }
        
        
        changeClientSettingsViewController.modalPresentationStyle = .overFullScreen
        viewControllerForTableView?.navigationController?.pushViewController(changeClientSettingsViewController, animated: true)
    }
    
    
    func fillCell() {
        let uid = Auth.auth().currentUser?.uid
        Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value) { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                self.reminderLabel.text = dictionary["notifications"] as? String
                self.languageLabel.text = dictionary["language"] as? String
            }
        }
    }
    
    
}

extension UITableViewCell {
    var viewControllerForTableView : UIViewController?{
        return ((self.superview as? UITableView)?.delegate as? UIViewController)
    }

}
