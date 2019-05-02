//
//  MapViewController.swift
//  quickBlackjack
//
//  Created by Danny Rivera on 4/10/19.
//  Copyright © 2019 Danny Rivera. All rights reserved.
//

import UIKit
import MapKit


class MapViewController: Swipe, MKMapViewDelegate,CLLocationManagerDelegate {

    
    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    var mapAnnotations = [MapAnnotation]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // Check for Location Services
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
        }
        
        //Zoom to user location
        if let userLocation = locationManager.location?.coordinate {
            let viewRegion = MKCoordinateRegion(center: userLocation, latitudinalMeters: 200, longitudinalMeters: 200)
            mapView.setRegion(viewRegion, animated: false)
            mapView.showsUserLocation = true

        }
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        DispatchQueue.main.async {
            self.locationManager.startUpdatingLocation()
        }
        let mapAnnotation1 = MapAnnotation(title: "xding101", location: "Slocum Hall", category: "Statue", coordinate: CLLocationCoordinate2D(latitude: 43.037668, longitude: -76.131941))
        
        let mapAnnotation2 = MapAnnotation(title: "surferdude22", location: "", category: "Statue", coordinate: CLLocationCoordinate2D(latitude: 43.036523, longitude: -76.130814))
        
        let mapAnnotation3 = MapAnnotation(title: "cusekid11", location: "iSchool", category: "Statue", coordinate: CLLocationCoordinate2D(latitude: 43.038554, longitude: -76.131983))
        
        let mapAnnotation4 = MapAnnotation(title: "rpgplayer89", location: "Sims Hall", category: "Statue", coordinate: CLLocationCoordinate2D(latitude: 43.036915, longitude: -76.131823))
        
        mapAnnotations.append(mapAnnotation1)
        mapAnnotations.append(mapAnnotation2)
        mapAnnotations.append(mapAnnotation3)
        mapAnnotations.append(mapAnnotation4)
        
        //addAnnotations(_:) adds an array of annotation objects to the map view.
        mapView.addAnnotations(mapAnnotations)

    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        let location = locations.last as! CLLocation
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        var region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        region.center = mapView.userLocation.coordinate
        mapView.setRegion(region, animated: true)
    }
}

    //mapView(:viewFor:), defined in MKMapViewDelegate, returns the view associated with the specified annotation object.
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        print("\(#function) \(String(describing: annotation.title))")

        if let mapAnnotation = annotation as? MapAnnotation {
            let identifier = "pin"
            var pinAnnotationView: MKPinAnnotationView

            //try to dequeue a view (MKAnnotationView) with the specified identifier
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
                dequeuedView.annotation = mapAnnotation
                pinAnnotationView = dequeuedView
            }
                //if view with the specified identifier cannot be found, instantiation one
            else {
                pinAnnotationView = MKPinAnnotationView(annotation: mapAnnotation, reuseIdentifier: identifier)
                pinAnnotationView.canShowCallout = true
                pinAnnotationView.calloutOffset = CGPoint(x: -5, y: 5)
                pinAnnotationView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            }

            //set color of the pin
            pinAnnotationView.pinTintColor = mapAnnotation.pinColor()

            return pinAnnotationView
        }

        return nil
    }

    //mapView(:annotationView:calloutAccessoryControlTapped:) tells the delegate that the user tapped one of the annotation view’s accessory buttons.
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print(#function)

        if let artwork = view.annotation as? MapAnnotation {
            //launches maps with the specified launch options
            artwork.mapItem().openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
        }
    }





