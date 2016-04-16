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
    let open: Int
    var day: Int
    
    let tagNumber: String
    let bikeType: String
    let orderID: String
    let tune: String
    let lname: String
    
    var ServiceIDs: [Int]
    var totalMinutes: Int
    var totalCost: Int
    
    //MARK: Initialize properties
  init(id: Int, open: Int, tagNumber: String, orderID: String, tune: String, bikeType: String, model: String, lname: String)
    {
        self.id = id
        self.open = open
        self.day = 0
        self.tagNumber = tagNumber
        self.bikeType = bikeType + " " + model
        self.orderID = orderID
        self.lname = lname
        
        
        self.ServiceIDs = []
        self.totalMinutes = 0
        self.totalCost = 0
        
        let tuneList = tune.characters.split{$0 == ","}.map(String.init)
        for idfl in tuneList
        {
            self.ServiceIDs.append(Int(idfl)!)
            
            let service = Tune.getTune(Int(idfl)!)!
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
