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
    
    //MARK:- Fetch companies data
    func fetchData () -> [Company]{
        
        //get context
        let persistenceContext = persistanceContainer.viewContext
        
        //fetch request
        let fetchRequest = NSFetchRequest<Company>(entityName: "Company")
        
        do {
            let companies =  try persistenceContext.fetch(fetchRequest)
            
            return companies
            //self.tableView.reloadData()
        } catch let err {
            print("error ",err)
            return []
        }
        
    }
}
