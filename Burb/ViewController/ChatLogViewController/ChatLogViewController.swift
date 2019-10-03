//
//  ChatLogViewController.swift
//  Burb
//
//  Created by Eugene on 06/09/2019.
//  Copyright © 2019 CC_Eugene. All rights reserved.
//

import UIKit
import Firebase

class ChatLogViewController: UIViewController, UITextFieldDelegate {
    
    var messages = [Message]()
    var messagesDictionary = [String: Message]()
    var containerViewBottomAnchor: NSLayoutConstraint?
    var collectionViewBottomAnchor: NSLayoutConstraint?
    
    let cellId = "cellId"

    var user: User? {
        didSet {
            title = "Chat with \(String(describing: (user?.name)!))"
            obseveMessages()
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var inputMessageView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        decorate()
        messageTextField.delegate = self
        hideKeyboardWhenTappedAround()
        collectionView.register(ChatMessageCell.self, forCellWithReuseIdentifier: cellId)
        
        setupKeyboardObservers()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
        
    }
    
    func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func handleKeyboardWillShow(notification: NSNotification) {
        let keyboardFrame = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        let keyboardDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        containerViewBottomAnchor?.constant = -keyboardFrame.height
        collectionViewBottomAnchor?.constant = -keyboardFrame.height
        UIView.animate(withDuration: keyboardDuration) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func handleKeyboardWillHide(notification: NSNotification) {
        containerViewBottomAnchor?.constant = 0
        let keyboardDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        UIView.animate(withDuration: keyboardDuration) {
                  self.view.layoutIfNeeded()
              }
    }
    
    func obseveMessages() {
        guard let uid = Auth.auth().currentUser?.uid, let toId = user?.id else { return }
        let userMessagesRef = Database.database().reference().child("user_messages").child(uid).child(toId)
        userMessagesRef.observe(.childAdded, with: { (snapshot) in
            let messageId = snapshot.key
            let messageRef = Database.database().reference().child("messages").child(messageId)
            messageRef.observe(.value, with: { (snapshot) in
                guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
                let message = Message(dictionary: dictionary)
                
                    print("message we fetched \(message)")
                    self.messages.append(message)
                    
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
            }, withCancel: nil)
        }, withCancel: nil)
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
        let values = ["text": messageTextField.text as Any, "toId": toId!, "fromId": fromId!, "timestamp": timestamp] as [String : Any]
        print("-----------------\(values)")
        
        childRef.updateChildValues(values) { (error, ref) in
            if error != nil {
                print(error!)
                return
            }
            self.messageTextField.text = ""
            let userMessageRef = Database.database().reference().child("user_messages")
            let childReference = userMessageRef.child(fromId!).child(toId!)
            let messageId = childRef.key as! String
            childReference.updateChildValues([messageId:1])
            let recipientUserMessagesRef = Database.database().reference().child("user_messages")
            let recipientChildReference = recipientUserMessagesRef.child(toId!).child(fromId!)
            recipientChildReference.updateChildValues([messageId:1])
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendMessage()
        return true
    }
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    func decorate() {
        self.messageTextField.placeholder = "   Enter message..."
        self.messageTextField.layer.masksToBounds = true
        self.messageTextField.layer.cornerRadius = self.messageTextField.frame.height / 2
        collectionView.alwaysBounceVertical = true
        collectionView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
        tabBarController?.tabBar.isHidden = true
        containerViewBottomAnchor = inputMessageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        collectionViewBottomAnchor = inputMessageView.topAnchor.constraint(equalTo: self.collectionView.bottomAnchor)
        containerViewBottomAnchor?.isActive = true
        collectionViewBottomAnchor?.isActive = true
        collectionView.keyboardDismissMode = .interactive
    }
    
}


extension ChatLogViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ChatMessageCell
        let message = messages[indexPath.item]
        cell.textView.text = message.text
        setupCell(cell: cell, message: message)
        cell.bubbleWidthAnchor?.constant = estemateFrameForText(message.text!).width + 32
        return cell
        
    }
    
    private func setupCell(cell: ChatMessageCell, message: Message) {
        if let profileImage = self.user?.avatarReference {
            cell.profileImageView.loadImageUsingCacheWithUrlString(urlString: profileImage)
        }
        
        if message.fromId == Auth.auth().currentUser?.uid {
            cell.bubbleView.backgroundColor = burbColor
            cell.textView.textColor = .white
            cell.profileImageView.isHidden = true
            cell.bubbleViewRightAnchor?.isActive = true
            cell.bubbleViewLeftAnchor?.isActive = false
        } else {
            cell.bubbleView.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1.0)
            cell.textView.textColor = .black
            cell.profileImageView.isHidden = false
            cell.bubbleViewRightAnchor?.isActive = false
            cell.bubbleViewLeftAnchor?.isActive = true
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat = 80
        if let text = messages[indexPath.row].text {
            height = estemateFrameForText(text).height + 20
        }
        
        
        return CGSize(width: view.frame.width, height: height)
    }
    
    private func estemateFrameForText(_ text: String) -> CGRect {
        let size = CGSize(width: 200, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)], context: nil)
    }
    
}
