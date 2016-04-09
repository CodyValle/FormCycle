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

  let tagNumber: String
  let bikeType: String
  let orderID: String
  let tune: String
  let lname: String

  var ServiceIDs: [Int]

  //MARK: Initialize properties
  init(id: Int, tagNumber: String, orderID: String, tune: String, bikeType: String, model: String, lname: String)
  {
    self.id = id
    self.tagNumber = tagNumber
    self.bikeType = bikeType + " " + model
    self.orderID = orderID
    self.lname = lname


    self.ServiceIDs = []

    let tuneList = tune.characters.split{$0 == ","}.map(String.init)
    for s in tuneList
    {
      self.ServiceIDs.append(Int(s)!)
    }

    self.tune = Tune.ID(ServiceIDs[0])!
    //self.tune = tune
    self.orderID = orderID
    
  }

  func getServices() -> [Int]
  {
    return ServiceIDs
  }
}
