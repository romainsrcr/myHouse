//
//  DeviceModel.swift
//  myHouse
//
//  Created by Loïc CHACORNAC on 01/11/2018.
//  Copyright © 2018 fr.myHouse. All rights reserved.
//


import UIKit
import MapKit

class Device: NSObject, MKAnnotation {
    
    let title: String?
    //let iconName: String
    //let sensors: [String]
    let coordinate: CLLocationCoordinate2D
    
    init(name: String, coordinate: CLLocationCoordinate2D) {
        self.title = name
        self.coordinate = coordinate
        
        super.init()
    }
    
    //var icon: UIImage? {
    //    return UIImage(named: iconName)
    //}
}
