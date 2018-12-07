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
    
    // Si tu veux avoir accès à App Name et AccesKey mis par user :
    //
    
    // Properties of the application
    //static var name = "project_iot_dtu"
    //static let accessKey = "ttn-account-v2.aoC_LAYJ5OE21VzyAmFRmtKKC5c5aQx4BA9y6-1Ijow"
    //static var advancedMode: Bool = true
    
    static let name:String = {return UserDefaults.standard.string(forKey: "appName")!}()
    static let accessKey:String = { return UserDefaults.standard.string(forKey: "accessKey")! }()
    
    //Interresting information
    private(set) static var devices: [Device] = []
    private static let decoder:String = {
        var header = "function Decoder(bytes, port) {\n  \n  var decoded = {};\n\n  function bytesToFloat(bytes) {\n    bytes = bytes.slice(0, 4)\n    var bits = (bytes[0] << 24) | (bytes[1] << 16) | (bytes[2] << 8 )| (bytes[3] << 4 );\n    var sign = ((bits >>> 31) === 0) ? 1.0 : -1.0;\n    var e = ((bits >>> 23) & 0xff);\n    var m = (e === 0) ? (bits & 0x7fffff) << 1 : (bits & 0x7fffff) | 0x800000;\n    var f = sign * m * Math.pow(2, e - 150);\n    \n    return f\n  }\n  \n  function bytesToString(bytes){\n    return parseFloat(String.fromCharCode.apply(null, bytes));\n  }\n  \n  function byteToInt(bytes) {\n    var value = 0;\n    for ( var i = bytes.length - 1; i >= 0; i--) {\n        value = (value * 256) + bytes[i];\n    }\n    return value;\n  }\n  \n"
        
        var body = ""
        var channels = ChannelCD.all
        for channel in channels {
            body = body + "\nif (port == \(channel.numberChannel)){ \n decoded.\(channel.name ?? "") = bytesTo\(channel.typeOfUplink ?? "")(bytes); \n}"
        }
        
        var footer = "\n  return decoded\n}"
        
        return header + body + footer
    }()
    
    
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
    
    
    static func updateChannels(success: @escaping () -> Void, failure: @escaping () -> Void) {
        let url = "http://eu.thethings.network:8084/applications/\(name)"
        let headers = ["Authorization": "Key \(accessKey)"]
        let data = ["decoder" : self.decoder]
        
        Alamofire.request(url, method: .post, parameters: data, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            if (response.result.isSuccess) {
                success()
            }
            else {
                failure()
            }
        }
    }
    
}
