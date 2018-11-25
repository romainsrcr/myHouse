//
//  Extensions.swift
//  myHouse
//
//  Created by Loïc CHACORNAC on 14/11/2018.
//  Copyright © 2018 fr.myHouse. All rights reserved.
//

import Foundation


extension String {
    func transformToBeautiful() -> String {
        
        return (prefix(1).uppercased() + self.lowercased().dropFirst()).replacingOccurrences(of: "_", with: " ", options: .literal, range: nil)
    }
    
    mutating func transformToBeautiful() {
        self = self.transformToBeautiful()
    }
}

extension Double {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
