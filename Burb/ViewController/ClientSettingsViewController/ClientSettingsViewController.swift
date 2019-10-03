//
//  ClientSettingsViewController.swift
//  Burb
//
//  Created by Eugene on 27/08/2019.
//  Copyright © 2019 CC_Eugene. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ClientSettingsViewController: UIViewController {
     
    @IBOutlet weak var tableView: UITableView!
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        tableView.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.bounces = false
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = "Settings"
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.shadowImage = UIImage()
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            let cell: CommonSettingsCell = (self.tableView.dequeueReusableCell(withIdentifier: "commonSettings") as? CommonSettingsCell)!
            cell.fillCell()
        }
        
    }
    
    @IBAction func checkUser(_ sender: UIButton) {
//        let UID = Auth.auth().currentUser?.uid
//        let userReference = Database.database().reference().child("users").child(UID!)
//        userReference.observe(.value) { (snapshot) in
//            guard let value = snapshot.value, snapshot.exists() else {
//                print("Error with getting data")
//                return
//            }
//            print("value: \(value)")
//        }
        
    }
    
    

    

    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        if Auth.auth().currentUser == nil {
            perform(#selector(showLoginViewController), with: nil, afterDelay: 0)
        }
    }
    
    
    
    
 
    
    @objc func showLanguagesMenu() {
        let changeClientSettingsViewController = self.storyboard!.instantiateViewController(withIdentifier: "changeClientSettingsViewController") as! ChangeClientSettingsViewController
        self.present(changeClientSettingsViewController, animated: true, completion: nil)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC: ChangeClientSettingsViewController = segue.destination as! ChangeClientSettingsViewController
        destinationVC.settingsType = .chooseDateNotification
    }
    
    
    
    @objc func showLoginViewController() {
        
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        let loginViewController = LoginViewController()
        present(loginViewController, animated: true, completion: nil)
    }

}

extension ClientSettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        
        
        switch indexPath.row {
        case 0:
            let cell: UserInfoCell = (tableView.dequeueReusableCell(withIdentifier: "userInfoCell", for: [indexPath.row]) as? UserInfoCell)!
                return cell
        case 1:
            let cell: CommonSettingsTitleCell = (tableView.dequeueReusableCell(withIdentifier: "titleCommonSettings", for: [indexPath.row]) as? CommonSettingsTitleCell)!
                return cell
        case 2:
            let cell: CommonSettingsCell = (tableView.dequeueReusableCell(withIdentifier: "commonSettings", for: [indexPath.row]) as? CommonSettingsCell)!
            return cell
        case 3:
            let cell: SignOutCell = (tableView.dequeueReusableCell(withIdentifier: "signOutCell", for: [indexPath.row]) as? SignOutCell)!
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    

}

