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
    
    @IBOutlet weak var Name: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        Name.text = sensor!.transformToBeautiful()
    }
}
