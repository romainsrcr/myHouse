//
//  SettingTableViewController.swift
//  myHouse
//
//  Created by Romain SERCER on 12/11/2018.
//  Copyright © 2018 fr.myHouse. All rights reserved.
//

import UIKit

class SettingTableViewController: UITableViewController {
    
    let alertLogOut = UIAlertController(title: "Logout", message: "Are you sure you want to logout ?", preferredStyle: .actionSheet)
    
    @IBOutlet weak var appNameInSetting: UILabel!
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 && indexPath.row == 0 {
            
            if let popoverController = alertLogOut.popoverPresentationController {
                popoverController.sourceView = self.view
            }
            self.present(alertLogOut, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alertLogOut.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { action in
            self.logOut()
        }))
        alertLogOut.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        
        // Display name of application more natural
        appNameInSetting.text = Application.name.transformToBeautiful()
        
        
            
            // Uncomment the following line to preserve selection between presentations
            // self.clearsSelectionOnViewWillAppear = false
            
            // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
            // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func logOut() {
        UserDefaults.standard.set(false, forKey: "status")
        UserDefaults.standard.removeObject(forKey: "appName")
        UserDefaults.standard.removeObject(forKey: "accessKey")
        
        Switcher.updateRootVC()
    }
        
        // MARK: - Table view data source
            
        /*
         override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
         
         // Configure the cell...
         
         return cell
         }
         */
        
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
