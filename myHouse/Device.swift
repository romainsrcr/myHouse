//
//  DeviceModel.swift
//  myHouse
//
//  Created by Loïc CHACORNAC on 01/11/2018.
//  Copyright © 2018 fr.myHouse. All rights reserved.
//


import UIKit


class Device {
    let name: String
    let description: String
    let iconName: String
    let sensors: [String]
    
    init(name: String, description: String, iconName: String, sensors: [String]) {
        self.name = name
        self.description = description
        self.iconName = iconName
        self.sensors = sensors
    }
    
    var icon: UIImage? {
        return UIImage(named: iconName)
    }
}
