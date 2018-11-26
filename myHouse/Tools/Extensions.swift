//
//  Extensions.swift
//  myHouse
//
//  Created by Loïc CHACORNAC on 14/11/2018.
//  Copyright © 2018 fr.myHouse. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func transformToBeautiful() -> String {
        
        return (prefix(1).uppercased() + self.lowercased().dropFirst()).replacingOccurrences(of: "_", with: " ", options: .literal, range: nil)
    }
    
    mutating func transformToBeautiful() {
        self = self.transformToBeautiful()
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
