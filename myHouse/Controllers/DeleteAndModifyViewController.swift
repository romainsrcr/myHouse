//
//  ChannelDeleteAnsModifyViewController.swift
//  myHouse
//
//  Created by Romain SERCER on 21/11/2018.
//  Copyright © 2018 fr.myHouse. All rights reserved.
//

import UIKit
import CoreData

class DeleteAndModifyViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    var channel : ChannelCD?
    
    var pickerData: [String] = []
    
    var type : String = "Int"
    
    let alertNumberChannelAlreadyUse = UIAlertController(title: "This number of channel is already use of another type of data", message: nil, preferredStyle: .alert)
    
    let alertFieldEmpty = UIAlertController(title: "Empty text fields", message: "Please fill the missing field(s)", preferredStyle: .alert)

    @IBOutlet weak var channelNumberLabel: UILabel!

    @IBOutlet weak var numberChannelTextField: UITextField!
    
    @IBOutlet weak var typeOfDataTextField: UITextField!
    
    @IBOutlet weak var unitTextField: UITextField!
    
    @IBOutlet weak var typeOfUplink: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        pickerData = ["Int","Float", "String"]
        
        // Initialization of outlets
        
        channelNumberLabel.text = ("Channel \(channel!.numberChannel)")
        numberChannelTextField.text = String(channel!.numberChannel)
        typeOfDataTextField.text = channel!.name
        unitTextField.text = channel!.unit
        typeOfUplink.selectRow(pickerData.index(of : channel!.typeOfUplink!)!, inComponent:0, animated:true)
        
        // Alert configuration
        alertNumberChannelAlreadyUse.addTextField(configurationHandler: { textField in
            textField.delegate = self
            textField.keyboardType = UIKeyboardType.numberPad
            textField.placeholder = "Please enter another channel"
            
        })
        
        alertNumberChannelAlreadyUse.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            if let numberChannelModified = self.alertNumberChannelAlreadyUse.textFields?.first?.text {
                    self.channelNumberLabel.text = ("Channel \(numberChannelModified)")
                    self.numberChannelTextField.text = numberChannelModified }
        }))
        
        alertFieldEmpty.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "deleteChannel" {
            //Application.myChannels.removeValue(forKey: Int(channel!.numberChannel))
            let context = AppDelegate.viewContext
            
            let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "ChannelCD")
            
            deleteFetch.predicate = NSPredicate(format: "numberChannel == %d", channel!.numberChannel)
            
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
        if identifier == "modifyChannel" {
            if self.checkEmptyFiedl() == false {
                self.present(alertFieldEmpty, animated: true, completion: nil)
                return false
            }
            if self.updateChannel() { // return true if an error occured
                self.present(alertNumberChannelAlreadyUse, animated: true)
                return false
            }
        }
        return true
    }
    
    func updateChannel() -> Bool {
        let key: Int? = Int(numberChannelTextField.text!)
        if key! != channel!.numberChannel {
            if Application.myChannels.keys.contains(key!) == false {
            
                //Remove the old channel
                Application.myChannels.removeValue(forKey: Int(channel!.numberChannel))
            
                //Check if the number channel is already use
                Application.myChannels[key!] = Channel(numberChannel: key!, typeOfData: typeOfDataTextField.text!, unit: unitTextField.text!, typeOfUplink : type)
            
                return false
            
            } else {
                
                return true
            }
        } else {
            Application.myChannels[key!] = Channel(numberChannel: key!, typeOfData: typeOfDataTextField.text!, unit: unitTextField.text!, typeOfUplink : type)
            return false
        }
    }
    
    func checkEmptyFiedl() -> Bool {
        // Check if one the textFields are empties
        guard let checkIfChannelNumberTextFieldIsEmpty = numberChannelTextField.text,
            let checkIfTypeOfDataTextFieldIsEmpty = typeOfDataTextField.text,
            let checkIfUnitTextFieldIsEmpty = unitTextField.text,
            !checkIfChannelNumberTextFieldIsEmpty.isEmpty && !checkIfTypeOfDataTextFieldIsEmpty.isEmpty && !checkIfUnitTextFieldIsEmpty.isEmpty
            else {
                // If one of them are empties
                return false
            }
        return true
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        type = pickerData[row]
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return string.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
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
