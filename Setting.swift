//
//  Setting.swift
//  ManageStaff
//
//  Created by administrator on 12/3/19.
//  Copyright © 2019 linh. All rights reserved.
//

import Foundation
import UIKit

class user{
    var email: String = ""
    var firstname: String = ""
    var lastname: String = ""
    var sex: String = ""
    var department: String = ""
    var phone: String  = ""
    var role: String = ""
    var leaderid: String = ""
    var uid: String = ""
    var image: String = ""
    var salary: String = ""
}

class SpinnerViewController: UIViewController {
    var spinner = UIActivityIndicatorView(style: .whiteLarge)
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)
        
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
}

class filter{
    var sex: [String] = []
    var department: [String] = []
    var role: [String] = []
    var month = ""
    var year = ""
}







