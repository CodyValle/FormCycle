//
//  CustomerAutoFill.swift
//  FormCycle
//
//  Created by Cross, Adam B on 2/22/16.
//  Copyright © 2016 Merrill Lines. All rights reserved.
//

/*
 * This class handles all relevant information for the AutoFillCell class. It will store information for the customer and their bike, and is used
 * for cell creation in the AutoFillTable class. 
 */

import UIKit

class CustomerAutoFill
{
  //MARK: Properties
  
  let name : String
  let fname : String
  let lname : String
  let address : String
  let address2 : String
  let city : String
  let state : String
  let zip : String
  let email : String
  let phone : String
  let model : String
  let brand : String
  let color : String
  let bike : String
    
  //MARK: Initialize properties
    init(fname : String, lname : String, address : String, address2 : String, city : String, state : String, phone: String, zip : String, email : String, model: String, brand: String, color: String)
  {
    self.fname = fname
    self.lname = lname
    self.name = fname + " " + lname
    self.address = address
    self.address2 = address2
    self.city = city
    self.state = state
    self.zip = zip
    self.email = email
    self.phone = phone
    self.model = model
    self.brand = brand
    self.color = color
    self.bike = brand + " " + model + ", " + color
  }
}
