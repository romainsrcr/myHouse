//
//  DeleteAndModifyTypeOfDataViewController.swift
//  myHouse
//
//  Created by Romain SERCER on 06/12/2018.
//  Copyright © 2018 fr.myHouse. All rights reserved.
//

import UIKit
import CoreData

class DeleteAndModifyTypeOfDataViewController: UIViewController {
    
    var typeofdata : TypeOfDataCD?

    @IBOutlet weak var typeOfDataTextField: UITextField!
    @IBOutlet weak var unitTextField: UITextField!
    
    let alertFieldEmpty = UIAlertController(title: "Empty text fields", message: "Please fill the missing field(s)", preferredStyle: .alert)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

        // Initialization of outlets
        typeOfDataTextField.text = typeofdata!.name
        typeOfDataTextField.isUserInteractionEnabled = false
        unitTextField.text = typeofdata!.unit

        // Alert configuration
        alertFieldEmpty.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "deleteModifyTypeOfData" {
            let context = AppDelegate.viewContext
            
            let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "TypeOfDataCD")
            
            deleteFetch.predicate = NSPredicate(format: "name == %@", typeofdata!.name!)
            
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
            
            do {
                try context.execute(deleteRequest)
                try context.save()
            } catch let error as NSError{
                print("Error: \(error.localizedDescription)")
            }
            
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "modifyTypeOfData" {
            if self.checkEmptyFiedl() == false {
                self.present(alertFieldEmpty, animated: true, completion: nil)
                return false
            }
            if self.updateChannel() { // return true if an error occured
                return false
            }
        }
        return true
    }
    
    func updateChannel() -> Bool {
        let key: String? = typeOfDataTextField.text
        
        let context = AppDelegate.viewContext
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "TypeOfDataCD")
        fetch.predicate = NSPredicate(format: "name == %@", typeofdata!.name!)
        
        do {
            let updateFetch = try context.fetch(fetch)
            
            let typeOfDataUpdate = updateFetch[0] as! NSManagedObject
            typeOfDataUpdate.setValue(key, forKey: "name")
            typeOfDataUpdate.setValue(unitTextField.text!, forKey: "unit")
           
            do {
                try context.save()
                return false
            } catch let error as NSError{
                print("Error: \(error.localizedDescription)")
                return true
            }
        } catch let error as NSError{
            print("Error: \(error.localizedDescription)")
            return false
        }
    }
    
    func checkEmptyFiedl() -> Bool {
        // Check if one the textFields are empties
        guard let checkIfTypeOfDataTextFieldIsEmpty = typeOfDataTextField.text,
            let checkIfUnitTextFieldIsEmpty = unitTextField.text,
          !checkIfTypeOfDataTextFieldIsEmpty.isEmpty && !checkIfUnitTextFieldIsEmpty.isEmpty
            else {
                // If one of them are empties
                return false
        }
        return true
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
