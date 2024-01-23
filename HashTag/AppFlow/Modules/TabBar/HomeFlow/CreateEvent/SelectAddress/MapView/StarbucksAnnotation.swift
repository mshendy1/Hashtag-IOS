//
//  StarbucksAnnotation.swift
//  Labany
//
//  Created by Eman Gaber on 7/28/21.
//

import Foundation
import MapKit
class StarbucksAnnotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var phone: String!
    var name: String!
    var address: String!
    var image: UIImage!
    var branchId :String!
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
