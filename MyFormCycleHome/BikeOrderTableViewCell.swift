//
//  BikeOrderTableViewCell.swift
//  FormCycle
//
//  Created by Cross, Adam B on 1/14/16.
//  Copyright © 2016 FormCycle Developers. All rights reserved.
//

/*
 * This class handles the cells that will be used to populate the WorkOrderTable, these include all currently open workorders.
 */

import UIKit

class BikeOrderTableViewCell: UITableViewCell
{
  // MARK: Properties
  
  @IBOutlet weak var referenceNumber: UILabel!
  @IBOutlet weak var tuneType: UILabel!
  @IBOutlet weak var bikeInfo: UILabel!
  @IBOutlet weak var lname: UILabel!
  var workid = ""

}
