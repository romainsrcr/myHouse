//
//  loginViewController.swift
//  myHouse
//
//  Created by Romain SERCER on 11/11/2018.
//  Copyright © 2018 fr.myHouse. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    let alertLogIn = UIAlertController(title: "Empty text fields", message: "Please fill the missing field", preferredStyle: .alert)

    @IBOutlet weak var appNameTextField: UITextField!
    
    @IBOutlet weak var accessKeyTextField: UITextField! 
    
    @IBAction func demoButtonLogIn(_ sender: UIButton) {
        UserDefaults.standard.set("project_iot_dtu", forKey: "appName")
        UserDefaults.standard.set("ttn-account-v2.aoC_LAYJ5OE21VzyAmFRmtKKC5c5aQx4BA9y6-1Ijow", forKey: "accessKey")
        UserDefaults.standard.set(true, forKey: "status")
        
        Switcher.updateRootVC()
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        // Check if one the textFields are empties
        guard let checkIfAppNameTextFieldIsEmpty = appNameTextField.text, let checkIfAccessKeyTextFieldIsEmpty = accessKeyTextField.text, !checkIfAppNameTextFieldIsEmpty.isEmpty && !checkIfAccessKeyTextFieldIsEmpty.isEmpty else {
            return self.present(alertLogIn, animated: true, completion: nil)
        }
        // Saving in UserDefault App information
        UserDefaults.standard.set(appNameTextField.text, forKey: "appName")
        UserDefaults.standard.set(accessKeyTextField.text, forKey: "accessKey")
        UserDefaults.standard.set(true, forKey: "status")
        
        Switcher.updateRootVC()
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        alertLogIn.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
     
    }
}
