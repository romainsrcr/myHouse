//
//  DeviceCollectionViewControlller.swift
//  myHouse
//
//  Created by loic.chacornac on 10/11/2018.
//  Copyright © 2018 fr.myHouse. All rights reserved.
//

import UIKit

class DeviceCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    private let refreshControl = UIRefreshControl()
    
    
    override func viewDidLoad() {
        //initialise the parent
        super.viewDidLoad()
        
        //Calculate the width of each cell fro each devices
        let cellWidth: CGFloat
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            cellWidth = ((UIScreen.main.bounds.width - 20) / 2) - 20
        case .pad:
            cellWidth = ((UIScreen.main.bounds.width - 20) / 3) - 20
        case .unspecified:
            cellWidth = ((UIScreen.main.bounds.width - 20) / 2) - 20
        case .tv:
            cellWidth = ((UIScreen.main.bounds.width - 20) / 5) - 20
        case .carPlay:
            cellWidth = ((UIScreen.main.bounds.width - 20) / 4) - 20
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
        Application.getDevices(success: {() -> Void in self.reloadView()} )
    }
    
    func reloadView(){
        self.collectionView.reloadData()
        for i in 0..<Application.devices.count {
            Application.devices[i].getData(success: {() -> Void in
                self.collectionView.reloadSections(IndexSet(integer: i))
            })
        }
        self.refreshControl.endRefreshing()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Application.devices.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(Application.devices[section].datas)
        return Application.devices[section].datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! DeviceCellViewController
        
        cell.device = Application.devices[indexPath.section]
        cell.sensor = Array(Application.devices[indexPath.section].datas.keys)[indexPath.row]
        
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
                destination.device = Application.devices[indexPath.section]
                destination.sensor = Array(Application.devices[indexPath.section].datas.keys)[indexPath.row]
            }
        }
    }
    
}
