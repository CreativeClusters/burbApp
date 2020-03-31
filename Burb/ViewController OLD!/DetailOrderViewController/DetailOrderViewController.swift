////
////  DetailOrderViewController.swift
////  Burb
////
////  Created by Eugene on 18/09/2019.
////  Copyright © 2019 CC_Eugene. All rights reserved.
////
//
//import UIKit
//import MapKit
//
//class DetailOrderViewController: UIViewController, CLLocationManagerDelegate {
//
//    var order: Order?
//
//    fileprivate var pinImageView: UIImageView?
//    fileprivate var geocoder         = CLGeocoder()
//    fileprivate var locationManager  = CLLocationManager()
//    fileprivate var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D.init(latitude: 55.7286352, longitude: 37.6628627)
//    fileprivate var pinShowImageView: UIImageView?
//    fileprivate var locationWasShown = false
//
//    @IBOutlet weak var frameView: UIView!
//    @IBOutlet weak var imageView: UIImageView!
//
//    @IBOutlet weak var nameTextField: UITextField!
//    @IBOutlet weak var dateTextField: UITextField!
//    @IBOutlet weak var detailTextField: UITextView!
//    @IBOutlet weak var adressTextField: UITextField!
//
//    @IBOutlet weak var callButton: UIButton!
//    @IBOutlet weak var writeButton: UIButton!
//
//    @IBOutlet weak var separatorView: UIView!
//    @IBOutlet weak var mapView: MKMapView!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        decorate()
//        fillData()
//        mapView.delegate = self
//        mapView.showsCompass = true
//        setupPin()
//        startManager()
//    }
//
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.tabBarController?.tabBar.isHidden = true
//    }
//
//    fileprivate func setupPin() {
//
//        if let pinImage = UIImage(named: "pin.png") {
//            pinShowImageView?.image = pinImage
//            pinImageView?.center = CGPoint(x: mapView.center.x, y: mapView.center.y - pinImage.size.height / 2.0)
//
//        }
//
//        if coordinate != nil {
//            let annotation = MKPointAnnotation()
//            annotation.coordinate = coordinate
//            mapView.addAnnotation(annotation)
//            findAddress(CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude))
//        }
//    }
//
//    fileprivate func startManager() {
//
//        if self.coordinate != nil {
//            self.locationWasShown = true
//            setRegion(self.coordinate)
//        }
//        if CLLocationManager.locationServicesEnabled() {
//            locationManager.delegate = self
//            locationManager.desiredAccuracy = kCLLocationAccuracyBest
//            locationManager.requestAlwaysAuthorization()
//            locationManager.startUpdatingLocation()
//        }
//    }
//
//    fileprivate func findAddress(_ location: CLLocation) {
//        if geocoder.isGeocoding {
//            geocoder.cancelGeocode()
//        }
//        geocoder.reverseGeocodeLocation(location) { (plaseMarks, error) in
//
//            //            guard error == nil else {return}
//            //
//            //            if let plases = plaseMarks {
//            //
//            //                let plase  = plases[0]
//            //                let street = plase.name ?? ""
//            //                let city   = plase.locality ?? ""
//            //                var location: GeoPoint?
//            //
//            //                if let coordinate = plase.location?.coordinate {
//            //                    let point = GEO_POINT(latitude: coordinate.latitude, longitude: coordinate.longitude)
//            //                    location  = GeoPoint(point: point)
//            //                }
//            //
//            //                self.address.street   = street
//            //                self.address.city     = city
//            //                self.address.location = location
//            //
//            //                self.textField.text = street
//            //            }
//        }
//    }
//
//    fileprivate func setRegion(_ coordinate: CLLocationCoordinate2D) {
//        let center = CLLocationCoordinate2D(latitude: coordinate.latitude,
//                                            longitude: coordinate.longitude)
//        let region = MKCoordinateRegion(center: center,
//                                        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
//
//        self.mapView.setRegion(region, animated: true)
//    }
//
//    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
//        navigationController?.popViewController(animated: true)
//    }
//
//
//    @IBAction func callButtonPressed(_ sender: UIButton) {
//    }
//
//    @IBAction func writeButtonPressed(_ sender: UIButton) {
//    }
//
//
//    @IBAction func cancelOrderButtonPressed(_ sender: UIButton) {
//    }
//
//    func decorate() {
//        writeButton.round(button: writeButton)
//        callButton.round(button: callButton)
//        writeButton.applyShadowOnViewWithoutCornerRadius(writeButton)
//        callButton.applyShadowOnViewWithoutCornerRadius(callButton)
//
//        let name = self.order?.barberName!.components(separatedBy: " ").first?.uppercased()
//        writeButton.setTitle("WRITE \(String(describing: (name)!))", for: .normal)
//        callButton.setTitle("CALL \(String(describing: (name)!))", for: .normal)
//
//        separatorView.applyShadowOnViewWithoutCornerRadius(separatorView)
//        frameView.setFrameBurb(view: frameView)
//
//        imageView.clipsToBounds = true
//        imageView.layer.cornerRadius = self.imageView.frame.height / 2
//        imageView.contentMode = .scaleToFill
//    }
//
//    func fillData() {
//        nameTextField.text = self.order?.barberName
//        detailTextField.text = self.order?.descriptionOrder
//        adressTextField.text = self.order?.adress
//        let exactDate = NSDate(timeIntervalSince1970: TimeInterval(truncating: self.order!.date!))
//        dateTextField.text = exactDate.toString(dateFormat: "MMM d, h:mm a")
//        if let avatarReferenceURL = order!.barberAvatar {
//            imageView.loadImageUsingCacheWithUrlString(urlString: avatarReferenceURL)
//        }
//    }
//
//}
//
//extension DetailOrderViewController: MKMapViewDelegate {
//
//    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
//        pinImageView?.alpha = 1.0
//        let coordinate = mapView.convert(self.mapView.center, toCoordinateFrom: self.mapView)
//        let location   = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
//        findAddress(location)
//    }
//
//    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
//        pinImageView?.alpha = 0.5
//    }
//
//
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        if annotation is MKUserLocation {
//            return nil
//        }
//
//        let reuseId = "pin"
//        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
//        if pinView == nil {
//            pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
//            pinView!.canShowCallout = true
//
//            let PinImage = UIImage(named:"pin.png")!
//            pinView!.image = PinImage
//            pinView?.frame = CGRect(x: 0, y: 0, width: 27, height: 36)
//        }
//        else {
//            pinView!.annotation = annotation
//        }
//
//        return pinView
//    }
//
//}
