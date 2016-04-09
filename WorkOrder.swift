//
//  WorkOrder.swift
//  FormCycle
//
//  Created by Cross, Adam B on 1/19/16.
//  Copyright © 2016 FormCycle Developers. All rights reserved.
//

import UIKit

class WorkOrder
{
    //MARK: Properties
    let id: Int
    var day: Int
    
    let tagNumber: String
    let bikeType: String
    let orderID: String
    let tune: String
    let lname: String
    
    var ServiceIDs: [Int]
    var totalMinutes: Float
    var totalCost: Int
    
    //MARK: Initialize properties
    init(id: Int, tagNumber: String, orderID: String, tune: String, bikeType: String, model: String, lname: String)
    {
        self.id = id
        self.day = 0
        self.tagNumber = tagNumber
        self.bikeType = bikeType + " " + model
        self.orderID = orderID
        self.lname = lname
        
        
        self.ServiceIDs = []
        self.totalMinutes = 0
        self.totalCost = 0
        
        let tuneList = tune.characters.split{$0 == ","}.map(String.init)
        for id in tuneList
        {
            self.ServiceIDs.append(Int(id)!)
            
            let service = Tune.getTune(Int(id)!)!
            self.totalMinutes += service.sTime
            self.totalCost += service.sCost
        }
        
        self.tune = Tune.ID(ServiceIDs[0])!
    }
    
    func getServices() -> [Int]
    {
        return ServiceIDs
    }
}
