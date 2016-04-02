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

  static func setOrders(orders: [WorkOrder])
  {
		WorkOrders = orders
  }

  static func packBins()
  {
    Days = [Day()]
    var curDay: Int = 0

    for order in WorkOrders
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

      if Days[curDay].getHours() + order.totalHours > 8
      {
				Days.append(Day())
        curDay++
      }

      Days[curDay].WorkOrders.append(order)
    }

    for i in 0...(Days.count - 1)
    {
      print("Day: \(i)")
      print(" Hours scheduled: \(Days[i].getHours())")
    }
  }

}
