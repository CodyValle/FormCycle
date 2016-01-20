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
    
    let orderNumber: Int
    let bikeType: String
    let referenceNum: Int
    let tune: String
    
    //MARK: Initialize properties
    
    init(orderNumber: Int, referenceNum: Int, tune: String, bikeType: String)
    {
        self.orderNumber = orderNumber
        self.bikeType = bikeType
        self.tune = tune
        self.referencenNum = referenceNum
        
        if orderNumber.isEmpty || bikeType.isEmpty || tune.isEmpty || referenceNum.isEmpty
        {
            return nil
        }
    }
}
