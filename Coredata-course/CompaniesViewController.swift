//
//  CompaniesViewController.swift
//  Coredata-course
//
//  Created by Aminjoni Abdullozoda on 7/3/19.
//  Copyright © 2019 Aminjoni Abdullozoda. All rights reserved.
//

import UIKit
import CoreData

class CompaniesViewController: UITableViewController, CreateCompanyControllerDelegate {
   
    
    func didAddCompany(company: Company) {
        companies.append(company)
        let newIndexPath = IndexPath(row: companies.count - 1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
    
    
    private func fetchData (){

        //get context
        let persistenceContext = CoreDataManagement.shared.persistanceContainer.viewContext
        
        //fetch request
        let fetchRequest = NSFetchRequest<Company>(entityName: "Company")
        
        do {
           let companies =  try persistenceContext.fetch(fetchRequest)
            self.companies = companies
            self.tableView.reloadData()
        } catch let err {
            print("error ",err)
        }
        
    }
    
    var companies = [Company]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        fetchData()
        
        view.backgroundColor = .white
        navigationItem.title = "Companies"
        
        tableView.backgroundColor = .darkBlue
        //tableView.separatorStyle = .none
        tableView.separatorColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView()
        
        let addBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBtnPressed))
            addBtn.tintColor = .white
       
        navigationItem.rightBarButtonItem = addBtn
    }

    
    @objc private func addBtnPressed() {
        let createCompanyVC = CreateCompanyViewController()
        let createCompanyNC = CustomNavigationController(rootViewController: createCompanyVC)
        
        createCompanyVC.delegate = self
        
        present(createCompanyNC, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView()
        view.backgroundColor = .lighBlue
        
        return view
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (_, indexPath) in
            
           
            let company = self.companies[indexPath.row]
            
            //delete from array
            self.companies.remove(at: indexPath.row)
            
            //delete from table view
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
            //delete from Core Data
            let context = CoreDataManagement.shared.persistanceContainer.viewContext
            context.delete(company)
            
            do {
                try context.save()
            } catch let saveErr {
                print("Failed Save :",saveErr )
            }
            
        }
        
        let editAction = UITableViewRowAction(style: .default, title: "Edit") { (_, indexPath) in
            print("edit company")
        }
        
        return [deleteAction,editAction]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .tealColor
        
        let company = companies[indexPath.row]
        
        cell.textLabel?.text = company.name
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return cell
    }
    
}

