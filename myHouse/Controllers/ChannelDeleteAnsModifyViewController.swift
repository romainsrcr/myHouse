//
//  ChannelDeleteAnsModifyViewController.swift
//  myHouse
//
//  Created by Romain SERCER on 21/11/2018.
//  Copyright © 2018 fr.myHouse. All rights reserved.
//

import UIKit

class ChannelDeleteAnsModifyViewController: UIViewController {
    
    @IBOutlet weak var channelNumberLabel: UILabel!

    @IBOutlet weak var typeOfDataTextField: UITextField!
    
    @IBOutlet weak var unitTextField: UITextField!
    
    var channel : Channel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        channelNumberLabel.text = "Channel \(String(describing: channel!.numberChannel))"
        typeOfDataTextField.text = channel!.typeOfData
        unitTextField.text = channel!.unit
        
        
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
