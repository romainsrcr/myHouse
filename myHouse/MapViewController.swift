//
//  MapViewController.swift
//  myHouse
//
//  Created by Romain SERCER on 25/10/2018.
//  Copyright © 2018 fr.myHouse. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    // set initial location in Copenhagen
    let initialLocation = CLLocation(latitude: 55.676098, longitude: 12.568337)
    // set inital scale of 10 000 m
    let regionRadius: CLLocationDistance = 10000
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        centerMapOnLocation(location: initialLocation)
        //mapView.addAnnotations(devices)
    }
}


