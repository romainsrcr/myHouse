//
//  DeviceSettingsTableViewController.swift
//  myHouse
//
//  Created by Loïc CHACORNAC on 16/11/2018.
//  Copyright © 2018 fr.myHouse. All rights reserved.
//

import UIKit

class DeviceSettingsTableViewController: UITableViewController {

    var device: Device?
    
    @IBOutlet weak var DevEUI: UILabel!
    @IBOutlet weak var AppEUI: UILabel!
    @IBOutlet weak var AppKEY: UILabel!
    @IBOutlet weak var DevAddr: UILabel!
    @IBOutlet weak var NetSessKEY: UILabel!
    @IBOutlet weak var AppSessKEY: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(getDataAndReload), for: .valueChanged)
        tableView.addSubview(refreshControl!)
        
        getDataAndReload()
    }
    
    
    @objc func getDataAndReload(){
        device?.getInfo(success: { () -> Void in self.reloadView() })
    }
    
    func reloadView(){
        DevEUI.text? = (device?.infos["devEUI"])!
        AppEUI.text? = (device?.infos["appEUI"])!
        AppKEY.text? = (device?.infos["appKEY"])!
        
        DevAddr.text? = (device?.infos["devAddr"])!
        NetSessKEY.text? = (device?.infos["netSessKEY"])!
        AppSessKEY.text? = (device?.infos["appSessKEY"])!
        
        //self.tableView.reloadData()
        refreshControl?.endRefreshing()
    }
    
}
