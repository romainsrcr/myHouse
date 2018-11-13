//
//  DeviceModel.swift
//  myHouse
//
//  Created by Loïc CHACORNAC on 01/11/2018.
//  Copyright © 2018 fr.myHouse. All rights reserved.
//


import UIKit
import MapKit
import Alamofire
import SwiftyJSON

class Device: NSObject, MKAnnotation {
    
    let title: String?
    var deviceDescription: String
    //let iconName: String
    
    var datas : Dictionary<String, [Float]>
    let coordinate: CLLocationCoordinate2D
    
    init(name: String, description: String, coordinate: CLLocationCoordinate2D) {
        self.title = name
        self.coordinate = coordinate
        self.deviceDescription = description
        self.datas = [:]
        super.init()
    }
    
    func getData(success: @escaping () -> Void) {
        
        let url = "https://\(Application.getName()).data.thethingsnetwork.org/api/v2/query/\(self.title!)"
        let headers = ["Authorization": "key \(Application.getAccessKey())"]
        
        Alamofire.request(url, headers:headers).responseJSON { response in
            if (response.result.isSuccess) {
                if let result = response.result.value {
                    let resultJSON = JSON(result)
                    for packet in resultJSON.arrayValue {
                        for (key, value) in packet {
                            if (key != "device_id" && key != "raw" && key != "time"){
                                if self.datas[key] == nil {
                                    self.datas[key] = []
                                }
                                self.datas[key]!.append(value.floatValue)
                            }
                        }
                    }
                }
                success()
            }
            else {
                print("An error was occured ! Please check your connection.")
            }
        }
    }
    
    //var icon: UIImage? {
    //    return UIImage(named: iconName)
    //}
}
