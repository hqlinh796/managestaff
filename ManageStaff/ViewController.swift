//
//  ViewController.swift
//  ManageStaff
//
//  Created by administrator on 11/27/19.
//  Copyright © 2019 linh. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

var userAccount = user()
var imageAvatar:UIImage?
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let db = Firestore.firestore()
        let user = Auth.auth().currentUser
        let ref = db.collection("users").document(user!.uid)
        
        let child = SpinnerViewController()
        startLoading(child: child)
        //load user info
        
            ref.getDocument { (document, error) in
                if let document = document {
                    let data = document.data()
                    userAccount.name = data!["name"] as? String ?? ""
                    userAccount.phone = data!["phone"] as? String ?? ""
                    userAccount.role = data!["role"] as? String ?? ""
                    userAccount.image = data!["image"] as? String ?? ""
                    self.load(url: URL(string: userAccount.image)!)
                    self.stopLoading(child: child)
                } else {
                    print("Can't load user info")
                }
            }
            userAccount.email = user!.email!
            userAccount.uid = user?.uid ?? ""
    }
    
    //-----FUNCTION-------
    func load(url: URL){
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data)  {
                    imageAvatar = image
                }
            }
    }
    
    //create and start loading view
    func startLoading(child: SpinnerViewController){
        addChild(child)
        child.view.frame = view.frame
        self.view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    //stop loading view
    func stopLoading(child: SpinnerViewController){
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
    
    
}




