//
//  NormalModeConfigurationViewController.swift
//  myHouse
//
//  Created by Romain SERCER on 25/11/2018.
//  Copyright © 2018 fr.myHouse. All rights reserved.
//

import UIKit
import CoreData

class NormalModeConfigurationViewController: UIViewController {
    
    
    let alertFieldEmpty = UIAlertController(title: "Empty text fields", message: "Please fill the missing field(s)", preferredStyle: .alert)
    
    let alertFieldtypeOfDataUsed = UIAlertController(title: "Type of data already used", message: "Please change the type of data name", preferredStyle: .alert)

    @IBOutlet weak var typeOfDataTextField: UITextField!
    @IBOutlet weak var unitTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        alertFieldEmpty.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        alertFieldtypeOfDataUsed.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {}
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "saveNormalMode" {
            if checkEmptyFiedl() == false {
                self.present(alertFieldEmpty, animated: true, completion: nil)
                return false
            }
        }
        return true
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
        // Add the channel
        let nameTypeOfData: String? = typeOfDataTextField.text
        
        // Verify if the channel already exist
        let context = AppDelegate.viewContext
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "TypeOfDataCD")
        fetch.predicate = NSPredicate(format: "name == %@", nameTypeOfData!)
        
        if try! !context.fetch(fetch).isEmpty {
            self.present(alertFieldtypeOfDataUsed, animated: true, completion: nil)
            return false
        } else {
            saveTypeOfDataInCoreData(name : typeOfDataTextField.text!, unit : unitTextField.text!)
            return true
        }
    }
    
    private func saveTypeOfDataInCoreData(name : String, unit : String) {
        let typeOfData = TypeOfDataCD(context: AppDelegate.viewContext)
        typeOfData.name = name
        typeOfData.unit = unit
        
        do {
            try AppDelegate.viewContext.save()
        } catch let error as NSError{
            print("Error: \(error.localizedDescription)")
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
