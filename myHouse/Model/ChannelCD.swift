//
//  ChannelCD.swift
//  myHouse
//
//  Created by Romain SERCER on 05/12/2018.
//  Copyright © 2018 fr.myHouse. All rights reserved.
//

import Foundation
import CoreData

class ChannelCD: NSManagedObject {
    
    static var all: [ChannelCD] {
        
        let request: NSFetchRequest<ChannelCD> = ChannelCD.fetchRequest()
        guard let channels = try? AppDelegate.viewContext.fetch(request) else {
            return []
        }
        return channels
    }

}
