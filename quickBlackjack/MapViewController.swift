//
//  MapViewController.swift
//  quickBlackjack
//
//  Created by Danny Rivera on 4/10/19.
//  Copyright © 2019 Danny Rivera. All rights reserved.
//

import UIKit
import MapKit


class MapViewController: UIViewController, MKMapViewDelegate {

    
    
    @IBOutlet weak var mapView: MKMapView!
    
    //properties that define where to center the map when it loads
    let intialLocation = CLLocation(latitude: 21.282778, longitude: -157.839444)
    let regionSpan: CLLocationDistance = 1000
    
    //array of mapAnnotation objects
    var mapAnnotations = [MapAnnotation]()
    
    //viewDidLoad() is called when the map view first loads
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //sets MapViewController as the delegate of the mapView
        mapView.delegate = self
        
        print("MapViewController viewDidLoad")
        
        //centers the map on "intialLocation" with the specified "regionSpan"
        loadMapOnLocation(location: intialLocation, span: regionSpan)
        
        //mapView.region = MKCoordinateRegionMakeWithDistance(intialLocation.coordinate, regionSpan * 2, regionSpan * 2)
        
        //tabBarItem.title = "Map"
        
        //the two ArtWork objects with which the map will be annotated
        let mapAnnotation1 = MapAnnotation(title: "King David Kalakaua", location: "Waikiki Gateway Park", category: "Statue", coordinate: CLLocationCoordinate2D(latitude: 21.283921, longitude: -157.831661))
        
        let mapAnnotation2 = MapAnnotation(title: "Surfer's Monument", location: "Hilton Hawaiian Resort", category: "Monument", coordinate: CLLocationCoordinate2D(latitude: 21.283921, longitude: -157.842661))
        
        let mapAnnotation3 = MapAnnotation(title: "Ala Wai Boat Harbor", location: "Waikiki Gateway Park", category: "Statue", coordinate: CLLocationCoordinate2D(latitude: 21.283921, longitude: -157.835661))
        
        let mapAnnotation4 = MapAnnotation(title: "Magic Island", location: "Magic Island", category: "Statue", coordinate: CLLocationCoordinate2D(latitude: 21.283921, longitude: -157.845661))
        
        mapAnnotations.append(mapAnnotation1)
        mapAnnotations.append(mapAnnotation2)
        mapAnnotations.append(mapAnnotation3)
        mapAnnotations.append(mapAnnotation4)
        
        //addAnnotations(_:) adds an array of annotation objects to the map view.
        mapView.addAnnotations(mapAnnotations)
        
    }
    
    //loadMapOnLocation() loads the map on the specified location with the specified span
    func loadMapOnLocation(location: CLLocation, span: CLLocationDistance) {
        let region = MKCoordinateRegion.init(center: location.coordinate, latitudinalMeters: span * 2, longitudinalMeters: span * 2)
        
        mapView.setRegion(region, animated: true)
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
    
    
    //    override func viewWillAppear(animated: Bool) {
    //        super.viewWillAppear(true)
    //
    //        print("MapViewController viewWillAppear")
    //
    //    }
    //
    //    override func viewDidAppear(animated: Bool) {
    //        super.viewDidAppear(animated)
    //
    //         print("MapViewController viewDidAppear")
    //
    //    }
    //
    //    override func viewWillDisappear(animated: Bool) {
    //        super.viewWillDisappear(animated)
    //
    //         print("MapViewController viewWillDisappear")
    //
    //    }
    //
    //    override func viewDidDisappear(animated: Bool) {
    //        super.viewDidDisappear(animated)
    //
    //         print("MapViewController viewDidDisappear")
    //
    //
    //    }
}

    

