//
//  FirstViewController.swift
//  myHouse
//
//  Created by Romain SERCER on 25/10/2018.
//  Copyright © 2018 fr.myHouse. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var nameAppTextField: UITextField!
    
    @IBOutlet weak var accesKeyTextField: UITextField!
    
    @IBOutlet weak var logInButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    @IBAction func didPressLogIn(_ sender: Any) {
        print(nameAppTextField.text!)
        print(accesKeyTextField.text!)
        
    }
    

}

