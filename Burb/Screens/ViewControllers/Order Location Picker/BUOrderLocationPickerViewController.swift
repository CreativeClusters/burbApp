//
//  BUOrderLocationPickerViewController.swift
//  Burb
//
//  Created by Eugene on 29.01.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import UIKit
import MapKit

class BUOrderLocationPickerViewController: UIViewController {
    
    var pinImageView: UIImageView?
    var geocoder         = CLGeocoder()
    var locationManager  = CLLocationManager()
    var locationWasShown = false
    var coordinate: CLLocationCoordinate2D?
    
    var longitude: Double?
    var latitude: Double?
    var city: String?
    var adress: String?
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var locationView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var handleButton: UIButton!
    @IBOutlet weak var goNextButton: UIButton!
    
    convenience init(coordinate: CLLocationCoordinate2D?) {
        self.init(nibName: nil, bundle: nil)
        self.coordinate = coordinate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        startManager()
        Decorator.decorate(self)
        setupNextButton()
        addRightBarButton()
        setupSearchBar()
        
    }
    
    @objc func handleSettings() {
        LocationPickerRouter.shared.goToSettingsViaPhoneViewController(from: self)
    }
    
    @objc func handleDatePicker() {
        guard let city = self.city, let adress = self.adress, let long = self.longitude, let lati = self.latitude  else { return }
        OrderLocationPickerInteractor.shared.saveLocationToUserDefaults(city: city, adress: adress, longitude: String(long), latitude: String(lati))
        LocationPickerRouter.shared.goToDatePickerViewController(from: self)
    }
    
    fileprivate func setupSearchBar() {
        let searchImage = UIImage(named: "icPinS")
        searchBar.setImage(searchImage, for: .search, state: .normal)
        searchBar.searchTextField.backgroundColor = .white
        locationView.layer.cornerRadius = self.locationView.layer.frame.height / 4
        locationView.applyShadowOnView(locationView)
    }
    
    fileprivate func addRightBarButton() {
        let buttonImage = UIImage(named: "ic_profile")
        let button = UIBarButtonItem(image: buttonImage, style: .plain, target: self, action: #selector(handleSettings))
        button.tintColor = .gray
        navigationItem.rightBarButtonItem = button
    }
    
    fileprivate func setupNextButton() {
        goNextButton.addTarget(self, action: #selector(handleDatePicker), for: .touchUpInside)
    }
    
    fileprivate func setupSubviews()    {
        mapView.delegate = self 
        mapView.showsUserLocation = true
        mapView.showsCompass = true
    }
    
    fileprivate func startManager() {
        if self.coordinate != nil {
            self.locationWasShown = true
            setRegion(self.coordinate!)
        }
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self as? CLLocationManagerDelegate
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    fileprivate func findAddress(_ location: CLLocation) {
        if geocoder.isGeocoding {
            geocoder.cancelGeocode()
        }
        geocoder.reverseGeocodeLocation(location) { (placeMarks, error) in
            
            guard error == nil else {return}
            
            if let places = placeMarks {
                
                let place  = places[0]
                let street = place.name ?? ""
                let city = place.locality ?? ""
                let long = place.location!.coordinate.longitude
                let lati = place.location!.coordinate.latitude
                    
                print("\(city) + \(street) + \(place.location!.coordinate.latitude) + \(place.location!.coordinate.longitude)")
                

                self.city = "\(city)"
                self.adress = street
                self.longitude = long
                self.latitude = lati
                self.searchBar.text = "\(street)"
            }
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if !locationWasShown {
            locationWasShown = true
            let location = locations.last! as CLLocation
            setRegion(location.coordinate)
            findAddress(location)
        }
    }
    
    fileprivate func setRegion(_ coordinate: CLLocationCoordinate2D) {
        let center = CLLocationCoordinate2D(latitude: coordinate.latitude,
                                            longitude: coordinate.longitude)
        let region = MKCoordinateRegion(center: center,
                                        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.mapView.setRegion(region, animated: true)
    }
    
    
}

extension BUOrderLocationPickerViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        
        pinImageView?.alpha = 1.0
        handleButton.alpha = 1.0
        let coordinate = mapView.convert(self.mapView.center, toCoordinateFrom: self.mapView)
        let location   = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        findAddress(location)
    }
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        pinImageView?.alpha = 0.5
        handleButton.alpha = 0.5
    }

}



extension BUOrderLocationPickerViewController {
    fileprivate class Decorator {
        private init() {}
        
        static func decorate(_ vc: BUOrderLocationPickerViewController) {
            
            vc.searchBar.layer.masksToBounds = true
            vc.navigationController?.isNavigationBarHidden = false

            vc.searchBar.layer.cornerRadius = vc.searchBar.frame.height / 2
                        
            vc.hideKeyboardWhenTappedAround()
            vc.title = "_LOCATIONPICKER"
            vc.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            vc.navigationController?.navigationBar.shadowImage = UIImage()
            vc.navigationController?.navigationBar.isTranslucent = true
            vc.navigationController?.view.backgroundColor = UIColor.clear
            
            
            vc.handleButton.layer.cornerRadius = vc.handleButton.frame.height / 2
            vc.handleButton.backgroundColor = burbColor
            vc.handleButton.setTitle("_IWILLBEHERE", for: .normal)
            vc.handleButton.titleLabel?.font = UIFont(name: "OpenSans-Semibold", size: 15)
            vc.handleButton.tintColor = .white
            
        }
        
    }
    
}

