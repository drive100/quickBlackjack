//
//  MapAnnontation.swift
//  quickBlackjack
//
//  Created by Danny Rivera on 4/16/19.
//  Copyright © 2019 Danny Rivera. All rights reserved.
//

import Foundation
import MapKit
import Contacts

//MapAnnotation conforms to the MKAnnotation protocol
class MapAnnotation: NSObject, MKAnnotation {
    //"title", "subtitle", and "coordinate" are defined in the MKAnnotation protocol
    var title: String?
    var location: String
    
    var category: String
    
    var subtitle: String? {
        return location
    }
    
    var coordinate: CLLocationCoordinate2D
    
    //initializer
    init(title: String, location: String, category: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.location = location
        self.category = category
        self.coordinate = coordinate
        
        super.init()
    }
    
    //mapItem ecapsulates the informtion of the MapAnnotation object into a MKMapItem for sharing informaiton with the Maps app.
    func mapItem() -> MKMapItem {
        //creates an address dictionary
        let addressDictionary = [CNPostalAddressStreetKey: "Waikiki Gateway Park", CNPostalAddressStateKey: "Hawaii", CNPostalAddressCountryKey: "USA"]
        
        //MKPlacemark stores placemark data (such as the country, state, city, and street address) for a given latitude and longitude (coordinate).
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDictionary)
        
        //instantiate a MKMapItem with the placemark
        let mapItem = MKMapItem(placemark: placemark)
        
        //configure mapItem with appropriate information
        mapItem.name = title
        mapItem.phoneNumber = "1234567890"
        
        return mapItem
    }
    
    //returns a color for the pin depending on the category of the MapAnnotation object
    func pinColor() -> UIColor {
        switch category {
        case "Statue":
            return UIColor.blue
        case "Monument":
            return UIColor.red
        default:
            return UIColor.green
            
        }
    }
}
