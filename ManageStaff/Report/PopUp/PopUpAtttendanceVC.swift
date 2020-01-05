//
//  PopUpAtttendanceVC.swift
//  ManageStaff
//
//  Created by administrator on 12/31/19.
//  Copyright © 2019 linh. All rights reserved.
//

import UIKit

class PopUpAtttendanceVC: UIViewController {

    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelShiftLeader: UILabel!
    
    var name = ""
    var time = ""
    var shiftLeader = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelName.text = name
        labelTime.text = "Thời gian: " + time
        labelShiftLeader.text = "Người trực: " + shiftLeader
        // Do any additional setup after loading the view.
    }
    

    @IBAction func tapOnOK(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
}
