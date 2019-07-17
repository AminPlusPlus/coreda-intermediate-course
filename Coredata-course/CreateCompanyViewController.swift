//
//  CreateCompanyViewController.swift
//  Coredata-course
//
//  Created by Aminjoni Abdullozoda on 7/4/19.
//  Copyright © 2019 Aminjoni Abdullozoda. All rights reserved.
//

import UIKit
import CoreData

//Delegation
protocol CreateCompanyControllerDelegate {
    func didAddCompany (company:Company)
}


class CreateCompanyViewController: UIViewController {
    
    
    var delegate : CreateCompanyControllerDelegate?
    
    //MARK:- UI Elements
    let nameLabel : UILabel = {
        let label = UILabel()
        label.text = "Name"
        
        //enable auto layout
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let nameTextField : UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Enter your Name"
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .darkBlue
        navigationItem.title = "Create Company"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveHandle))
        setupUI()
    
    }
    
    private func setupUI(){
        
        let lightBlueBackgroundView = UIView()
            lightBlueBackgroundView.backgroundColor = .lighBlue
            lightBlueBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(lightBlueBackgroundView)
        
        lightBlueBackgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        lightBlueBackgroundView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        lightBlueBackgroundView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        lightBlueBackgroundView.heightAnchor.constraint(equalToConstant: 50).isActive = true

        
        view.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 16).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        view.addSubview(nameTextField)
        nameTextField.leftAnchor.constraint(equalTo: nameLabel.rightAnchor).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        nameTextField.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        nameTextField.topAnchor.constraint(equalTo: nameLabel.topAnchor).isActive = true
    }
    
    @objc private func handleCancel(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func saveHandle(){
        

            //get context
            let persistenceContext = CoreDataManagement.shared.persistanceContainer.viewContext
            //entity
            let company = NSEntityDescription.insertNewObject(forEntityName: "Company", into: persistenceContext)
            //set value entity
            company.setValue(self.nameTextField.text!, forKey: "name")
            
            //save it
            do {
                try persistenceContext.save()
                dismiss(animated: true) {
                    self.delegate?.didAddCompany(company: company as! Company)
                }
            }catch let saveErr{
                print("error for saving",saveErr)
            }
    }
}
 
