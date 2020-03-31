//
//  BarbersViewController.swift
//  Burb
//
//  Created by Eugene on 28/08/2019.
//  Copyright © 2019 CC_Eugene. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class BarbersViewController: UIViewController {
    
    var segment: Int = 1
    let segmentControl = UISegmentedControl()
    var orderTime: NSNumber =  NSNumber(value: Date().timeIntervalSince1970)
    var orderAdress: String?
    var users = [Customer]()
    var selectedBarber: Customer?
    
    @IBOutlet weak var informationView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegates()
        fetchUsers()
        decorate()
        fillLabels()
        addSegmentControllToNavigationBar()
        registerCell()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        title = "Available barbers"
        navigationController?.isNavigationBarHidden = false 
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
         collectionView.contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    
    func delegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func registerCell() {
    collectionView!.register(UINib(nibName: "BarberDetailViewCell", bundle: nil), forCellWithReuseIdentifier: "barberDetailCell")
    }
    
    func fetchUsers() {
        Database.database().reference().child("users").observe(.childAdded) { (snapshot) in

            if let dictionary = snapshot.value as? [String: AnyObject] {
              //  let user = Customer.
                let names = dictionary["name"] as? String
                let avatars = dictionary["avatarReference"] as? String
//                user.id = snapshot.key
//                user.name = names
//                user.avatarReference = avatars
//                self.users.append(user)
                DispatchQueue.main.async {
                self.collectionView.reloadData()
                }
            }
        }
    }
    
    
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    func addSegmentControllToNavigationBar() {
        let segmentControl: UISegmentedControl = UISegmentedControl(items: ["List", "View"])
        segmentControl.sizeToFit()
        segmentControl.tintColor = burbColor
        segmentControl.selectedSegmentIndex = 0;
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "OpenSans-Semibold", size: 15)!], for: .normal)
        segmentControl.addTarget(self, action: #selector(changeView(sender:)), for: .valueChanged)
        self.navigationItem.titleView = segmentControl
    }
    
    
    @objc func changeView(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
             segment = 1
             UserDefaults.standard.setValue(segment, forKey:"segment")
             UserDefaults.standard.synchronize()
                    
        case 1:
                segment = 0
                UserDefaults.standard.setValue(segment, forKey:"segment")
                UserDefaults.standard.synchronize()
        default:
            break
        }
        self.collectionView.reloadData()
    }
    
    

    
    func fillLabels() {
        self.adressLabel.text = orderAdress
        let exactDate = NSDate(timeIntervalSince1970: TimeInterval(truncating: orderTime))
        self.timeLabel.text = exactDate.toString(dateFormat: "MMM d, h:mm a")
    }
    
    
    func decorate() {
        self.informationView.applyShadowOnViewWithoutCornerRadius(informationView)
        self.collectionView.backgroundColor = .white
    }
    
    
    func showCurrentOrder(_ barber: User) {
//        let OrdersViewController = self.storyboard!.instantiateViewController(withIdentifier: "OrdersViewController") as! OrdersViewController
//        self.navigationController?.pushViewController(OrdersViewController, animated: true)
//        OrdersViewController.barber = barber
    }
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        if self.selectedBarber !=  nil {
      //     showCurrentOrder(self.selectedBarber!)
        } else {
            print("we get nil, Milord!")
        }
    }
    
    
}


extension BarbersViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch segment {
        case 0:
            print("case 0")
            let cell1: BarberDetailViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "barberDetailCell", for: [indexPath.row]) as! BarberDetailViewCell
            
             self.collectionView.bounces = false
            if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .horizontal
                self.collectionView.isPagingEnabled = true
                layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                layout.minimumInteritemSpacing = 0
                layout.minimumLineSpacing = 0
                self.collectionView.backgroundColor = .lightGray
            }
            
                let user = users[indexPath.row]
                cell1.nameTextField.text = user.name
                cell1.imageView.image = UIImage(named: "user.png")
                cell1.imageView.contentMode = .scaleAspectFill
                cell1.imageView.layer.cornerRadius = cell1.imageView.frame.height / 2
                cell1.imageView.layer.masksToBounds = true
                if let avatarReferenceURL = user.avatarReference {
                    cell1.imageView.loadImageUsingCacheWithUrlString(urlString: avatarReferenceURL)
                }
                return cell1
        default:
            print("case 1")
            let cell0: BarberViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "barberCell", for: [indexPath.row]) as! BarberViewCell
            
             self.collectionView.bounces = true
            if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .vertical
                self.collectionView.isPagingEnabled = false
                collectionView.alwaysBounceVertical = true
                 collectionView.contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
                layout.minimumInteritemSpacing = 10
                layout.minimumLineSpacing = 10
            }
            self.collectionView.backgroundColor = .white
            let user = users[indexPath.row]
            cell0.nameTextView.text = user.name
            cell0.profileImage.image = UIImage(named: "user.png")
            cell0.profileImage.contentMode = .scaleAspectFill
            cell0.profileImage.layer.cornerRadius = cell0.profileImage.frame.height / 2
            cell0.profileImage.layer.masksToBounds = true
            if let avatarReferenceURL = user.avatarReference {
                cell0.profileImage.loadImageUsingCacheWithUrlString(urlString: avatarReferenceURL)
            }
            return cell0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch segment {
        case 0:
            return CGSize(width: self.collectionView.frame.size.width, height: self.collectionView.frame.size.height)
        default:
            break
        }
        return CGSize(width: 100, height: 163)
    }
    
    
      func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let barber = self.users[indexPath.row]
        self.selectedBarber = barber
        let ref = Database.database().reference(fromURL: "https://burb-b8940.firebaseio.com/")

        guard let userID = Auth.auth().currentUser?.uid, barber.id != nil, barber.avatarReference != nil, barber.name != nil  else { return }
        let userRefeference = ref.child("orders").child(userID)
        let userValues = ["barberId": barber.id, "barberAvatar": barber.avatarReference, "barberName": barber.name]
        userRefeference.updateChildValues(userValues as [AnyHashable : Any], withCompletionBlock: { (error, ref) in
            if error != nil {
                print(error!)
                return
            }
        })

    }

}
