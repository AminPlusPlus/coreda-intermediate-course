//
//  ViewController.swift
//  Coredata-course
//
//  Created by Aminjoni Abdullozoda on 7/3/19.
//  Copyright © 2019 Aminjoni Abdullozoda. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        navigationItem.title = "Companies"
        
        tableView.backgroundColor = UIColor(red: 9/255, green: 45/255, blue: 64/255, alpha: 1)
        
        let addBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBtnPressed))
            addBtn.tintColor = .white
       
        navigationItem.rightBarButtonItem = addBtn
        setupNavigationBarStyle()
    }

    
    private func setupNavigationBarStyle(){
        
        let lightRed = UIColor(red: 247/255, green: 66/255, blue: 82/255, alpha: 1)
        
        navigationController?.navigationBar.barTintColor = lightRed
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
    }
    
    @objc private func addBtnPressed() {
        
    }

}

