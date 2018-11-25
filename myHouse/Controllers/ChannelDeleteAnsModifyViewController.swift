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
    
    var type : String = ""

    @IBOutlet weak var channelNumberLabel: UILabel!

    @IBOutlet weak var numberChannelTextField: UITextField!
    
    @IBOutlet weak var typeOfDataTextField: UITextField!
    
    @IBOutlet weak var unitTextField: UITextField!
    
    @IBOutlet weak var typeOfUplink: UIPickerView!
    
    @IBAction func deleteChannel(_ sender: UIBarButtonItem) {
        Application.myChannels.removeValue(forKey: channel!.numberChannel)
    }

    @IBAction func modifyChannel(_ sender: UIButton) {
        //Remove the old channel
        Application.myChannels.removeValue(forKey: channel!.numberChannel)
        
        //Creating a new channel
        let key: Int? = Int(numberChannelTextField.text!)
        Application.myChannels[key!] = Channel(numberChannel: key!, typeOfData: typeOfDataTextField.text!, unit: unitTextField.text!, typeOfUplink : type)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerData = ["Int","Float", "String"]
        
        channelNumberLabel.text = ("Channel \(channel!.numberChannel)")
        numberChannelTextField.text = String(channel!.numberChannel)
        typeOfDataTextField.text = channel!.typeOfData
        unitTextField.text = channel!.unit
        typeOfUplink.selectRow(pickerData.index(of : channel!.typeOfUplink)!, inComponent:0, animated:true)

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
