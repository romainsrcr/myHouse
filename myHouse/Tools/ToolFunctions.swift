//
//  toolFunction.swift
//  myHouse
//
//  Created by Romain SERCER on 25/11/2018.
//  Copyright © 2018 fr.myHouse. All rights reserved.
//

import Foundation

func checkAdvancedMode() -> Bool {
    if (Application.advancedMode == false) {
        return false
    } else {
        return true
    }
}

func updateMode(mode : Bool) -> String {
    Application.advancedMode = mode
    return mode == false ? "You just have to complete the type of data and the unit" : "You have to complete all informations about the channel that you're using"
}
    
