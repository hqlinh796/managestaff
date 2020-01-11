//
//  UpdateEmailVC.swift
//  ManageStaff
//
//  Created by administrator on 12/29/19.
//  Copyright © 2019 linh. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class UpdateEmailVC: UIViewController {

    @IBOutlet weak var textfieldOldEmail: UITextField!
    @IBOutlet weak var textfieldNewEmail: UITextField!
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
        guard let err = validateEmail() else {
            //update email
            let currentUser = Auth.auth().currentUser!
            currentUser.updateEmail(to: textfieldNewEmail.text!, completion: { (error) in
                if error == nil {
                    //notify successful
                    
                    //update useracoount and db
                    userAccount.email = self.textfieldNewEmail.text!
                    let ref = Database.database().reference()
                    ref.child("users").child(userAccount.uid).updateChildValues([
                        "email": self.textfieldNewEmail.text!
                        ], withCompletionBlock: { (error, DatabaseReference) in
                            if error != nil {
                                self.showError(err: "Không thể cập nhật email, hãy thử lại!")
                                return
                            }else{
                                //dismiss view controller
                                self.dismiss(animated: true, completion: nil)
                            }
                    })
                }else{
                    print("LOI")
                    self.showError(err: "Không thể cập nhật email, hãy thử lại!")
                    return
                }
            })
            return
        }
        showError(err: err)
        return
        
    }
    
    @IBAction func tapOnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapOnOldEmail(_ sender: Any) {
        labelError.isHidden = true
    }
    
    @IBAction func tapOnNewEmail(_ sender: Any) {
        labelError.isHidden = true
    }
    
    
    func setup(){
        labelError.isHidden = true
        let tapOnScreen = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapOnScreen)
    }
    
    func validateEmail() -> String?{
        if textfieldNewEmail.text!.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || textfieldOldEmail.text!.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
            return "Hãy nhập đủ thông tin"
        }
        if textfieldOldEmail.text! != userAccount.email{
            return "Email cũ không đúng"
        }
        return nil
    }
    
    func showError(err: String){
        labelError.text = err
        labelError.isHidden = false
    }
    

}
