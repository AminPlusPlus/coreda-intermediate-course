//
//  CompaniesViewController+UITableView.swift
//  Coredata-course
//
//  Created by Aminjoni Abdullozoda on 8/23/19.
//  Copyright © 2019 Aminjoni Abdullozoda. All rights reserved.
//

import Foundation
import UIKit

extension CompaniesViewController {
    
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
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let infoLabel = UILabel()
        infoLabel.textAlignment = .center
        infoLabel.textColor = .white
        infoLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        infoLabel.text = "No Companies!"
        
        return infoLabel
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return (companies.isEmpty) ? 150 : 0
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
        
        //edit table row action
        let editAction = UITableViewRowAction(style: .normal, title: "Edit",handler: editHandleFunction)
        
        deleteAction.backgroundColor = .lightRed
        editAction.backgroundColor = .darkBlue
        
        
        return [deleteAction,editAction]
    }
    
  
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CompanyCell
        cell.company = companies[indexPath.row]
        
        return cell
    }
    
    private func editHandleFunction (action : UITableViewRowAction, indexPath : IndexPath) {
        
        let editCompanyController = CreateCompanyViewController()
        editCompanyController.delegate = self
        editCompanyController.company = self.companies[indexPath.row]
        let navContoller = CustomNavigationController(rootViewController: editCompanyController)
        
        present(navContoller, animated: true, completion: nil)
        
    }
}
