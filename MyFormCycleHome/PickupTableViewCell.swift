//
//  PickupTableViewCell.swift
//  FormCycle
//
//  Created by Cross, Adam B on 1/30/16.
//  Copyright © 2016 Merrill Lines. All rights reserved.
//

import UIKit

class PickupTableViewCell: UITableViewCell {

    @IBOutlet weak var lname: UILabel!
    @IBOutlet weak var tuneType: UILabel!
    @IBOutlet weak var bikeInfo: UILabel!
    @IBOutlet weak var referenceNumber: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
