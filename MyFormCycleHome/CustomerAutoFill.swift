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
    let address: String
    let phone: String
    
    //MARK: Initialize properties
    
    init(fname : String, lname : String, address: String, phone: String)
    {
        self.name = fname + " " + lname
        self.address = address
        self.phone = phone
    }
}
