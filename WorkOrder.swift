//
//  WorkOrder.swift
//  FormCycle
//
//  Created by Cross, Adam B on 1/19/16.
//  Copyright © 2016 FormCycle Developers. All rights reserved.
//



/*
 * This class exists to store WorkOrder information, and is used to handle all information used for the WorkOrders table and the WaitingPickupTable.
 * It is used for cell creation and is stored in the arrays that the data is accessed from. 
 */
import UIKit

class WorkOrder
{
  //MARK: Properties

  let tagNumber: String
  let bikeType: String
  var orderID: String
  let tune: String
  let lname: String

  //var ServiceIDs: [Int]

    //MARK: Initialize properties
  init(tagNumber: String, orderID: String, tune: String, bikeType: String, model: String, lname: String)
  {
    self.tagNumber = tagNumber
    self.bikeType = bikeType + " " + model
    self.orderID = orderID
    self.lname = lname


//    self.ServiceIDs = []
//
//    let tuneList = tune.characters.split{$0 == ","}.map(String.init)
//    for s in tuneList
//    {
//      self.ServiceIDs.append(Int(s)!)
//    }
//
//    self.tune = Tune.ID(ServiceIDs[0])!
    self.tune = tune
    self.orderID = orderID
    
  }

//  func getServices() -> [Int]
//  {
//    return ServiceIDs
//  }
}
