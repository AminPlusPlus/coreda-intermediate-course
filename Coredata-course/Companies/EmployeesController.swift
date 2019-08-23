//
//  EmployeesController.swift
//  Coredata-course
//
//  Created by Aminjoni Abdullozoda on 8/23/19.
//  Copyright © 2019 Aminjoni Abdullozoda. All rights reserved.
//


import UIKit

class EmloyeessController: UITableViewController {
    
    var company : Company?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = company?.name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.darkBlue
        setupAddBtnNavbar(selector: #selector(addEmployee))
    }
    
    @objc private func addEmployee(){
        
        let navCreateEmployee = CustomNavigationController(rootViewController: CreateEmployeeController())
        present(navCreateEmployee, animated: true, completion: nil)
    }
}
