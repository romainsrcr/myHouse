//
//  ChannelConfigurationViewController.swift
//  myHouse
//
//  Created by Romain SERCER on 21/11/2018.
//  Copyright © 2018 fr.myHouse. All rights reserved.
//

import UIKit

class AdvancedModeChannelConfigurationViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    
    @IBOutlet weak var channelNumberTextField: UITextField!
    
    @IBOutlet weak var typeOfDataTextField: UITextField!
    
    @IBOutlet weak var unitTextField: UITextField!
    
    @IBOutlet weak var typeOfUplink: UIPickerView!
    
    var pickerData: [String] = []
    var type : String = ""
    

    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        let channel: Int? = Int(channelNumberTextField.text!)
        Application.myChannels[channel!] = Channel(numberChannel: channel!, typeOfData: typeOfDataTextField.text!, unit: unitTextField.text!, typeOfUplink : type)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerData = ["Int","Float", "String"]
        
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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
