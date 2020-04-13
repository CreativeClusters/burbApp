//
//  BUSpecifyCityViewController.swift
//  Burb
//
//  Created by Eugene on 09.04.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit
import MapKit

class BUSpecifyCityViewController: UIViewController, CLLocationManagerDelegate {
    
    fileprivate enum CellModel {
        case pictureWithAvatar
        case city
        case textView
        case button
    }
    
    fileprivate enum HeaderModel {
        typealias CellType = CellModel
        case pictureWithAvatar
        case city
        case textView
        case button
        
        var cellModels: [BUSpecifyCityViewController.CellModel] {
            switch self {
            case .pictureWithAvatar: return [.pictureWithAvatar]
            case .city: return [.city]
            case .textView: return [.textView]
            case .button: return [.button]
            }
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    
    private var currentBarber: BarberSQL?
    private var city: String?
    private var model: [CellModel] = [.pictureWithAvatar, .city, .textView, .button]
    private var headerModel: [HeaderModel] = [.pictureWithAvatar, .city, .textView, .button]
    
    fileprivate var geocoder         = CLGeocoder()
    fileprivate var locationManager  = CLLocationManager()
    fileprivate var locationWasShown = false
    fileprivate var coordinate: CLLocationCoordinate2D?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Decorator.decorate(self)
        delegating()
        registerCells()
        initIfavailable()
        startManager()
    }
    
    private func initIfavailable() {
        SpecifyCityInteractor.shared.fetchBarberSQL { (data) in
            self.currentBarber = data
        }
    }
    
    
    fileprivate func startManager() {
        
        if self.coordinate != nil {
            self.locationWasShown = true
        }
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    fileprivate func findAddress(_ location: CLLocation) {
        if geocoder.isGeocoding {
            geocoder.cancelGeocode()
        }
        geocoder.reverseGeocodeLocation(location) { (plaseMarks, error) in
            
            guard error == nil else {return}
            
            if let places = plaseMarks {
                
                let place  = places[0]
                let city   = place.locality ?? ""
                
                self.city = city
                if self.city != "" {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if !locationWasShown {
            locationWasShown = true
            let location = locations.last! as CLLocation
            findAddress(location)
        }
    }
    
    private func handlePricing() {
    
        guard let barberCity = self.city, let barberId = self.currentBarber?.id else { return }
        SpecifyCityInteractor.shared.saveCityData(with: barberId, city: barberCity)
        SpecifyCityRouter.shared.handleBarberPricing(from: self)
        
       }
    
    
    private func delegating() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    private func registerCells() {
        self.tableView.register(CityAvatarTableViewCell.nib, forCellReuseIdentifier: CityAvatarTableViewCell.name)
        self.tableView.register(BUTextFieldTableViewCell.nib, forCellReuseIdentifier: BUTextFieldTableViewCell.name)
        self.tableView.register(BUTextViewTableViewCell.nib, forCellReuseIdentifier: BUTextViewTableViewCell.name)
        self.tableView.register(BUButtonTableViewCell.nib, forCellReuseIdentifier: BUButtonTableViewCell.name)
    }
    
}

extension BUSpecifyCityViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headerModel[section].cellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let models = headerModel[indexPath.section].cellModels[indexPath.row]
        switch models {
        case .pictureWithAvatar:
            if let cell = self.tableView.dequeueReusableCell(withIdentifier: CityAvatarTableViewCell.name, for: indexPath) as? CityAvatarTableViewCell {
                if let currentBarberPhoto = UIImage(data: (self.currentBarber?.photo)!) {
                  cell.avatarImageView.image = currentBarberPhoto
                }
                return cell
            }
        case .city:
            if let cell = self.tableView.dequeueReusableCell(withIdentifier: BUTextFieldTableViewCell.name, for: indexPath) as? BUTextFieldTableViewCell {
                cell.textField.font = UIFont(name: "OpenSans", size: 24)
                cell.textField.textColor = UIColor(red: 50.0/255.0, green: 50.0/255.0, blue: 50.0/255.0, alpha: 1.0)
                cell.textField.text = self.city
                cell.textField.placeholder = "_YOURCITY"
                cell.textChanged = {
                    text in
                    self.city = text
                    self.tableView.reloadData()
                }
                return cell
            }
        case .textView:
            if let cell = self.tableView.dequeueReusableCell(withIdentifier: BUTextViewTableViewCell.name, for: indexPath) as? BUTextViewTableViewCell {
                cell.setFont(font: UIFont(name: "OpenSans", size: 15)!)
                cell.setColor(color: UIColor(red: 50.0/255.0, green: 50.0/255.0, blue: 50.0/255.0, alpha: 1.0))
                cell.setText(text: "_Turn_your_location_services_on_and_enter_your_address")
                return cell
            }
        case .button:
            if let cell = self.tableView.dequeueReusableCell(withIdentifier: BUButtonTableViewCell.name, for: indexPath) as? BUButtonTableViewCell {
                cell.button.setTitle("_CONFIRM", for: .normal)
                cell.setColor(color: burbColor)
                cell.setFont(font: UIFont(name: "OpenSans-Semibold", size: 15)!)
                cell.button.tintColor = .white
                cell.buttonHandler = {
                    self.handlePricing()
                }
                return cell
            }
        }
        return UITableViewCell.init()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let models = headerModel[indexPath.section].cellModels[indexPath.row]
        switch models {
        case .pictureWithAvatar:
            return self.view.frame.height / 3
        case .city:
            return self.view.frame.height / 7
        case .textView:
            return self.view.frame.height / 10
        case .button:
            return self.view.frame.height / 10
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let headerModels = headerModel[section]
        switch headerModels {
        case .pictureWithAvatar:
            return 0
        case .city:
            return 0
        case .textView:
            return 0
        case .button:
            return self.view.frame.height / 7
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerModels = headerModel[section]
        switch headerModels {
        case .pictureWithAvatar, .city, .textView, .button:
            let view = HeaderView.loadFromNib()
            return view
        }
    }
    
    
}


extension BUSpecifyCityViewController {
    fileprivate class Decorator {
        private init() {}
        static func decorate(_ vc: BUSpecifyCityViewController) {
            vc.title = "_YOURCITY"
            vc.navigationController?.navigationBar.barTintColor = UIColor.white
            vc.navigationController?.navigationBar.shadowImage = UIImage()
            vc.hideKeyboardWhenTappedAround()
        }
    }
}
