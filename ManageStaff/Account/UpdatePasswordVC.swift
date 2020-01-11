//
//  UpdateEmailVC.swift
//  ManageStaff
//
//  Created by administrator on 12/29/19.
//  Copyright © 2019 linh. All rights reserved.
//

import UIKit
import FirebaseAuth

class UpdatePasswordVC: UIViewController {
    
   
    @IBOutlet weak var textfieldPassword: UITextField!
    @IBOutlet weak var textfieldConfirmPassword: UITextField!
    @IBOutlet weak var labelError: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        self.dismissKeyboard()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func tapOnUpdate(_ sender: Any) {
        //end edit keyboard
        self.view.endEditing(true)
        
        //validate
        if isValidPassword(password: textfieldPassword.text!) {
            //update email
            Auth.auth().currentUser?.updatePassword(to: textfieldPassword.text!, completion: { (error) in
                if error == nil {
                    //notify successful
                    
                    //dismiss
                    self.dismiss(animated: true, completion: nil)
                    
                }else{
                    self.showError(err: "Không thể cập nhật password, hãy thử lại!")
                    return
                }
            })
            return
        }else{
            showError(err: "Password phải dài ít nhất 8 ký tự, bao gồm chữ hoa, chữ thường và số")
            return
        }
        
        
    }
    
    @IBAction func tapOnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapOnPassword(_ sender: Any) {
        labelError.isHidden = true
    }
    
    @IBAction func tapOnConfirmPassword(_ sender: Any) {
        labelError.isHidden = true
    }
    
    
    func setup(){
        labelError.isHidden = true
        //let tapOnScreen = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        //view.addGestureRecognizer(tapOnScreen)
        textfieldPassword.textContentType = .password
        textfieldConfirmPassword.textContentType = .password
    }
    
    func isValidPassword(password: String) -> Bool {
        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }
    
    func showError(err: String){
        labelError.text = err
        labelError.isHidden = false
    }
    
    
}
