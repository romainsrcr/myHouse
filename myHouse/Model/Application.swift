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

struct Channel {
    var numberChannel : Int
    var typeOfData : String
    var unit : String
    var typeOfUplink : String
}

class Application: NSObject{
    
    // Si tu veux avoir accès à App Name et AccesKey mis par user :
    //      private static let name = UserDefaults.standard.string(forKey: "appName")
    //      private static let accessKey = UserDefaults.standard.string(forKey: "accessKey")
    
    // Properties of the application
    private static var name = "project_iot_dtu"
    private static let accessKey = "ttn-account-v2.aoC_LAYJ5OE21VzyAmFRmtKKC5c5aQx4BA9y6-1Ijow"
    static var advancedMode: Bool = false
    
    static var myChannels : [Int : Channel] = [:]
    
    //Interresting information
    private(set) static var devices: [Device] = []
    
    
    private override init() {
    }
    
    static func getDevices(success: @escaping () -> Void) {
        
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
                        let deviceDescription = device["description"].stringValue
                        let deviceCreated = Device(name: deviceName, description: deviceDescription, coordinate: CLLocationCoordinate2D(latitude: deviceLatitude, longitude: deviceLongitude ))
                        self.devices.append(deviceCreated)
                    }
                }
                success()
            }
        }
    }
    
    static func getName() -> String {
        return self.name
    }
    
    static func getAccessKey() -> String {
        return self.accessKey
    }
}
