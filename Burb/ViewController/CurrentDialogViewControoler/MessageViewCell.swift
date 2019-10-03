//
//  MessageViewCell.swift
//  Burb
//
//  Created by Eugene on 03/09/2019.
//  Copyright © 2019 CC_Eugene. All rights reserved.
//

import UIKit
import Firebase


class MessageViewCell: UITableViewCell {

    var message: Message? {
        didSet {
            setupNameAndProfileImage()
            self.textMessageLabel?.text = message?.text
            
            if let seconds = message?.timestamp?.doubleValue {
                let timestampDate = NSDate(timeIntervalSince1970: seconds)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "hh:mm:ss a"
                self.timestampLabel.text = dateFormatter.string(from: timestampDate as Date)
            }
        }
    }
    
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var textMessageLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureTimestamp()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    private func setupNameAndProfileImage() {
        if let id = message?.chatPartnerId() {
            let ref = Database.database().reference().child("users").child(id)
            ref.observeSingleEvent(of: .value) { (snapshot) in
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    self.nameLabel?.text = dictionary["name"] as? String
                    
                    if let avatarImageUrl = dictionary["avatarReference"] {
                        self.avatarImageView.loadImageUsingCacheWithUrlString(urlString: avatarImageUrl as! String)
                    }
                }
            }
        }
    }
    
    func configureTimestamp() {
        self.timestampLabel.text = "HH:MM:SS"
        self.timestampLabel.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
}
