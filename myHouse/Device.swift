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
    let subtitle: String?
    //let description: String
    let iconName: String
    let sensors: [String]
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, description: String, iconName: String, sensors: [String], coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = description
        self.iconName = iconName
        self.sensors = sensors
        self.coordinate = coordinate
        
        super.init()
    }
    
    var icon: UIImage? {
        return UIImage(named: iconName)
    }
}
