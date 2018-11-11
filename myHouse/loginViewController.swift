//
//  loginViewController.swift
//  myHouse
//
//  Created by Romain SERCER on 11/11/2018.
//  Copyright © 2018 fr.myHouse. All rights reserved.
//

import UIKit

class loginViewController: UIViewController {

    @IBOutlet weak var appNameTextField: UITextField!
    
    @IBOutlet weak var accessKeyTextField: UITextField!
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        if appNameTextField.text == "test" && accessKeyTextField.text == "test" {
            UserDefaults.standard.set(true, forKey: "status")
            Switcher.updateRootVC()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
