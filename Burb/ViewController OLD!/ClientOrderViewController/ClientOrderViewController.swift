////
////  ClientOrderViewController.swift
////  Burb
////
////  Created by Eugene on 29/08/2019.
////  Copyright © 2019 CC_Eugene. All rights reserved.
////
//
//import UIKit
//import MapKit
//import Firebase
//
//
//class ClientOrderViewController: UIViewController, CLLocationManagerDelegate {
//
//    var pinImageView: UIImageView?
//    var geocoder         = CLGeocoder()
//    var locationManager  = CLLocationManager()
//    var locationWasShown = false
//    var coordinate: CLLocationCoordinate2D?
//
//    var longitude: Double?
//    var latitude: Double?
//    var city: String?
//
//    @IBOutlet weak var mapView: MKMapView!
//    @IBOutlet weak var showView: UIView!
//    @IBOutlet weak var showLabel: UILabel!
//    @IBOutlet weak var getLocationButton: UIButton!
//
//    convenience init(coordinate: CLLocationCoordinate2D?) {
//        self.init(nibName: nil, bundle: nil)
//        self.coordinate = coordinate
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupSubviews()
//        setupPin()
//        startManager()
//        decorate()
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//        navigationController?.isNavigationBarHidden = true
//    }
//
//    fileprivate func setupSubviews()    {
//        mapView.delegate = self as MKMapViewDelegate
//        mapView.showsUserLocation = true
//        mapView.showsCompass = true
//    }
//
//    fileprivate func setupPin() {
//
//        if let pinImage = UIImage(named: "pin.png") {
//            pinImageView = UIImageView(image: pinImage)
//            pinImageView?.center = CGPoint(x: mapView.center.x, y: mapView.center.y - pinImage.size.height / 2.0)
//            self.view.addSubview(pinImageView!)
//        }
//    }
//
//    fileprivate func startManager() {
//        if self.coordinate != nil {
//            self.locationWasShown = true
//            setRegion(self.coordinate!)
//        }
//        
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
//        geocoder.reverseGeocodeLocation(location) { (placeMarks, error) in
//
//            guard error == nil else {return}
//
//            if let places = placeMarks {
//
//                let place  = places[0]
//                let street = place.name ?? ""
//                let city = place.locality ?? ""
//                let long = place.location!.coordinate.longitude
//                let lati = place.location!.coordinate.latitude
//
//
//                print("\(place.location!.coordinate.latitude) + \(place.location!.coordinate.longitude)")
//
//
//                self.city = "\(city)"
//                self.longitude = long
//                self.latitude = lati
//                self.showLabel.text = "\(street)"
//            }
//        }
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let destinationVC: ConfirmOrderTimeViewController = segue.destination as! ConfirmOrderTimeViewController
//        destinationVC.adress = showLabel.text
//    }
//
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//
//        if !locationWasShown {
//            locationWasShown = true
//            let location = locations.last! as CLLocation
//            setRegion(location.coordinate)
//            findAddress(location)
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
//
//    func decorate() {
//        self.showView.layer.cornerRadius = self.showView.frame.height / 4
//        self.showView.applyShadowOnView(showView)
//    }
//
//    @IBAction func createOrderButtonPressed(_ sender: UIButton) {
//        createOrder()
//    }
//
//
//    func createOrder() {
//        let ref = Database.database().reference(fromURL: "https://burb-b8940.firebaseio.com/")
//        guard let userID = Auth.auth().currentUser?.uid, self.showLabel.text != nil else { return }
//        let userRefeference = ref.child("orders").child(userID)
//        let userValues = ["adress": self.showLabel.text as Any, "userId": userID, "descriptionOrder": "I would like beard, moustache, hair cut.Also I need cleaning after cut.", "orderId": userID, "longitude": self.longitude , "latitude": self.latitude, "city": self.city]
//        userRefeference.updateChildValues(userValues as [AnyHashable : Any], withCompletionBlock: { (error, ref) in
//            if error != nil {
//                print(error!)
//                return
//            }
//        })
//    }
//
//
//
//}
//
//extension ClientOrderViewController: MKMapViewDelegate {
//
//    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
//
//        pinImageView?.alpha = 1.0
//        let coordinate = mapView.convert(self.mapView.center, toCoordinateFrom: self.mapView)
//        let location   = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
//        findAddress(location)
//    }
//
//    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
//        pinImageView?.alpha = 0.5
//    }
//}
