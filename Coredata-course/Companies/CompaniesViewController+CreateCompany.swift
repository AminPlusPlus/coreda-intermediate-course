//
//  CompaniesViewController+CreateCompany.swift
//  Coredata-course
//
//  Created by Aminjoni Abdullozoda on 8/23/19.
//  Copyright © 2019 Aminjoni Abdullozoda. All rights reserved.
//

import Foundation

extension CompaniesViewController : CreateCompanyControllerDelegate {
    
    func didAddCompany(company: Company) {
        companies.append(company)
        let newIndexPath = IndexPath(row: companies.count - 1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
    
    func didEditCompany (company : Company) {
        let row = companies.firstIndex(of: company)
        
        let indexPath = IndexPath(row: row!, section: 0)
        tableView.reloadRows(at: [indexPath], with: .middle)
    }
}
