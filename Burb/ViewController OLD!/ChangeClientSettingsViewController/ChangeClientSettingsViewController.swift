//
//  ChangeClientSettingsViewController.swift
//  Burb
//
//  Created by Eugene on 25/09/2019.
//  Copyright © 2019 CC_Eugene. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
enum ClienSettings {
    case chooseDateNotification
    case chooseLanguage
}

class ChangeClientSettingsViewController: UIViewController {


    let languages = ["English","Русский"]
    let recievedNotification = ["24h before","10h before","5h before","2h before"]
    var settingsType: ClienSettings = .chooseDateNotification
   
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        decorate()
        switchTitles()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    func registerCells(){
        tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "settingsCell")
    }

    
    @IBAction func backButtonPressed(_ sender: Any) {
        goBack()
    }
    

    func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    
    func switchTitles() {
        switch settingsType {
        case .chooseDateNotification:
            self.title = "Fertilized notification"
        case .chooseLanguage:
            self.title = "Select language"
        }
    }
    
    func decorate() {
        tableView.bounces = false
        tableView.tableFooterView = UIView()
        
    }

    
}

extension ChangeClientSettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch settingsType {
        case .chooseDateNotification:
            return recievedNotification.count
        case .chooseLanguage:
            return languages.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath)
        switch settingsType {
        case .chooseDateNotification:
            cell.textLabel?.text = recievedNotification[indexPath.row]
        case .chooseLanguage:
            cell.textLabel?.text = languages[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
            
            let ref = Database.database().reference(fromURL: "https://burb-b8940.firebaseio.com/")
            guard let userID = Auth.auth().currentUser?.uid, cell.textLabel!.text != nil else { return }
            let userRefeference = ref.child("users").child(userID)
            
            
            switch settingsType {
            case .chooseDateNotification:
                    let userValues = ["notifications": cell.textLabel!.text]
                userRefeference.updateChildValues(userValues as [AnyHashable : Any], withCompletionBlock: { (error, ref) in
                    if error != nil {
                        print(error!)
                        return
                    }
                })
                
                   goBack()
            case .chooseLanguage:
                let userValues = ["language": cell.textLabel!.text]
                userRefeference.updateChildValues(userValues as [AnyHashable : Any], withCompletionBlock: { (error, ref) in
                    if error != nil {
                        print(error!)
                        return
                    }
                })
                goBack()
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }
}


