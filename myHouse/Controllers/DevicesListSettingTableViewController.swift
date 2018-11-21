//
//  DevicesSettingTableViewController.swift
//  myHouse
//
//  Created by Loïc CHACORNAC on 16/11/2018.
//  Copyright © 2018 fr.myHouse. All rights reserved.
//

import UIKit

class DevicesListSettingTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.refreshControl = refreshControl
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(getDataAndReload), for: .valueChanged)
        tableView.addSubview(refreshControl!)
        
        getDataAndReload()
    }
    
    @objc func getDataAndReload(){
        Application.getDevices(success: {() -> Void in self.reloadView()} )
    }
    
    func reloadView(){
        self.tableView.reloadData()
        refreshControl?.endRefreshing()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Application.devices.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = Application.devices[indexPath.item].title
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDeviceSettingsSegue" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destination = segue.destination as! DeviceSettingsTableViewController
                destination.device = Application.devices[indexPath.item]
            }
        }
    }
}
