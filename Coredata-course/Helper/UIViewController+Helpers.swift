//
//  UIViewController+Helpers.swift
//  Coredata-course
//
//  Created by Aminjoni Abdullozoda on 8/23/19.
//  Copyright © 2019 Aminjoni Abdullozoda. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func setupAddBtnNavbar(selector : Selector){
    navigationItem.rightBarButtonItem  = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: selector)
    navigationItem.rightBarButtonItem!.tintColor = .white
    }
    
    func setupCancelBtnNavbar(){
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
    
    }
    @objc private func handleCancel(){
        dismiss(animated: true, completion: nil)
    }
    
}
