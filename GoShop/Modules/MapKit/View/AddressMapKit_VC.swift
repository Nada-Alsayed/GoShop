//
//  AddressMapKit_VC.swift
//  GoShop
//
//  Created by MAC on 26/12/2023.
//

import UIKit
import MapKit
import CoreLocation

class AddressMapKit_VC: UIViewController{
    
    //MARK: -IBOutlets
    
    @IBOutlet weak var myMapKit: MKMapView!
    @IBOutlet weak var backBtn: UIImageView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    //MARK: -Variables
    
    var viewModel = AddressViewModel()
    var locationManager = CLLocationManager()
    var pin = MKPointAnnotation()
    var delegateReload : ReloadViewDelegate?
    
    //MARK: -View Controller LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationService()
        setMapConfiguration()
        addMapTapGesture()
        addbackImgAction()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if isBeingDismissed {
            delegateReload?.reloadView()
        }
    }
    
    //MARK: -Methods

    func addbackImgAction(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(goBack))
        backBtn.isUserInteractionEnabled = true
        backBtn.addGestureRecognizer(tap)
    }
    
    @objc func goBack(){
        self.dismiss(animated: true)
    }
    
    func isLocationServiceEnabled()-> Bool{
        return CLLocationManager.locationServicesEnabled()
    }
    
    func checkLocationService(){
        DispatchQueue.global().async{
            if self.isLocationServiceEnabled(){
                print(" loction service")
                self.checkAuthorization()
            }else{
                print("got to setting to enable loction service")
            }
        }
    }
    
    func setMapConfiguration(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        myMapKit.delegate = self
    }
    
    func addMapTapGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleMapTap(_:)))
        myMapKit.addGestureRecognizer(tapGesture)
    }
    
    func checkAuthorization(){
        switch locationManager.authorizationStatus{
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("restricted")
        case .denied:
            print("please give us location")
        case .authorizedAlways:
            locationManager.startUpdatingLocation()
            myMapKit.showsUserLocation = true
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            myMapKit.showsUserLocation = true
        @unknown default:
            print("default")
        }
    }
    
    func zoomToUserLoction(location:CLLocation){
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        myMapKit.setRegion(region, animated: true)
        setPinToLocation(location: location)
        convertLocationToPlacemark(location: location)
    }
    
    func convertLocationToPlacemark(location :CLLocation){
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { places, error in
            if let error = error {
                print("Geocoding error: \(error.localizedDescription)")
                return
            }
            
            if let placemark = places?.first {
                let details = "\(placemark.subThoroughfare ?? "nil"), \(placemark.thoroughfare ?? "nil"), \(placemark.subLocality ?? "nil"), \(placemark.locality ?? "nil")"
                let address = Address(name: placemark.name!, city: placemark.locality ?? "" , region: placemark.country! , details: details, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude, notes: placemark.locality, id: 0)
                self.showAddressAlert(address: address)
                
            } else {
                print("No placemark found for the given location")
            }
        }
    }
    
    func setPinToLocation(location:CLLocation){
        myMapKit.removeAnnotations(myMapKit.annotations)
        pin.coordinate = location.coordinate
        myMapKit.addAnnotation(pin)
        convertLocationToPlacemark(location: location)
    }
    
    func showAddressAlert(address:Address){
        showAlertWithAction(title: ConstantStrings.ALERT, titleAction: ConstantStrings.ADD_BTN, titleNoAction: ConstantStrings.NO_ACTION_BTN, message: ConstantStrings.CONFIRM_ADD_ADDRESS, viewController: self) {
            self.indicator.isHidden = false
            self.indicator.startAnimating()
            self.viewModel.postAddress(address: address){
                self.indicator.stopAnimating()
                self.dismiss(animated: true)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus){
        switch status{
        case .denied:
            print("please give us location")
        case .authorizedAlways:
            locationManager.startUpdatingLocation()
            myMapKit.showsUserLocation = true
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            myMapKit.showsUserLocation = true
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("restiricted")
        @unknown default:
            print("default")
        }
    }

}

//MARK: -Extensions

extension AddressMapKit_VC : CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        print("location : \(location.coordinate.latitude)")
        zoomToUserLoction(location: location)
        manager.stopUpdatingLocation()
    }
}

extension AddressMapKit_VC : MKMapViewDelegate{
    
    @objc func handleMapTap(_ gestureRecognizer: UITapGestureRecognizer) {
          if gestureRecognizer.state == .ended {
              let tapPoint = gestureRecognizer.location(in: myMapKit)
              let tapCoordinate = myMapKit.convert(tapPoint, toCoordinateFrom: myMapKit)
              let tappedLocation = CLLocation(latitude: tapCoordinate.latitude, longitude: tapCoordinate.longitude)
              myMapKit.removeAnnotations(myMapKit.annotations)
              print("Tapped location: \(tapCoordinate)")
              setPinToLocation(location: tappedLocation)
          }
      }
}

