//
//  CustomerAutoFill.swift
//  FormCycle
//
//  Created by Cross, Adam B on 2/22/16.
//  Copyright © 2016 Merrill Lines. All rights reserved.
//

import UIKit

class CustomerAutoFill {
    
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
    
    //MARK: Initialize properties
    
    init(fname : String, lname : String, address : String, address2 : String, city : String, state : String, phone: String, zip : String, email : String)
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
    }
}
