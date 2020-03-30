//
//  DialogsViewController.swift
//  Burb
//
//  Created by Eugene on 03/09/2019.
//  Copyright © 2019 CC_Eugene. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase


class DialogsViewController: UIViewController {
    
    
    var timer: Timer?
    var users = [Customer]()
    var messages = [Message]()
    var messageDictionary = [String: Message]()
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = "Dialogs"
        fetchUsers()
        observeUserMessages()
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
         tabBarController?.tabBar.isHidden = false
    }
    
    
    
    func observeUserMessages() {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let ref = Database.database().reference().child("user_messages").child(uid)
        ref.observe(.childAdded) { (snapshot) in
            let userId = snapshot.key
            Database.database().reference().child("user_messages").child(uid).child(userId).observe(.childAdded) { (snapshot) in
                
                let messageId = snapshot.key
                
                self.fetchMessageWithMessageId(messageId)
            }
        }
    }
    
    
    private func fetchMessageWithMessageId(_ messageId: String) {
        let messageReference = Database.database().reference().child("messages").child(messageId)
        messageReference.observeSingleEvent(of: .value) { (snapshot) in

            if let dictionary = snapshot.value as? [String: AnyObject] {
                let message = Message(dictionary: dictionary)

                if let chatPartnerId = message.chatPartnerId() {
                    self.messageDictionary[chatPartnerId] = message

                }
                
                self.attemptReloadOfTableView()
            }
        }
        
    }
    
    private func attemptReloadOfTableView() {
    self.timer?.invalidate()
    self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.handleReloadTable), userInfo: nil, repeats: false)
    }
    
    @objc func handleReloadTable() {
        self.messages = Array(self.messageDictionary.values)
        self.messages.sort { (message1, message2) -> Bool in
            return (message1.timestamp?.intValue)! > (message2.timestamp?.intValue)!
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func fetchUsers() {
        Database.database().reference().child("users").observe(.childAdded) { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
         //       let user = Customer(dictionary: dictionary)
//                let names = dictionary["name"] as? String
//                let avatars = dictionary["avatarReference"] as? String
//                let IDs = snapshot.key
//                user.id = IDs
//                user.name = names
//                user.avatarReference = avatars
//                self.users.append(user)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    
    func showCurrentDialog(_ user: User) {
        let chatLogViewController = self.storyboard!.instantiateViewController(withIdentifier: "chatLogViewController") as! ChatLogViewController
        self.navigationController?.pushViewController(chatLogViewController, animated: true)
       // chatLogViewController.user = user
    }

}

extension DialogsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DialogUserCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: [indexPath.row]) as! DialogUserCell
        let user = users[indexPath.row]
        cell.nameLabel.text = user.name
        cell.avatarImageView.image = UIImage(named: "user.png")
        cell.avatarImageView.contentMode = .scaleAspectFill
        cell.avatarImageView.layer.cornerRadius = cell.avatarImageView.frame.height / 2
        cell.avatarImageView.layer.masksToBounds = true
        if let avatarReferenceURL = user.avatarReference {
            cell.avatarImageView.loadImageUsingCacheWithUrlString(urlString: avatarReferenceURL)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let user = self.users[indexPath.row]
//        showCurrentDialog(user)
    }
    
}
