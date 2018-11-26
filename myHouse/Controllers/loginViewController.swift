//
//  loginViewController.swift
//  myHouse
//
//  Created by Romain SERCER on 11/11/2018.
//  Copyright © 2018 fr.myHouse. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var appNameTextField: UITextField!
    
    @IBOutlet weak var accessKeyTextField: UITextField!
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        // Saving in UserDefault App information
        UserDefaults.standard.set(appNameTextField.text, forKey: "appName")
        UserDefaults.standard.set(accessKeyTextField.text, forKey: "accessKey")
        UserDefaults.standard.set(true, forKey: "status")
        
        Switcher.updateRootVC()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
     
    }
}
