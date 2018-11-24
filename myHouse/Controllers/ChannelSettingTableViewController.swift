//
//  ChannelSettingTableViewController.swift
//  myHouse
//
//  Created by Romain SERCER on 16/11/2018.
//  Copyright © 2018 fr.myHouse. All rights reserved.
//

import UIKit

class ChannelSettingTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var firstCell : UITableViewCell?
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var textSetting: UILabel!
    
    @IBOutlet weak var addChannelButton: UIBarButtonItem!
    
    @IBAction func switchCustomMode(_ sender: UISwitch) {
        if (sender.isOn == false) {
            updateMode(mode: false)
            textSetting.text = "You just have to complete the type of data and the unit"
        } else {
            updateMode(mode: true)
            textSetting.text = "You have to complete all informations about the channel that you're using"
        }
        reloadView()
    }
    
    func checkAdvancedMode() -> Bool {
        if (Application.advancedMode == false) {
            return false
        } else {
            return true
        }
    }
    
    func updateMode(mode : Bool) {
        Application.advancedMode = mode
    }
    
    func reloadView() {
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Application.customMode == false ? (self.addChannelButton.isEnabled = false) : (self.addChannelButton.isEnabled = true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadView()
        
    }
    
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        if checkAdvancedMode() == true {
            return 2
        } else {
            return 1
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 1) {
            return Application.myChannels.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : UITableViewCell
        
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "modeCell", for: indexPath)
            cell.textLabel?.text = "Advanced Mode"
            firstCell = cell
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath)
            
            let keyOfmyChannelDictionary = Application.myChannels.keys
            let intArrayToIterate = Array(keyOfmyChannelDictionary.map { Int($0) })
            
            cell.textLabel?.text = "Channel \(intArrayToIterate[indexPath.row])"
            
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "showModifyAndDeleteChannelSegue" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destination = segue.destination as! ChannelDeleteAnsModifyViewController
                destination.channel = Application.myChannels[indexPath.row]
            }
        }
    }
    
    @IBAction func unwindToChannelViewController(segue:UIStoryboardSegue) {
        
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
