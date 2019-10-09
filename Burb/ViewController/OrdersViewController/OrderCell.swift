//
//  OrderCell.swift
//  Burb
//
//  Created by Eugene on 12/09/2019.
//  Copyright © 2019 CC_Eugene. All rights reserved.
//

import UIKit
import MapKit
import Firebase

class OrderCell: UITableViewCell, CLLocationManagerDelegate {
    
    var order: Order?
    
    
    
     var pinImageView: UIImageView?
     var geocoder         = CLGeocoder()
     var locationManager  = CLLocationManager()
     var locationWasShown = false
    lazy var coordinate = CLLocationCoordinate2D()
     var pinShowImageView: UIImageView?
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var adressTextField: UITextField!
    @IBOutlet weak var frameView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    

    override func awakeFromNib() {
       
        fetchDataForGeo()
        super.awakeFromNib()
        selectionStyle = .none
        decorate()
        mapView.delegate = self
        setupPin()
        startManager()
        print("lati \(String(describing: coordinate.latitude)) + long \(String(describing: coordinate.longitude))")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }


    func fetchDataForGeo() {
        Database.database().reference().child("orders").observe(.childAdded) { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let order = Order(dictionary: dictionary)
                print(order)
                self.coordinate.longitude = dictionary["longitude"] as! CLLocationDegrees
                self.coordinate.latitude = dictionary["latitude"] as! CLLocationDegrees
            }
        }
    }
    
    
     func setupPin() {
        
        if let pinImage = UIImage(named: "pin.png") {
            pinShowImageView?.image = pinImage
            pinImageView?.center = CGPoint(x: mapView.center.x, y: mapView.center.y - pinImage.size.height / 2.0)
            
        }
        
            if coordinate != nil {
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                mapView.addAnnotation(annotation)
                findAddress(CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude))
        }
    }
    
     func startManager() {
        
        if self.coordinate != nil, self.coordinate.latitude != 0.0 && self.coordinate.longitude != 0.0  {
            self.locationWasShown = true
            setRegion(self.coordinate)
            print("here is coordinate \(self.coordinate)")
        }
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
     func findAddress(_ location: CLLocation) {
        if geocoder.isGeocoding {
            geocoder.cancelGeocode()
        }
        geocoder.reverseGeocodeLocation(location) { (plaseMarks, error) in
            guard error == nil else {return}
                
            }
        }
    
    
       func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
//        if !locationWasShown {
//
//                 locationWasShown = true
//
//                 let location = locations.last! as CLLocation
//                 setRegion(location.coordinate)
//                 findAddress(location)
//             }
        
         findAddress(CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude))
    }

    
        
         func setRegion(_ coordinate: CLLocationCoordinate2D) {
            let center = CLLocationCoordinate2D(latitude: coordinate.latitude,
                                                longitude: coordinate.longitude)
            let region = MKCoordinateRegion(center: center,
                                            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            
            self.mapView.setRegion(region, animated: true)
        }
   
    
    func decorate() {
        cellView.applyShadowOnView(cellView)
        frameView.clipsToBounds = true
        frameView.layer.masksToBounds = true
        frameView.layer.borderColor = burbColor.cgColor
        frameView.layer.borderWidth = 2
        frameView.layer.cornerRadius = self.frameView.frame.width / 2
        avatarImageView.contentMode = .scaleToFill
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height / 2
        avatarImageView.clipsToBounds = true
        mapView.roundCorners([.bottomLeft, .bottomRight], radius: 8)
    }
    
    @IBAction func detailOrderSegue(_ sender: UIButton) {
              print("lati \(String(describing: coordinate.latitude)) + long \(String(describing: coordinate.longitude))")
    }
}


extension OrderCell: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
            pinImageView?.alpha = 1.0
            let coordinate = mapView.convert(self.mapView.center, toCoordinateFrom: self.mapView)
            let location   = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
            findAddress(location)
    }
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
            pinImageView?.alpha = 0.5
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            //return nil so map view draws "blue dot" for standard user location
            return nil
        }
        
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        if pinView == nil {
            pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            
            let PinImage = UIImage(named:"pin.png")!
            pinView!.image = PinImage
            pinView?.frame = CGRect(x: 0, y: 0, width: 27, height: 36)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
}
