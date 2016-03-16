//
//  SearchPageTableViewCell.swift
//  FormCycle
//
//  Created by Merrill Lines on 3/15/16.
//  Copyright © 2016 Merrill Lines. All rights reserved.
//

import UIKit

class SearchPageTableViewCell: UITableViewCell
{
    
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var bikeType: UILabel!
    @IBOutlet weak var bikeModel: UILabel!
    
//    @IBOutlet weak var fullName: UILabel!
//    @IBOutlet weak var address: UILabel!
//    @IBOutlet weak var phoneNum: UILabel!
    var address2 = ""
    var city = ""
    var state = ""
    var zip = ""
    var email = ""
    var fname = ""
    var lname = ""
    
}