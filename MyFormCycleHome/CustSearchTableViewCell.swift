//
//  CustSearchTableViewCell.swift
//  FormCycle
//
//  Created by Cross, Adam B on 2/20/16.
//  Copyright © 2016 Merrill Lines. All rights reserved.
//

/*
 * This is the class that will handle the Cells in the auto-fill table. These cells will have all relevant information to the customer, four of which will be used to display on the cell itself.
 * The rest of the variables will be used to set all fields on the new order page, both customer information and the bike information page.
 */

import UIKit

class CustSearchTableViewCell: UITableViewCell
{
  @IBOutlet weak var fullName: UILabel!
  @IBOutlet weak var address: UILabel!
  @IBOutlet weak var phoneNum: UILabel!
  @IBOutlet weak var bike: UILabel!
  var address2 = ""
  var city = ""
  var state = ""
  var zip = ""
  var email = ""
  var fname = ""
  var lname = ""
  var model = ""
  var brand = ""
  var color = ""

}
