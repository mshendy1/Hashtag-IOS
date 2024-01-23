//
//  GoogleplacesVC.swift
//  HashTag
//
//  Created by Trend-HuB on 08/09/1444 AH.
//
import UIKit
import MapKit
import GooglePlaces
import GoogleMaps
import LanguageManager_iOS

class GoogleplacesVC: UIViewController, UISearchResultsUpdating,MKMapViewDelegate ,UIGestureRecognizerDelegate,CLLocationManagerDelegate{
    @IBOutlet weak var btnConfirm:UIButton!
    @IBOutlet weak var lblAddress:UILabel!
    
    var selected_latitude = ""
    var selected_longitude = ""
    var selectedAddress = ""
    var selectedCity = ""
    let regioninMeters:Double = 800000

    let mapView = MKMapView()

    let searchVC = UISearchController(searchResultsController: ResultsViewController())
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(mapView)
        searchVC.searchBar.backgroundColor = .clear
        searchVC.searchResultsUpdater = self
        navigationItem.searchController = searchVC
        navigationItem.title = Constants.PagesTitles.addressTitle
        navigationController?.isNavigationBarHidden = false
        btnConfirm.setTitle("confirm".localiz(), for: .normal)
        mapView.delegate = self
        mapView.showsUserLocation = true
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
            let tgr = UITapGestureRecognizer(target: self, action: #selector(tapGestureHandler(_:)))
            
            tgr.delegate = self
            mapView.addGestureRecognizer(tgr)
        
        mapView.showAnnotations(mapView.annotations, animated: true)
        
        mapView.mapType = .standard
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mapView.frame = CGRect(
            x: 0,
            y: view.safeAreaInsets.top,
            width: view.frame.size.width,
            height: view.frame.size.height - view.safeAreaInsets.top)
    
        mapView.addSubview(lblAddress)
        mapView.addSubview(btnConfirm)

    }
    
    @objc func tapGestureHandler(_ tgr: UITapGestureRecognizer?) {
        let touchPoint: CGPoint? = tgr?.location(in: mapView)
        
        let touchMapCoordinate: CLLocationCoordinate2D = mapView.convert(touchPoint ?? CGPoint.zero, toCoordinateFrom: mapView)
        
        var myCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D()
        myCoordinate.longitude = touchMapCoordinate.longitude
        myCoordinate.latitude = touchMapCoordinate.latitude
        
        
        getAddressFromLatLon(pdblLatitude: "\(touchMapCoordinate.latitude)", withLongitude: "\(touchMapCoordinate.longitude)")
        
        addPin(myCoordinate.latitude, myCoordinate.longitude, "")

        selected_latitude = "\(touchMapCoordinate.latitude)"
        selected_longitude = "\(touchMapCoordinate.longitude)"
        btnConfirm.backgroundColor = Colors.PrimaryColor
        
    }
    
    
    
