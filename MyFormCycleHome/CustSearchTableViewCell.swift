//
//  CustSearchTableViewCell.swift
//  FormCycle
//
//  Created by Cross, Adam B on 2/20/16.
//  Copyright © 2016 Merrill Lines. All rights reserved.
//

import UIKit

class CustSearchTableViewCell: UITableViewCell {

    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var phoneNum: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
