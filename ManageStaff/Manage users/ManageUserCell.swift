//
//  ManageUserCell.swift
//  ManageStaff
//
//  Created by administrator on 1/9/20.
//  Copyright © 2020 linh. All rights reserved.
//

import UIKit

class ManageUserCell: UITableViewCell {

    @IBOutlet weak var imageviewAvatar: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelPhone: UILabel!
    @IBOutlet weak var labelRole: UILabel!
    @IBOutlet weak var imageviewSeeMore: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageviewAvatar.layer.cornerRadius = imageviewAvatar.frame.width/2
        imageviewAvatar.clipsToBounds = true
        imageviewAvatar.layer.borderWidth = 2
        imageviewAvatar.layer.borderColor = UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1).cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
