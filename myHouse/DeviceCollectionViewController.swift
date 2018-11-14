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
    private let refreshControl = UIRefreshControl()
    
    
    override func viewDidLoad() {
        //initialise the parent
        super.viewDidLoad()
        
        //Calculate the width of each cell fro each devices
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
        
        //Setup the refresh controller
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(getDataAndReload), for: .valueChanged)
        
        //fetch the data from the API
        getDataAndReload()
        
    }
    
    @objc func getDataAndReload(){
        Application.getDevices(success: {(devices) -> Void in self.reloadView(devices: devices)} )
    }
    
    func reloadView(devices: [Device]){
        self.devices = devices;
        self.collectionView.reloadData()
        print(devices.count)
        for i in 0..<devices.count {
            self.devices[i].getData(success: {() -> Void in
                self.collectionView.reloadSections(IndexSet(integer: i))
            })
        }
        self.refreshControl.endRefreshing()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return devices.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return devices[section].datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! DeviceCellViewController
        cell.Name.text = devices[indexPath.section].title
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDeviceDetailsSegue" {
            if let indexPath = self.collectionView?.indexPath(for: sender as! DeviceCellViewController) {
                let destination = segue.destination as! DeviceDetailsViewController
                destination.device = devices[indexPath.row]
            }
        }
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
