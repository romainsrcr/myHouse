//
//  ChannelSettingTableViewController.swift
//  myHouse
//
//  Created by Romain SERCER on 16/11/2018.
//  Copyright © 2018 fr.myHouse. All rights reserved.
//

import UIKit
import CoreData

class ChannelSettingTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var firstCell : UITableViewCell?
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var textSettingComment: UILabel!
    
    @IBAction func switchCustomMode(_ sender: UISwitch) {
        textSettingComment.text = updateMode(mode : sender.isOn)
    }
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        if Application.advancedMode == true {
            self.performSegue(withIdentifier: "AdvancedModeAddingChannel", sender: nil)
        } else {
            self.performSegue(withIdentifier: "NormalModeAddInformation", sender: nil)
        }
    }
    
    func reloadView() {
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // For test
        deleteAllRecords()
        
        if Application.advancedMode == true {
            textSettingComment.text = "You have to complete all informations about the channel that you're using"
        } else {
            textSettingComment.text = "You just have to complete the type of data and the unit"
        }
        reloadView()
    }
    
    
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        if Application.advancedMode == true {
            return 2
        } else {
            return 1
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 1) {
            let channelFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "ChannelCD")
            let context = AppDelegate.viewContext
            do {
                let count = try context.count(for: channelFetch)
                return count
            } catch let error as NSError {
                print("Error: \(error.localizedDescription)")
            }
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
            
            //let keyOfmyChannelDictionary = Application.myChannels.keys
            //let intArrayToIterate = Array(keyOfmyChannelDictionary.map { Int($0) })
            
            var intArrayToIterate : [Int16] = []
            for channel in ChannelCD.all {
                intArrayToIterate.append(Int16(channel.numberChannel))
            }
            print(intArrayToIterate)
            
            cell.textLabel?.text = "Channel \(intArrayToIterate[indexPath.row])"
            
        }
        return cell
    }
    
    func deleteAllRecords() {
        let context = AppDelegate.viewContext
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "ChannelCD")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch let error as NSError{
            print("Error: \(error.localizedDescription)")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "showModifyAndDeleteChannelSegue" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destination = segue.destination as! DeleteAndModifyViewController
                let i = Array(Application.myChannels.keys)[indexPath.row]
                destination.channel = Application.myChannels[i]
                
            }
        }
    }
    
    @IBAction func unwindToChannelViewController(segue:UIStoryboardSegue) {
        reloadView()
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
