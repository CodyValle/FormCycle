//
//  PickupTableViewCell.swift
//  FormCycle
//
//  Created by Cross, Adam B on 1/30/16.
//  Copyright © 2016 FormCycle Developers. All rights reserved.
//


/*
 * This class handles the cells that will be used to populate the WaitingPickupTable
 */
import UIKit

class PickupTableViewCell: UITableViewCell
{
  @IBOutlet weak var lname: UILabel!
  @IBOutlet weak var tuneType: UILabel!
  @IBOutlet weak var tagNum: UILabel!
  @IBOutlet weak var bikeInfo: UILabel!
  var workidWait = ""

}
