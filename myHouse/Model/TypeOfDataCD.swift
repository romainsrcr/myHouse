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
    
    static func getUnitFor(name:String) -> String{
        let request: NSFetchRequest<TypeOfDataCD> = TypeOfDataCD.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", name)
        guard let typeOfData = try? AppDelegate.viewContext.fetch(request) else {
            return ""
        }
        if typeOfData.isEmpty {
            return ""
        }
        else {
            return typeOfData[0].unit!
        }
    }
}
