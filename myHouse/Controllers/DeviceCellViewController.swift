//
//  DeviceCollectionViewController.swift
//  myHouse
//
//  Created by loic.chacornac on 10/11/2018.
//  Copyright © 2018 fr.myHouse. All rights reserved.
//

import UIKit

class DeviceCellViewController: UICollectionViewCell {
    var device: Device?
    var sensor: String?
    var unit: String?
    var valueString: String?
    
    @IBOutlet weak var Value: UILabel!
    @IBOutlet weak var Name: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        Name.text = device!.title!
        valueString = (device!.datas[sensor!]!["data"]!.last! as! Double).clean
        
        if Application.advancedMode == true {

            unit = ChannelCD.getUnitFor(typeOfUplink: sensor!)
        }
        
        Value.text = (valueString! + " " + unit!)
    }
}
