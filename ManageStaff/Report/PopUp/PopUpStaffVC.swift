//
//  PopUpStaffVC.swift
//  ManageStaff
//
//  Created by administrator on 12/31/19.
//  Copyright © 2019 linh. All rights reserved.
//

import UIKit

class PopUpStaffVC: UIViewController {

    @IBOutlet weak var imageviewAvatar: UIImageView!
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelSex: UILabel!
    @IBOutlet weak var labelPhone: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var labelRole: UILabel!
    @IBOutlet weak var labelDepartment: UILabel!
    @IBOutlet weak var labelUid: UILabel!
    var staff = user()

    override func viewDidLoad() {
        super.viewDidLoad()
        labelName.text = staff.lastname + " " + staff.firstname
        labelSex.text = staff.sex
        labelRole.text = staff.role
        labelEmail.text = staff.email
        labelPhone.text = staff.phone
        labelDepartment.text = staff.department
        labelUid.text = staff.uid
        let url = URL(string: staff.image)
        downloadImage(from: url!)
        
    }
    
    
    @IBAction func tapOnOK(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                self.imageviewAvatar.image = UIImage(data: data)
            }
        }
    }

   
}
