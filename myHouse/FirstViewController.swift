//
//  FirstViewController.swift
//  myHouse
//
//  Created by Romain SERCER on 25/10/2018.
//  Copyright © 2018 fr.myHouse. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBAction func logOutButtonTapped(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "status")
        UserDefaults.standard.removeObject(forKey: "appName")
        UserDefaults.standard.removeObject(forKey: "accessKey")
        Switcher.updateRootVC()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

}

