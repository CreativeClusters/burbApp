//
//  CurrentDialogViewController.swift
//  Burb
//
//  Created by Eugene on 03/09/2019.
//  Copyright © 2019 CC_Eugene. All rights reserved.
//

import UIKit
import Firebase

class CurrentDialogViewController: UIViewController, UITextFieldDelegate {
    
    var messages = [Message]()
    var messageDictionary = [String: Message]()
    
    
    var user: User? {
        didSet {
           title = user?.name
        }
    }
    
    
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        messageTextField.delegate = self
        hideKeyboardWhenTappedAround()
        observeUserMessages()
        print("user consists of \(String(describing: user?.avatarReference))-avatar  + \(user?.id)-id  + \(user?.name)-name")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setTitle()
    }
    
    
    func setTitle() {
        let titleLbl = UILabel()
        titleLbl.text = title
        titleLbl.textColor = UIColor.darkGray
        titleLbl.font = UIFont.systemFont(ofSize: 20.0, weight: .bold)
        let image = UIImage(named: "user")
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 38, height: 38))
        imageView.image = image
        let titleView = UIStackView(arrangedSubviews: [imageView, titleLbl])
        titleView.axis = .horizontal
        titleView.spacing = 10.0
        navigationItem.titleView = titleView
    }
    
    func observeUserMessages() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let ref = Database.database().reference().child("user_messages").child(uid)
        ref.observe(.childAdded, with: { (snapshot) in
            
            let messageId = snapshot.key
            let messageReference = Database.database().reference().child("messages").child(messageId)
            
            messageReference.observeSingleEvent(of: .value, with: { (snapshot) in
                
                    if let dictionary = snapshot.value as? [String: AnyObject] {
                        let message = Message(dictionary: dictionary)
                        message.fromId = dictionary["fromId"] as? String
                        message.text = dictionary["text"] as? String
                        message.timestamp = dictionary["timestamp"] as? NSNumber
                        message.toId = dictionary["toId"] as? String
                        self.messages.append(message)
                        print(self.messages)
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                }
            }, withCancel: nil)
        }, withCancel: nil)
        
    }

    
    
    func observeMessages() {
        let ref = Database.database().reference().child("messages")
        ref.observe(.childAdded) { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let message = Message(dictionary: dictionary)
                message.fromId = dictionary["fromId"] as? String
                message.text = dictionary["text"] as? String
                message.timestamp = dictionary["timestamp"] as? NSNumber
                message.toId = dictionary["toId"] as? String
                self.messages.append(message)
                print(self.messages)
                
                
//                if let toId = message.toId {
//                    self.messageDictionary[toId] = message
//                    self.messages = Array(self.messageDictionary.values)
//                    self.messages.sort(by: { (message1, message2) -> Bool in
//                        return (message1.timestamp?.intValue)! > (message2.timestamp?.intValue)!
//                    })
//                }
                
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }

    @IBAction func sendButtonPressed(_ sender: UIButton) {
       sendMessage()
    }
    
    func sendMessage() {
        let ref = Database.database().reference().child("messages")
        let childRef = ref.childByAutoId()
        let toId = user?.id
        let fromId = Auth.auth().currentUser?.uid
        let timestamp = NSNumber(value: Date().timeIntervalSince1970)
        let values = ["text": messageTextField.text!, "toId": toId!, "fromId": fromId!, "timestamp": timestamp] as [String : Any]
        childRef.updateChildValues(values) { (error, ref) in
            if error != nil {
                print(error!)
                return
            }
            let userMessageRef = Database.database().reference().child("user_messages")
            let childReference = userMessageRef.child(fromId!)
            let messageId = childRef.key as! String
            childReference.updateChildValues([messageId:"123"])
            
            let recipientUserMessagesRef = Database.database().reference().child("user_messages")
            let recipientChildReference = recipientUserMessagesRef.child(toId!)
            recipientChildReference.updateChildValues([messageId:"123"])
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendMessage()
        return true
    }
    
    func showChatController(_ user: User) {
       let chatLogViewController = self.storyboard!.instantiateViewController(withIdentifier: "chatLogViewController") as! ChatLogViewController
       self.navigationController?.pushViewController(chatLogViewController, animated: true)
       chatLogViewController.user = user
    }
    
}

extension CurrentDialogViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MessageViewCell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: [indexPath.row]) as! MessageViewCell
        let message = messages[indexPath.row]
        cell.message = message
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let message = messages[indexPath.row]
        
        guard let chatPartnerId = message.chatPartnerId() else { return }
        let ref = Database.database().reference().child("users").child(chatPartnerId)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
            let user = User(dictionary: dictionary)
            self.showChatController(user)
        }, withCancel: nil)
    }
}
