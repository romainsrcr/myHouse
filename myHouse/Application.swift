//
//  Devices.swift
//  myHouse
//
//  Created by loic.chacornac on 10/11/2018.
//  Copyright © 2018 fr.myHouse. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MapKit

class Application: NSObject{
    
    // Properties of the application
    // Si tu veux avoir accès à App Name et AccesKey mis par user :
    //      private static let name = UserDefaults.standard.string(forKey: "appName")
    //      private static let accessKey = UserDefaults.standard.string(forKey: "accessKey")
    
    private static let name = "project_iot_dtu"
    private static let accessKey = "ttn-account-v2.aoC_LAYJ5OE21VzyAmFRmtKKC5c5aQx4BA9y6-1Ijow"
    
    //Interresting information
    private static var devices: [Device] = []
    
    
    static func getDevices(success: @escaping ([Device]) -> Void) {
        
        let url = "http://eu.thethings.network:8084/applications/\(name)/devices"
        let headers = ["Authorization": "Key \(accessKey)"]
        
        Alamofire.request(url, headers:headers).responseJSON { response in
            if (response.result.isSuccess) {
                if let result = response.result.value {
                    self.devices = []
                    let resultJSON = JSON(result)
                    for device in resultJSON["devices"].arrayValue {
                        let deviceName = device["dev_id"].stringValue
                        let deviceLatitude = device["latitude"].doubleValue
                        let deviceLongitude = device["longitude"].doubleValue
                        self.devices.append(Device(name: deviceName, coordinate: CLLocationCoordinate2D(latitude: deviceLatitude, longitude: deviceLongitude )))
                    }
                }
                success(self.devices)
            }
        }
    }
    
}