    func addPin(_ lat:Double,_ lng:Double,_ til:String = "" ){
        let point = StarbucksAnnotation(coordinate: CLLocationCoordinate2D(latitude: lat , longitude:lng ))
        if let location = locationManager.location?.coordinate{
            
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regioninMeters, longitudinalMeters: regioninMeters)
            mapView.setRegion(region, animated: true)
        }
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotation(point)
        self.mapView.selectAnnotation(point, animated: false)
        
    }
    
    //MARK: - Custom Annotation
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation
        {
            return nil
        }else
        {
            
            var annotationView = self.mapView.dequeueReusableAnnotationView(withIdentifier: "Pin")
            if annotationView == nil{
                annotationView = AnnotationView(annotation: annotation, reuseIdentifier: "Pin")
                annotationView?.canShowCallout = false
            }else{
                annotationView?.annotation = annotation
            }
            annotationView?.image = UIImage.init(named: "")
            return annotationView
        }
    }
    
    func mapView(_ mapView: MKMapView,
                 didSelect view: MKAnnotationView)
    {
        
        if view.annotation is MKUserLocation
        {
            // Don't proceed with custom callout
            return
        }
        else
        {
            let NibNamed = "CustomCalloutView2"
            // 2
            let views = Bundle.main.loadNibNamed(NibNamed, owner: nil, options: nil)
            
            let calloutView = views?[0] as! CustomCalloutView2
            
            
            calloutView.center = CGPoint(x: view.bounds.size.width / 2, y: -calloutView.bounds.size.height*0.52)
            view.addSubview(calloutView)
            mapView.setCenter((view.annotation?.coordinate)!, animated: true)
            
            
        }
    }


    
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
        let resultsVC = searchController.searchResultsController as? ResultsViewController  else {
            return
        }
        resultsVC.delegate = self
        GooglePlacesManager.shared.findPlaces(query: query) { result in
            switch result {
            case .success(let places):
                DispatchQueue.main.async {
                    resultsVC.update(with:places)
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) {
        
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)")!
        //21.228124
        let lon: Double = Double("\(pdblLongitude)")!
        //72.833770
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
                                    {(placemarks, error) in
            if (error != nil)
            {
                print("reverse geodcode fail: \(error!.localizedDescription)")
            }
            if placemarks != nil {
                let pm = placemarks! as [CLPlacemark]
                
                if pm.count > 0 {
                    var addressString : String = ""
                    
                    let pm = placemarks![0]
                    if let addrList = pm.addressDictionary?["FormattedAddressLines"] as? [String]
                    {
                        if addrList.count == 0
                        {
                            if pm.subLocality != nil {
                                addressString = addressString + pm.subLocality! + ", "
                            }
                            if pm.thoroughfare != nil {
                                addressString = addressString + pm.thoroughfare! + ", "
                            }
                            if pm.locality != nil {
                                addressString = addressString + pm.locality! + ", "
                            }
                            if pm.country != nil {
                                addressString = addressString + pm.country! + ", "
                            }
                            if pm.postalCode != nil {
                                addressString = addressString + pm.postalCode! + " "
                            }
                        }else
                        {
                            addressString =  addrList.joined(separator: ", ")
                        }
                    }
                    
                    self.selectedAddress = addressString
                    print(addressString)
                    self.lblAddress.isHidden = false
                     self.lblAddress.text = addressString
                }
            }
        })
        
    }
    
    @IBAction func ConfirmLocation(_ sender: Any) {
        if(selectedAddress == "") {
            showErrorAlert(message: Constants.messages.emptyAddress)
        }else
        {
            NotificationCenter.default.post(name: Notification.Name("setSelectedAddress"),object: nil,userInfo: ["selectedAddress":self.selectedAddress,"selectedLang": self.selected_longitude ,"selectedLat": self.selected_latitude])
            
            self.navigationController?.popViewController(animated: true)
            
        }
      }
}


extension GoogleplacesVC: ResultsViewControllerDelegate {
    func didTapPlaces(with coordinates: CLLocationCoordinate2D) {
        searchVC.searchBar.resignFirstResponder()
        searchVC.dismiss(animated: true,completion: nil)
        // remove all map pin
        let annotations = mapView.annotations
        mapView.removeAnnotations(annotations)
        // add map pin
        let pin = MKPointAnnotation()
        pin.coordinate = coordinates
        mapView.addAnnotation(pin)
        mapView.setRegion(
            MKCoordinateRegion(
                center: coordinates,
                 span: MKCoordinateSpan(
                     latitudeDelta: 0.2,
                     longitudeDelta: 0.2
                 )),
            animated: true)
        print(coordinates)
        lblAddress.isHidden = false
        selected_latitude = "\(coordinates.latitude)"
        selected_longitude = "\(coordinates.longitude)"
        getAddressFromLatLon(pdblLatitude: selected_latitude, withLongitude: selected_longitude)
        btnConfirm.backgroundColor = Colors.PrimaryColor
    }
    
    
}

