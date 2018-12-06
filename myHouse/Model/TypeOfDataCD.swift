//
//  TypeOfDataCD.swift
//  myHouse
//
//  Created by Romain SERCER on 06/12/2018.
//  Copyright © 2018 fr.myHouse. All rights reserved.
//

import Foundation
import CoreData

class TypeOfDataCD: NSManagedObject {
    
    static var all: [TypeOfDataCD] {
        
        let request: NSFetchRequest<TypeOfDataCD> = TypeOfDataCD.fetchRequest()
        guard let typeOfDatas = try? AppDelegate.viewContext.fetch(request) else {
            return []
        }
        return typeOfDatas
    }
}
