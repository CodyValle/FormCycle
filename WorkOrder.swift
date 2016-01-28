//
//  WorkOrder.swift
//  FormCycle
//
//  Created by Cross, Adam B on 1/19/16.
//  Copyright © 2016 Merrill Lines. All rights reserved.
//

import UIKit

class WorkOrder {

    //MARK: Properties
    
    let tagNumber: String
    let bikeType: String
    let orderID: String
    let tune: String
    let model: String
    let lname: String
    
    //MARK: Initialize properties
    
    init(tagNumber: String, orderID: String, tune: String, bikeType: String, model: String, lname: String)
    {
        self.tagNumber = tagNumber
        self.bikeType = bikeType
        self.tune = tune
        self.orderID = orderID
        self.model = model
        self.lname = lname
    }
}
