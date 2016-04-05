//
//  BinPacker.swift
//  FormCycle
//
//  Created by Valle, Cody J on 4/2/16.
//  Copyright © 2016 Merrill Lines. All rights reserved.
//

import Foundation

class BinPacker
{
  class Day
  {
    var WorkOrders: [WorkOrder] = []

    func getHours() -> Float
    {
      var total: Float = 0
      for w in WorkOrders
      {
        total += w.totalHours
      }

      return total
    }
  }

  static private var WorkOrders: [WorkOrder] = []
  static private var Days: [Day] = []
  static private var todayLock = false

  static func setOrders(orders: [WorkOrder])
  {
		WorkOrders = orders
  }

  static func packBins()
  {

    let defaults = NSUserDefaults.standardUserDefaults()

    defaults.setValue("true", forKey: "LockedDay")
    defaults.setValue(NSDate(), forKey: "LastLoaded")

    defaults.synchronize()

    let defaults = NSUserDefaults.standardUserDefaults()
    print(defaults.stringForKey("LastLoaded"))

    self.todayLock = defaults.stringForKey("LockedDay") == "true"




    self.Days = [Day()]

    for order in self.WorkOrders
    {
      print("For work order \(order.lname), \(order.tagNumber):")
      print(" Services:")
      for serviceID in order.getServices()
      {
        let service = Tune.getTune(serviceID)!
        print("  Tune ID: \(service.sID)")
        print("   Tune Name: \(service.sName)")
        print("   Tune Cost: \(service.sCost)")
        print("   Tune Time: \(service.sTime)")
      }
      print(" Work Hours: \(order.totalHours)")
      print(" Work Cost: \(order.totalCost)")

      var placed = false
      var day = todayLock ? 1 : 0
      
      while day < self.Days.count
      {
        if self.Days[day].getHours() + order.totalHours <= 8
        {
          placed = true
          break
        }
        day++
      }

      if !placed { self.Days.append(Day()) }

      self.Days[day].WorkOrders.append(order)
    }

    for i in 0...(Days.count - 1)
    {
      print("Day: \(i)")
      print(" Hours scheduled: \(Days[i].getHours())")
      print("  Work Order IDs:")
      for w in Days[i].WorkOrders
      {
        print("   \(w.id)")
      }
    }
  }

  static func getOrdersOfDay(day: Int) -> [WorkOrder]
  {
    return self.Days[day].WorkOrders
  }

  static func IDinDay(id: Int, day: Int) -> Bool
  {
    for w in Days[day].WorkOrders {
      if id == w.id {
        return true
      }
    }
    return false
  }

}
