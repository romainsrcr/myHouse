//
//  Devices.swift
//  myHouse
//
//  Created by loic.chacornac on 10/11/2018.
//  Copyright © 2018 fr.myHouse. All rights reserved.
//

import UIKit
import Alamofire
import MapKit

class Application: NSObject{
    
    static var devices: [Device] = []
    
    static let name = "project_iot_dtu"
    
    private static let accessKey = "ttn-account-v2.aoC_LAYJ5OE21VzyAmFRmtKKC5c5aQx4BA9y6-1Ijow"
    private static let url = "http://eu.thethings.network:8084/applications/\(name)"
    private static let headers = ["Authorization": "Key \(accessKey)"]
    
    
    static func getDevices() {
        Alamofire.request(self.url, headers:headers).responseString { response in
            if let JSON = response.result.value {
                print(JSON)
            }
        }
    }
}
