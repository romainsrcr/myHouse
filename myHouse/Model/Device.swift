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
    let coordinate: CLLocationCoordinate2D
    
    let name: String?
    
    private(set) var deviceDescription: String
    private(set) var datas : Dictionary<String, Dictionary<String, [Any]>>
    private(set) var infos : Dictionary<String, String>
    
    init(name: String, description: String, coordinate: CLLocationCoordinate2D) {
        self.title = name.transformToBeautiful()
        self.name = name
        self.coordinate = coordinate
        self.deviceDescription = description
        self.datas = [:]
        self.infos = [:]
        super.init()
    }
    
    func getData(success: @escaping () -> Void) {
        
        let url = "https://\(Application.getName()).data.thethingsnetwork.org/api/v2/query/\(self.name!)"
        let headers = ["Authorization": "key \(Application.getAccessKey())"]
        
        Alamofire.request(url, headers:headers).responseJSON { response in
            if (response.result.isSuccess) {
                if let result = response.result.value {
                    let resultJSON = JSON(result)
                    self.datas = [:]
                    for packet in resultJSON.arrayValue {
                        for (key, value) in packet {
                            if (key != "device_id" && key != "raw" && key != "time"){
                                //Value management
                                if self.datas[key] == nil {
                                    self.datas[key] = [:]
                                    self.datas[key]!["data"] = []
                                    self.datas[key]!["date"] = []
                                }
                                if(value != JSON.null)
                                {
                                    self.datas[key]!["data"]!.append(value.doubleValue)
                                    
                                    // Date management
                                    let dateFormatter = DateFormatter()
                                    dateFormatter.locale = Locale(identifier: "en_US")
                                    dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH:mm:ss.SSSS'Z'"
                                    let date = dateFormatter.date(from: packet["time"].stringValue)
                                    self.datas[key]!["date"]!.append(date!)
                                }
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
    
    
    func getInfo(success: @escaping () -> Void) {
        
        let url = "http://eu.thethings.network:8084/applications/\(Application.getName())/devices/\(self.name!)"
        let headers = ["Authorization": "key \(Application.getAccessKey())"]
        
        Alamofire.request(url, headers:headers).responseJSON { response in
            if (response.result.isSuccess) {
                if let result = response.result.value {
                    let resultJSON = JSON(result)
                    print(resultJSON["lorawan_device"])
                    self.infos["devEUI"] = resultJSON["lorawan_device"]["dev_eui"].stringValue
                    self.infos["appEUI"] = resultJSON["lorawan_device"]["app_eui"].stringValue
                    self.infos["appKEY"] = resultJSON["lorawan_device"]["app_key"].stringValue
                    self.infos["appSessKEY"] = resultJSON["lorawan_device"]["app_s_key"].stringValue
                    self.infos["devAddr"] = resultJSON["lorawan_device"]["dev_addr"].stringValue
                    self.infos["netSessKEY"] = resultJSON["lorawan_device"]["nwk_s_key"].stringValue
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
