//
//  CreateUserViewController.swift
//  Burb
//
//  Created by Eugene on 23/08/2019.
//  Copyright © 2019 CC_Eugene. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class CreateUserViewController: UIViewController {

    var registerModel = RegisterModel()
    var role: String?
    
    @IBOutlet weak var avatarView: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var compliteButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var upView: UIView!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var downView: UIView!
    @IBOutlet weak var middleView: UIView!
    
    
    override func viewDidLoad() {
        title = "Client"
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        decorate()
        hideKeyboardWhenTappedAround()
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.shadowImage = UIImage()
    }

    func animateController() {
        
        UIView.animate(withDuration: 2, animations: {
            let success = UIImage(named: "success.png")
            let successView = UIImageView(image: success)
            
            let welcomeLabel = UILabel(frame: CGRect(x: self.view.frame.midX-95, y: self.view.frame.midY, width: 220, height: 20))
            welcomeLabel.text = "Welcome to Burb!"
            welcomeLabel.font = UIFont(name: "OpenSans", size: 25)
            self.compliteButton.alpha = 0
            self.phoneNumberTextField.alpha = 0
            self.nameTextField.alpha = 0
            self.nameLabel.alpha = 0
            self.phoneLabel.alpha = 0
            self.upView.alpha = 0
            self.downView.alpha = 0
            self.avatarView.frame = CGRect(x: self.view.frame.midX-70, y: self.view.frame.midY-240, width: self.avatarView.frame.width, height: self.avatarView.frame.height)
            self.middleView.alpha = 0
            successView.frame.size.height = self.imageView.frame.size.height - 10
            successView.frame.size.width = self.imageView.frame.size.width - 10
            successView.center = CGPoint(x: self.imageView.frame.size.width  / 2,
                                         y: self.imageView.frame.size.height / 2)
            successView.alpha = 0.7
            self.imageView.addSubview(successView)
            self.view.addSubview(welcomeLabel)
        }, completion: {
            finished in
            self.compliteButton.isHidden = true
            self.phoneNumberTextField.isHidden = true
            self.nameTextField.isHidden = true
            self.nameLabel.isHidden = true
            self.phoneLabel.isHidden = true
            self.upView.isHidden = true
            self.downView.isHidden = true
            self.middleView.isHidden = true
        })
    }
    
    
    func goToClientRole() {
        UIView.animate(withDuration: 1, animations: {
        }, completion: {
            finished in
            let clientTabbarVC: ClientTabbarController = self.storyboard!.instantiateViewController(withIdentifier: "clientTabbarController") as! ClientTabbarController
            clientTabbarVC.modalPresentationStyle = .overFullScreen
            self.present(clientTabbarVC, animated: true, completion: nil)
        })
    }
    
    
    func saveClientData() {
        let ref = Database.database().reference(fromURL: "https://burb-b8940.firebaseio.com/")
        guard let userID = Auth.auth().currentUser?.uid, self.nameTextField.text != nil else { return }
        let userRefeference = ref.child("users").child(userID)
        let userValues = ["name": self.nameTextField.text]
        userRefeference.updateChildValues(userValues as [AnyHashable : Any], withCompletionBlock: { (error, ref) in
            if error != nil {
                print(error!)
                return
            }
        })
    }
    
    @IBAction func compliteButtonTapped(_ sender: UIButton) {
        
            self.saveAvatar()
            self.saveClientData()

    
        DispatchQueue.main.async {
            self.animateController()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0, execute: {
            self.goToClientRole()
        })
        
    }
    
    
    func saveAvatar() {
        let imageName = NSUUID().uuidString
        let storageReference = Storage.storage().reference().child("user_avatars").child("\(imageName).png")
        let uploadImage: NSData = imageView.image!.jpegData(compressionQuality: 0.2)! as NSData
        storageReference.putData(uploadImage as Data, metadata: nil) { (metadata: StorageMetadata?, error: Error?) in
            if error != nil {
                print(error as Any)
                return
            }
            
            storageReference.downloadURL(completion: { (url, error) in
                if error != nil {
                    print(error!)
                } else {
                    
                    let downloadUrl = url?.absoluteString
                    let ref = Database.database().reference()
                    guard let userID = Auth.auth().currentUser?.uid, downloadUrl != nil else { return }
                    let userRefeference = ref.child("users").child(userID)
                    let userValues: Dictionary<String, Any> = ["avatarReference": downloadUrl!]
                    userRefeference.updateChildValues(userValues as [AnyHashable : Any], withCompletionBlock: { (error, ref) in
                        if error != nil {
                            print(error!)
                            return
                        }
                    })
                    print("this is DOWNLOADURL  \(String(describing: downloadUrl))")
                }
            })
        }
        
    }
    

    @IBAction func backButton(_ sender: UIBarButtonItem) {
       navigationController?.popViewController(animated: true)
    }
    
    
    
    func fetchData() {
        let uid = Auth.auth().currentUser?.uid
    Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value) { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                self.phoneNumberTextField.text = dictionary["phone"] as? String
            }
        }
    }
    
    
    
    
  
   @objc func chooseImage() {
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

extension CreateUserViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
            imageView.image = selectedImage
        }
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}


extension CreateUserViewController {
    func decorate() {
        imageView.image = UIImage(named: "add_512")
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.clipsToBounds = true
        let tapImage = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageView.addGestureRecognizer(tapImage)
        avatarView.clipsToBounds = true
        avatarView.layer.masksToBounds = true
        avatarView.layer.borderColor = burbColor.cgColor
        avatarView.layer.borderWidth = 3
        avatarView.layer.cornerRadius = self.avatarView.frame.width / 2
        compliteButton.layer.cornerRadius = self.compliteButton.frame.height / 2
    }
}
