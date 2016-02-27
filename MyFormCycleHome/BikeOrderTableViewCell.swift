//
//  BikeOrderTableViewCell.swift
//  FormCycle
//
//  Created by Cross, Adam B on 1/14/16.
//  Copyright © 2016 FormCycle Developers. All rights reserved.
//

import UIKit

class BikeOrderTableViewCell: UITableViewCell
{
  // MARK: Properties
  @IBOutlet weak var referenceNumber: UILabel!
  @IBOutlet weak var tuneType: UILabel!
  @IBOutlet weak var bikeInfo: UILabel!
  @IBOutlet weak var lname: UILabel!
  var workid = ""

  override func awakeFromNib()
  {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(selected: Bool, animated: Bool)
  {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
  }
}
