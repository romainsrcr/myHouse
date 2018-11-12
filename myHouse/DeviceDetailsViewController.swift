//
//  DeviceDetailsViewController.swift
//  myHouse
//
//  Created by Loïc CHACORNAC on 12/11/2018.
//  Copyright © 2018 fr.myHouse. All rights reserved.
//

import UIKit

class DeviceDetailsViewController: UIViewController {
    
    var deviceDescription: String = ""

    @IBOutlet weak var DescriptionView: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DescriptionView.text = self.deviceDescription
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
