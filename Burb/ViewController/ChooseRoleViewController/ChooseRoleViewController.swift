//
//  ChooseRoleViewController.swift
//  Burb
//
//  Created by Eugene on 21/08/2019.
//  Copyright © 2019 CC_Eugene. All rights reserved.
//

import UIKit
import Firebase

class ChooseRoleViewController: UIViewController {
   
    
    @IBOutlet weak var clientView: UIView!
    @IBOutlet weak var barberView: UIView!
    @IBOutlet weak var clientImageView: UIImageView!
    @IBOutlet weak var barberImageView: UIImageView!
    @IBOutlet weak var clientButton: UIButton!
    @IBOutlet weak var barberButton: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
      tapActions()
        self.title = "Choose your role"
        self.navigationController?.isNavigationBarHidden = false
        customizeViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.shadowImage = UIImage()
    }

    func tapActions() {
        self.clientImageView.isUserInteractionEnabled = true
        self.barberImageView.isUserInteractionEnabled = true
        let tapBarber = UITapGestureRecognizer(target: self, action: #selector(self.barberAction))
        let tapClient = UITapGestureRecognizer(target: self, action: #selector(self.clientAction))
        self.clientImageView.addGestureRecognizer(tapClient)
        self.barberImageView.addGestureRecognizer(tapBarber)
    }
    
    @objc func barberAction() {
        print("barber is select!")
        clientImageView.image = UIImage(named: "client_b")
        barberImageView.image = UIImage(named: "barber_a")
        clientView.layer.borderWidth = 0
        barberView.layer.borderWidth = 3
        clientButton.isEnabled = false
        barberButton.isEnabled = true
        
    }
    
    @objc func clientAction() {
        print("client is selected!")
        barberImageView.image = UIImage(named: "barber_b")
        clientImageView.image = UIImage(named: "client_a")
        clientView.layer.borderWidth = 3
        barberView.layer.borderWidth = 0
        clientButton.isEnabled = true
        barberButton.isEnabled = false
    }
    
    @IBAction func clientActionTapped(_ sender: UIButton) {
        let ref = Database.database().reference(fromURL: "https://burb-b8940.firebaseio.com/")
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let userRefeference = ref.child("users").child(userID)
        let userValues = ["role": "client"]
        userRefeference.updateChildValues(userValues as [AnyHashable : Any], withCompletionBlock: { (error, ref) in
            if error != nil {
                print(error!)
                return
            }
        })
    }
    
    
    @IBAction func barberActionTapped(_ sender: UIButton) {
        let ref = Database.database().reference(fromURL: "https://burb-b8940.firebaseio.com/")
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let userRefeference = ref.child("users").child(userID)
        let userValues = ["role": "barber"]
        userRefeference.updateChildValues(userValues as [AnyHashable : Any], withCompletionBlock: { (error, ref) in
            if error != nil {
                print(error!)
                return
            }
        })
    }
    
    func customizeViews() {
        clientView.clipsToBounds = true
        clientView.layer.masksToBounds = true
        clientView.layer.borderColor = burbColor.cgColor
        clientView.layer.borderWidth = 3
        clientView.layer.cornerRadius = self.clientView.frame.width / 2
        barberView.clipsToBounds = true
        barberView.layer.masksToBounds = true
        barberView.layer.borderColor = burbColor.cgColor
        barberView.layer.borderWidth = 0
        barberView.layer.cornerRadius = self.clientView.frame.width / 2
    }
}
