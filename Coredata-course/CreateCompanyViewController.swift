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
    func didEditCompany(company:Company)
}


class CreateCompanyViewController: UIViewController {
    
    var company : Company? {
        didSet {
            nameTextField.text = company?.name
            guard let founded = company?.founded else { return  }
            datePicker.date = founded
        }
    }
    
    var delegate : CreateCompanyControllerDelegate?
    
    //MARK:- UI Elements
    
    lazy var companyImageView : UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "add-image"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(addImageGesture))
        imageView.addGestureRecognizer(tapGesture)
        
        return imageView
    }()
    
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
    
    let datePicker:UIDatePicker = {
        let dp = UIDatePicker()
        dp.translatesAutoresizingMaskIntoConstraints = false
        dp.datePickerMode = .date
        return dp
    }()
    
    
    @objc private func addImageGesture(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true

        present(imagePickerController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = company == nil ? "Create Company" : "Edit Comapany"
        view.backgroundColor = .darkBlue
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
        lightBlueBackgroundView.heightAnchor.constraint(equalToConstant: 350).isActive = true

        view.addSubview(companyImageView)
        companyImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        companyImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        companyImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        companyImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        view.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: companyImageView.bottomAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 16).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        view.addSubview(nameTextField)
        nameTextField.leftAnchor.constraint(equalTo: nameLabel.rightAnchor).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        nameTextField.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        nameTextField.topAnchor.constraint(equalTo: nameLabel.topAnchor).isActive = true
        
        //setup date picker
        view.addSubview(datePicker)
        datePicker.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        datePicker.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        datePicker.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        datePicker.bottomAnchor.constraint(equalTo: lightBlueBackgroundView.bottomAnchor).isActive = true
        
    }
    
    @objc private func handleCancel(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func saveHandle(){
        if company == nil {
            self.createCompany()
        } else {
            self.saveCompanyChanges()
        }
    }
    
    private func saveCompanyChanges(){
        //get context
        let context = CoreDataManagement.shared.persistanceContainer.viewContext
        company?.name = nameTextField.text
        company?.founded = datePicker.date
        
        do {
            try context.save()
            dismiss(animated: true, completion: {
                self.delegate?.didEditCompany(company: self.company!)
            })
            
        } catch let saveErr {
             print("error for saving",saveErr)
        }
        
    }
    
    private func createCompany (){
        //get context
        let persistenceContext = CoreDataManagement.shared.persistanceContainer.viewContext
        //entity
        let company = NSEntityDescription.insertNewObject(forEntityName: "Company", into: persistenceContext)
        //set value entity
        company.setValue(self.nameTextField.text!, forKey: "name")
        company.setValue(datePicker.date, forKey: "founded")
        
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

extension CreateCompanyViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      
        if let image = info[.editedImage] as? UIImage {
            self.companyImageView.image = image
        }
        else if let image = info[.originalImage] as? UIImage {
            self.companyImageView.image = image
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
