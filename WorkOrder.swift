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
    
    let orderNumber: String
    let bikeType: String
    let orderID: String
    let tune: String
    
    //MARK: Initialize properties
    
    init(orderNumber: String, orderID: String, tune: String, bikeType: String)
    {
        self.orderNumber = orderNumber
        self.bikeType = bikeType
        self.tune = tune
        self.orderID = orderID
        
        
    }
}
