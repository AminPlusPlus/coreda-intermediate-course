//
//  CompaniesViewController.swift
//  Coredata-course
//
//  Created by Aminjoni Abdullozoda on 7/3/19.
//  Copyright © 2019 Aminjoni Abdullozoda. All rights reserved.
//

import UIKit
import CoreData

class CompaniesViewController: UITableViewController {
   
 
    
    var companies = [Company]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        companies = CoreDataManagement.shared.fetchData()
        
        view.backgroundColor = .white
        navigationItem.title = "Companies"
        
        tableView.backgroundColor = .darkBlue
        //tableView.separatorStyle = .none
        tableView.separatorColor = .white
        tableView.register(CompanyCell.self, forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reset", style: .done, target: self, action: #selector(reset))
        
        let addBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBtnPressed))
            addBtn.tintColor = .white
       
        navigationItem.rightBarButtonItem = addBtn
        
    }

    @objc private func reset(){
        
        //gurrenc context
        let currentContext = CoreDataManagement.shared.persistanceContainer.viewContext
        
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: Company.fetchRequest())
        
        do {
            try  currentContext.execute(batchDeleteRequest)
            
            var indexPathRow = [IndexPath]()
            
            for (index, _) in companies.enumerated() {
                let indexPath = IndexPath(row: index, section: 0)
                indexPathRow.append(indexPath)
            }
            self.companies.removeAll()
            self.tableView.deleteRows(at: indexPathRow, with: .left)
            
        } catch let delErr {
            print("Failed to delete objects",delErr )
        }
        
    }
    
    @objc private func addBtnPressed() {
        let createCompanyVC = CreateCompanyViewController()
        let createCompanyNC = CustomNavigationController(rootViewController: createCompanyVC)
        
        createCompanyVC.delegate = self
        
        present(createCompanyNC, animated: true, completion: nil)
    }

}

