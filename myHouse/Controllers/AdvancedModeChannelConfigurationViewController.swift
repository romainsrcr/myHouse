//
//  ChannelConfigurationViewController.swift
//  myHouse
//
//  Created by Romain SERCER on 21/11/2018.
//  Copyright © 2018 fr.myHouse. All rights reserved.
//

import UIKit
import CoreData

class AdvancedModeChannelConfigurationViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    let alertFieldEmpty = UIAlertController(title: "Empty text field(s)", message: "Please fill the missing field(s)", preferredStyle: .alert)
    let alertFieldChannelUse = UIAlertController(title: "Channel already used", message: "Please change the channel number", preferredStyle: .alert)
    
    @IBOutlet weak var channelNumberTextField: UITextField!
    
    @IBOutlet weak var typeOfDataTextField: UITextField!
    
    @IBOutlet weak var unitTextField: UITextField!
    
    @IBOutlet weak var typeOfUplink: UIPickerView!
    
    var pickerData: [String] = []
    
    var type : String = "Int"       // Initialisazion of type variable
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        pickerData = ["Int", "Float", "String"]
        
        alertFieldEmpty.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    
        alertFieldChannelUse.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {}
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "saveAdvancedMode" {
            if checkEmptyFiedl() == false {
                self.present(alertFieldEmpty, animated: true, completion: nil)
                return false
            }
        }
        return true
    }
    
    func checkEmptyFiedl() -> Bool {
        // Check if one the textFields are empties
        guard let checkIfChannelNumberTextFieldIsEmpty = channelNumberTextField.text,
            let checkIfTypeOfDataTextFieldIsEmpty = typeOfDataTextField.text,
            let checkIfUnitTextFieldIsEmpty = unitTextField.text,
            !checkIfChannelNumberTextFieldIsEmpty.isEmpty && !checkIfTypeOfDataTextFieldIsEmpty.isEmpty && !checkIfUnitTextFieldIsEmpty.isEmpty
        else {
            // If one of them are empties
            return false
        }
        // Add the channel
        let channel: Int? = Int(channelNumberTextField.text!)
        //Application.myChannels[channel!] = Channel(numberChannel: channel!, typeOfData: typeOfDataTextField.text!, unit: unitTextField.text!, typeOfUplink : type)
        
        // Verify if the channel already exist
        let context = AppDelegate.viewContext
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "ChannelCD")
        fetch.predicate = NSPredicate(format: "numberChannel == %d", channel!)
        
        if try! !context.fetch(fetch).isEmpty {
            self.present(alertFieldChannelUse, animated: true, completion: nil)
            return false
        } else {
            saveChannelInCoreData(numberChannel: channel!, name : typeOfDataTextField.text!, unit : unitTextField.text!, typeOfUplink: type)
            return true
        }
    }
    
    private func saveChannelInCoreData(numberChannel : Int, name : String, unit : String, typeOfUplink : String) {
        let channel = ChannelCD(context: AppDelegate.viewContext)
        channel.numberChannel = Int16(numberChannel)
        channel.name = name
        channel.unit = unit
        channel.typeOfUplink = typeOfUplink
        
        do {
            try AppDelegate.viewContext.save()
        } catch let error as NSError{
            print("Error: \(error.localizedDescription)")
        }
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
