//
//  OrdersViewController.swift
//  Burb
//
//  Created by Eugene on 12/09/2019.
//  Copyright © 2019 CC_Eugene. All rights reserved.
//

import UIKit
import Firebase
import MapKit
import FirebaseDatabase

class OrdersViewController: UIViewController {

    var barber: User?
    var orders = [Order]()
    var currentOrder: Order?

    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        print("init class")
        super.viewDidLoad()
        fetchOrders()
        cancelButton.tintColor = .clear
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func fetchOrders() {
        Database.database().reference().child("orders").observe(.childAdded) { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let order = Order(dictionary: dictionary)
                print(order)
                self.currentOrder = order
                self.orders.append(order)               
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC: DetailOrderViewController = segue.destination as! DetailOrderViewController
        destinationVC.order = self.currentOrder
    }
    
}

extension OrdersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: OrderCell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: [indexPath.row]) as! OrderCell
        let order = orders[indexPath.row]
        
        let exactDate = NSDate(timeIntervalSince1970: TimeInterval(truncating: order.date!))
        cell.coordinate.latitude = order.latitude!
        cell.coordinate.longitude = order.longitude!
        cell.dateTextField.text = exactDate.toString(dateFormat: "MMM d, h:mm a")
        cell.adressTextField.text = order.adress
        cell.nameTextField.text = order.barberName
        cell.descriptionTextView.text = order.descriptionOrder
        if let avatarReferenceURL = order.barberAvatar {
            cell.avatarImageView.loadImageUsingCacheWithUrlString(urlString: avatarReferenceURL)
        }
        
        
        return cell
    }
    
}


extension Double {
    func toString() -> String {
        return NumberFormatter().string(from: NSNumber(value: self)) ?? ""
    }
}

extension NSNumber {
    func toString() -> String {
        return NumberFormatter().string(from: self) ?? ""
    }
}

