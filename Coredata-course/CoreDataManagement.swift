//
//  CoreDataManagement.swift
//  Coredata-course
//
//  Created by Aminjoni Abdullozoda on 7/17/19.
//  Copyright © 2019 Aminjoni Abdullozoda. All rights reserved.
//

import Foundation
import CoreData

struct CoreDataManagement {
    
    static let shared = CoreDataManagement()
    
    let persistanceContainer : NSPersistentContainer = {
        //initializa
        let persistanceContainer = NSPersistentContainer(name: "Coredata_course")
        //load
        persistanceContainer.loadPersistentStores(completionHandler: { (persistentHandle, error) in
            
            if let err = error {
                fatalError("Here is issue \(err)")
            }
        })
        
        return persistanceContainer
    }()
}
