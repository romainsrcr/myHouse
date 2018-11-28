//
//  ChannelDeleteAnsModifyViewController.swift
//  myHouse
//
//  Created by Romain SERCER on 21/11/2018.
//  Copyright © 2018 fr.myHouse. All rights reserved.
//

import UIKit

class ChannelDeleteAnsModifyViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var channel : Channel?
    
    var pickerData: [String] = []
    
    var type : String = "Int"
    
    let alertNumberChannelAlreadyUse = UIAlertController(title: "This number of channel is already use of another type of data", message: nil, preferredStyle: .alert)

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
        typeOfDataTextField.text = channel!.typeOfData
        unitTextField.text = channel!.unit
        typeOfUplink.selectRow(pickerData.index(of : channel!.typeOfUplink)!, inComponent:0, animated:true)
        
        // Alert configuration
        alertNumberChannelAlreadyUse.addTextField(configurationHandler: { textField in
            textField.placeholder = "Please enter another channel"
        })
        
        alertNumberChannelAlreadyUse.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            if let numberChannelModified = self.alertNumberChannelAlreadyUse.textFields?.first?.text {
                    self.channelNumberLabel.text = ("Channel \(numberChannelModified)")
                    self.numberChannelTextField.text = numberChannelModified
                    print("New Channel : \(numberChannelModified) and Deleted channel : \(self.channel!.numberChannel)")
                }
        }))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "deleteChannel" {
            Application.myChannels.removeValue(forKey: channel!.numberChannel)
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "modifyChannel" {
            if self.updateChannelNumber() { // return true if an error occured
                self.present(alertNumberChannelAlreadyUse, animated: true)
                return false
            }
        }
        return true
    }
    
    func updateChannelNumber() -> Bool {
        let key: Int? = Int(numberChannelTextField.text!)
        if Application.myChannels.keys.contains(key!) == false {
            
            //Remove the old channel
            Application.myChannels.removeValue(forKey: channel!.numberChannel)
            
            //Check if the number channel is already use
            Application.myChannels[key!] = Channel(numberChannel: key!, typeOfData: typeOfDataTextField.text!, unit: unitTextField.text!, typeOfUplink : type)
            
            return false
            
        } else {
            return true
        }
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
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

