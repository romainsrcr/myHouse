//
//  DeviceCollectionViewControlller.swift
//  myHouse
//
//  Created by loic.chacornac on 10/11/2018.
//  Copyright © 2018 fr.myHouse. All rights reserved.
//

import UIKit
import MapKit

let devices = [
    Device(name: "Sodaq Loïc", iconName: "sodaq_explorer", sensors: ["CO2", "Temperature"], coordinate: CLLocationCoordinate2D(latitude: 55.70820200, longitude: 12.51134400)),
    Device(name: "Sodaq Romain", iconName: "sodaq_explorer", sensors: ["CO2", "Temperature"], coordinate: CLLocationCoordinate2D(latitude: 55.70820200, longitude: 12.51134400))
]

class DeviceCollectionViewControlller: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return devices.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! DeviceCellViewController
        cell.Name.text = devices[indexPath.item].title
        
        cell.contentView.layer.cornerRadius = 25.0
        cell.contentView.layer.masksToBounds = true
        
        cell.layer.cornerRadius = 25.0
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor.clear.cgColor
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        
        return cell
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
