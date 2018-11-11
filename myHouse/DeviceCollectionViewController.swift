//
//  DeviceCollectionViewControlller.swift
//  myHouse
//
//  Created by loic.chacornac on 10/11/2018.
//  Copyright © 2018 fr.myHouse. All rights reserved.
//

import UIKit

class DeviceCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var devices:[Device] = []
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellWidth: CGFloat
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            cellWidth = ((view.frame.size.width - 20) / 2) - 20
        case .pad:
            cellWidth = ((view.frame.size.width - 20) / 3) - 20
        case .unspecified:
            cellWidth = ((view.frame.size.width - 20) / 2) - 20
        case .tv:
            cellWidth = ((view.frame.size.width - 20) / 5) - 20
        case .carPlay:
            cellWidth = ((view.frame.size.width - 20) / 4) - 20
        }
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        
        Application.getDevices(success: {(devices) -> Void in self.devices = devices; self.collectionView.reloadData()} )
        
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
