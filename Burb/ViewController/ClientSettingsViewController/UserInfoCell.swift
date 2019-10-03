//
//  UserInfoCell.swift
//  Burb
//
//  Created by Eugene on 28/08/2019.
//  Copyright © 2019 CC_Eugene. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class UserInfoCell: UITableViewCell {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var frameView: UIView!

    @IBOutlet weak var avatarView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        fillCell()
        decorator()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }

    func fillCell() {
        let uid = Auth.auth().currentUser?.uid
        Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value) { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                self.nameTextField.text = dictionary["name"] as? String
                self.phoneTextField.text = dictionary["phone"] as? String
                if let profileImageUrl = dictionary["avatarReference"] as? String {
                    self.avatarView.loadImageUsingCacheWithUrlString(urlString: profileImageUrl)
                }
            }
        }
    }
    
 
    func decorator() {
        frameView.clipsToBounds = true
        frameView.layer.masksToBounds = true
        frameView.layer.borderColor = burbColor.cgColor
        frameView.layer.borderWidth = 3
        avatarView.clipsToBounds = true
        avatarView.layer.masksToBounds = true
        avatarView.layer.cornerRadius = self.avatarView.frame.height / 2
        frameView.layer.cornerRadius = self.frameView.frame.height / 2
    }
 
    
}
