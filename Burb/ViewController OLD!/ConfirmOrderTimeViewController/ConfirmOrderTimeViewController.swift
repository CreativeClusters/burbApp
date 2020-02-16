//
//  ConfirmOrderTimeViewController.swift
//  Burb
//
//  Created by Eugene on 11/09/2019.
//  Copyright © 2019 CC_Eugene. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class ConfirmOrderTimeViewController: UIViewController {
    
    var adress: String?
    var date: NSNumber =  NSNumber(value: Date().timeIntervalSince1970)
    
    
    @IBOutlet weak var adressView: UIView!
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        decorate()
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        title = "Date picker"
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.shadowImage = UIImage()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        adressLabel.text = adress
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC: BarbersViewController = segue.destination as! BarbersViewController
        destinationVC.orderTime = self.date
        destinationVC.orderAdress = self.adress
    }
    

    @IBAction func bacButtonPressed(_ sender: UIBarButtonItem) {
       navigationController?.popViewController(animated: true)
    }
    
    @IBAction func confirmTimePressed(_ sender: UIButton) {
      confirmOrderTime()
    }
    
    func confirmOrderTime() {
        let ref = Database.database().reference(fromURL: "https://burb-b8940.firebaseio.com/")
        guard let userID = Auth.auth().currentUser?.uid, self.date != nil else { return }
        let userRefeference = ref.child("orders").child(userID)
        let userValues = ["date": self.date]
        userRefeference.updateChildValues(userValues as [AnyHashable : Any], withCompletionBlock: { (error, ref) in
            if error != nil {
                print(error!)
                return
            }
        })
    }
    
    func decorate() {
        adressView.applyShadowOnViewWithoutCornerRadius(adressView)
    }
    
    
    @IBAction func getTime(_ sender: UIDatePicker) {
        print(sender.date)
        self.date = NSNumber(value: sender.date.timeIntervalSince1970)
    }
    
    
}
