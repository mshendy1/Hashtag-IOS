//
//  SelectAddressVC.swift
//  BasetaApp
//
//  Created by Eman Gaber on 29/05/2022.
//


import Foundation
import MapKit
import UIKit
import CoreLocation
import Polyline
import LanguageManager_iOS
import MapKit

class SelectAddressVC: UIViewController,UIGestureRecognizerDelegate  {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var header: AuthNavigation!
    var selected_latitude:Double!
    var selected_longitude:Double!
     let regioninMeters:Double = 80000

    var userlatitude:Double?
    var userlongitude:Double?

    let locationManager = CLLocationManager()

  override func viewDidLoad() {
    super.viewDidLoad()
    
      navigationController?.isNavigationBarHidden = true
       header.delegate = self
       header.lblTitle.text = Constants.PagesTitles.addressTitle
       header.img.isHidden = true
       header.switchNotificattion.isHidden = true
           
                    mapView.delegate = self
                    mapView.showsUserLocation = true
                    self.locationManager.requestAlwaysAuthorization()
                    self.locationManager.requestWhenInUseAuthorization()
                    locationManager.delegate = self
                    locationManager.desiredAccuracy = kCLLocationAccuracyBest
                    locationManager.startUpdatingLocation()

        }
    
    func checkAuthorization(){
        if #available(iOS 14.0, *) {
            switch locationManager.authorizationStatus {
                
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
                break
            case .restricted:
                print("cannot access location on your device")
            case .denied:
                print("cannot access location on your device")
            case .authorizedAlways:
                locationManager.startUpdatingLocation()
            case .authorizedWhenInUse:
                locationManager.requestWhenInUseAuthorization()
                locationManager.startUpdatingLocation()
                
            @unknown default:
                print("unKnown case")
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    
    func createPath(sourceLocation:CLLocationCoordinate2D,destinationLocation:CLLocationCoordinate2D){
        let sourcePlaceMark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
        let destinationPlaceMark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
        
        let sourceMapitem = MKMapItem(placemark: sourcePlaceMark)
        let destinationMapitem = MKMapItem(placemark: destinationPlaceMark)

        let sourceAnotation = MKPointAnnotation()
        sourceAnotation.title = "sourceTitle"
        sourceAnotation.subtitle = "sourceSubTitle"
        
        if let location = sourcePlaceMark.location{
            sourceAnotation.coordinate = location.coordinate
        }
        
        let destinationAnotation = MKPointAnnotation()
        destinationAnotation.title = "destinationTitle"
        destinationAnotation.subtitle = "destinationSubTitle"

        if let location = destinationPlaceMark.location{
            destinationAnotation.coordinate = location.coordinate
        }
        self.mapView.showAnnotations([sourceAnotation,destinationAnotation], animated: true)
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = sourceMapitem
        directionRequest.destination = destinationMapitem
        directionRequest.transportType = .automobile
       
        let direction = MKDirections(request: directionRequest)
        direction.calculate { response, error in
            guard let response = response else{
                if let  error = error {
                    print("ERROR Found: \(error.localizedDescription)")
                }
                return
            }
            let route = response.routes[0]
            self.mapView.addOverlay(route.polyline, level: MKOverlayLevel.aboveRoads)
            
            let rect = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegion(rect) , animated: true)
        }
        
       
    }
}

extension SelectAddressVC:MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let rendere = MKPolylineRenderer(overlay: overlay)
        rendere.lineWidth = 5
        rendere.strokeColor = .blue
       
        return rendere
    }
}
extension SelectAddressVC:CLLocationManagerDelegate {
   
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue: CLLocationCoordinate2D = manager.location!.coordinate
        
             userlatitude = locValue.latitude
             userlongitude = locValue.longitude
        let sourceLocation = CLLocationCoordinate2D(latitude: locValue.latitude, longitude: locValue.longitude)
        let destinationLocation = CLLocationCoordinate2D(latitude: selected_latitude, longitude: selected_longitude)

            print("userlocation\(sourceLocation)")
            print("destinationlocation\(destinationLocation)")
            createPath(sourceLocation: sourceLocation, destinationLocation: destinationLocation)
        locationManager.stopUpdatingHeading()
    }
    
}

extension SelectAddressVC:AuthNavigationDelegate{
    func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    func turAction() { }
    
}
