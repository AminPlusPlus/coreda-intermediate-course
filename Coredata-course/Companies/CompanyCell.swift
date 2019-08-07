//
//  CompanyCell.swift
//  Coredata-course
//
//  Created by Aminjoni Abdullozoda on 8/6/19.
//  Copyright © 2019 Aminjoni Abdullozoda. All rights reserved.
//

import UIKit

class CompanyCell: UITableViewCell {
    
    //Mark:- UI Elements
    var companyImageView : UIImageView = {
       let imageView = UIImageView()
       imageView.image = UIImage(named: "add-image")
       imageView.layer.cornerRadius = 20
       imageView.clipsToBounds = true
       imageView.layer.borderWidth = 2
       imageView.layer.borderColor = UIColor.darkBlue.cgColor
       imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    var titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.text = "HELLO"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    var company : Company? {
        didSet {
            //MMM dd,yyyy
            if let name = company!.name, let founded = company!.founded {
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MMM dd, yyyy"
                let foundedDateString = dateFormatter.string(from: founded)
                let dateString = "\(name) - Founded:\(foundedDateString)"
                titleLabel.text = dateString
            } else {
                titleLabel.text = company!.name
            }
            
            
            if let imageData = company!.imageData {
                companyImageView.image = UIImage(data: imageData)
            }
        }

       }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    
    
    private func setupUI(){
        addSubview(companyImageView)
        backgroundColor = .tealColor
        
        companyImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        companyImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        companyImageView.leftAnchor.constraint(equalTo: leftAnchor,constant: 15).isActive = true
        companyImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true

        addSubview(titleLabel)
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 60).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
