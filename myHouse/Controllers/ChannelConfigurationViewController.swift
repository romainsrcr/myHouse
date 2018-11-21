//
//  ChannelConfigurationViewController.swift
//  myHouse
//
//  Created by Romain SERCER on 21/11/2018.
//  Copyright © 2018 fr.myHouse. All rights reserved.
//

import UIKit

class ChannelConfigurationViewController: UIViewController {

    @IBOutlet weak var channelNumberLabel: UILabel!
    
    @IBOutlet weak var typeOfDataTextField: UITextField!
    
    @IBOutlet weak var unitTextField: UITextField!
    
    @IBAction func saveChannelConfiguration(_ sender: UIButton) {
        Application.myChannels.append(Channel(numberChannel: Application.myChannels.count + 1, typeOfData: typeOfDataTextField.text!, unit: unitTextField.text!))
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        channelNumberLabel.text = "Channel \(Application.myChannels.count + 1)"
        // Do any additional setup after loading the view.
        
        
        
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
