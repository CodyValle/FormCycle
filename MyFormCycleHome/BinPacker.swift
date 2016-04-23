//
//  BinPacker.swift
//  FormCycle
//
//  Created by Valle, Cody J on 4/2/16.
//  Copyright © 2016 Merrill Lines. All rights reserved.
//

import Foundation
import UIKit

class BinPacker
{
  class Day
  {
    var WorkOrders: [WorkOrder] = []

    func getMinutes() -> Int
    {
      var total: Int = 0
      for w in WorkOrders
      {
        total += w.totalMinutes
      }

      return total
    }
  }

  static private var WorkOrders: [WorkOrder] = []
  static private var Days: [Day] = []
  static private var todayLock = false

  // Checks whether today is a new day and needs to load new orders or load the already set orders
  private static func setToday()
  {
    let defaults = NSUserDefaults.standardUserDefaults()

    let formatter = NSDateFormatter()
    formatter.dateFormat = "MM-dd-yyyy"

    // The last time work orders were loaded
    let lastloadedDate = formatter.dateFromString(defaults.stringForKey("LastLoaded")!)

    if let test = lastloadedDate?.isLessThanDate(formatter.dateFromString(formatter.stringFromDate(NSDate()))!) {
      if test {
        // We need to fill today with orders
        defaults.setValue("false", forKey: "LockedDay")
        defaults.synchronize()
        self.todayLock = false
        return
      }
    }

    // We need to lock today and load the already set orders from the list saved to the device
    defaults.setValue("true", forKey: "LockedDay")
    defaults.synchronize()
    self.todayLock = true

    let tuneList = defaults.stringForKey("TodaysOrders")!.characters.split{$0 == ","}.map(String.init)
    self.Days = []
    self.Days.append(Day())

    for id in tuneList {
      if let w = BinPacker.WorkOrderFromID(Int(id)!) {
        if w.open != 0 { continue }
        self.Days[0].WorkOrders.append(w)
      }
    }
  }

  // Appends all new orders to this classes array of them
  static func setOrders(orders: [WorkOrder])
  {
    for o in orders
    {
      var found = false
      for w in self.WorkOrders
      {
        if o.id == w.id {// || self.todayLock ? !self.IDinDay(o.id, day: 0) : true {
          found = true
          break
        }
      }
      if !found {
        WorkOrders.append(o)
      }
    }

    self.setToday()
  }

  // If today was loaded, we need to save the IDs to the device so they can be loaded when the app opens next time
  static func saveToday()
  {
    if self.Days.count > 0 {
      let defaults = NSUserDefaults.standardUserDefaults()

      var theIDs = ""
      for w in self.Days[0].WorkOrders {
        theIDs += "\(w.id),"
      }

      defaults.setValue(theIDs, forKey: "TodaysOrders")
      defaults.synchronize()
    }
  }

  // Packs the work orders into the next days
  static func packBins()
  {
    self.setToday()
    //print(self.todayLock)

    if self.todayLock {
      self.Days = [self.Days[0]]
    }
    else {
      self.Days = []
    }

    for order in self.WorkOrders
    {
        if self.IDinDay(order.id, day: 0) {continue}
      //if Days.count > 5 { order.day = 6 }
//      print("For work order \(order.lname), \(order.tagNumber):")
//      print(" Services:")
//      for serviceID in order.getServices()
//      {
//        let service = Tune.getTune(serviceID)!
//        print("  Tune ID: \(service.sID)")
//        print("   Tune Name: \(service.sName)")
//        print("   Tune Cost: \(service.sCost)")
//        print("   Tune Time: \(service.sTime)")
//      }
//      print(" Work Hours: \(order.totalMinutes / 60.0)")
//      print(" Work Cost: \(order.totalCost)")

      var placed = false
      var day = todayLock ? 1 : 0
      
      while day < self.Days.count
      {
        if (self.Days[day].getMinutes() + order.totalMinutes) / 60 <= 16
        {
          placed = true
          break
        }
        day++
      }

      if !placed { self.Days.append(Day()) }

      self.Days[day].WorkOrders.append(order)
      order.day = day//todayLock ? day - 1 : day
    }

//    for i in 0...(Days.count - 1)
//    {
//      print("Day: \(i)")
//      print(" Hours scheduled: \(Days[i].getMinutes() / 60.0)")
//      print("  Work Order IDs:")
//      for w in Days[i].WorkOrders
//      {
//        print("   \(w.id)")
//      }
//    }

    // Update the Weekly Glance
    var minutes = 0

    if Days.count > 0
    {
      minutes = Days[0].getMinutes()
      WGData.Day0Color = self.mapToGradient(minutes, max: 16 * 60)
      WGData.Day0Hours = "\(Days[0].getMinutes() / 60) hours"
    }
    else { WGData.Day0Color = self.mapToGradient(0, max: 16 * 60) }

    if Days.count > 1
    {
      minutes = Days[1].getMinutes()
      WGData.Day1Color = self.mapToGradient(minutes, max: 16 * 60)
      WGData.Day1Hours = "\(Days[1].getMinutes() / 60) hours"
    }
    else { WGData.Day1Color = self.mapToGradient(0, max: 16 * 60) }

    if Days.count > 2
    {
      minutes = Days[2].getMinutes()
      WGData.Day2Color = self.mapToGradient(minutes, max: 16 * 60)
      WGData.Day2Hours = "\(Days[2].getMinutes() / 60) hours"
    }
    else { WGData.Day2Color = self.mapToGradient(0, max: 16 * 60) }

    if Days.count > 3
    {
      minutes = Days[3].getMinutes()
      WGData.Day3Color = self.mapToGradient(minutes, max: 16 * 60)
      WGData.Day3Hours = "\(Days[3].getMinutes() / 60) hours"
    }
    else { WGData.Day3Color = self.mapToGradient(0, max: 16 * 60) }

    if Days.count > 4
    {
      minutes = Days[4].getMinutes()
      WGData.Day4Color = self.mapToGradient(minutes, max: 16 * 60)
      WGData.Day4Hours = "\(Days[4].getMinutes() / 60) hours"
    }
    else { WGData.Day4Color = self.mapToGradient(0, max: 16 * 60) }

    let components = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!.components([.Weekday], fromDate: NSDate())
    let dayNames = self.mapDayToName(components.weekday)
    WGData.Day0Name = dayNames[0]
    WGData.Day1Name = dayNames[1]
    WGData.Day2Name = dayNames[2]
    WGData.Day3Name = dayNames[3]
    WGData.Day4Name = dayNames[4]
  }

  private static func mapDayToName(var day: Int) -> [String]
  {
    var names: [String] = []
    var i = 0
    while i < 5
    {
      switch day
      {
      case 1:
        day = 2
        fallthrough
      case 2:
        names.append("Monday")
        i++
        break
      case 3:
        names.append("Tuesday")
        i++
        break
      case 4:
        names.append("Wednesday")
        i++
        break
      case 5:
        names.append("Thursday")
        i++
        break
      case 6:
        names.append("Friday")
        i++
        break
      case 7:
        day = 1
        break
      default:
        day = 2
      }

      day += 1
    }

    return names
  }

  private static func mapToGradient(minutes: Int, max: Int) -> UIColor
  {
    let ratio: Float = Float(minutes) / Float(max)
    let r = CGFloat(ratio * 200.0 / 255)
    let g = CGFloat((255 - ratio * 250.0) / 255)
    let b = CGFloat(0.0)
    return UIColor(red: r, green: g, blue: b, alpha: 1)
  }

  // Gets all orders this class stores
  static func getOrders() -> [WorkOrder]
  {
    return self.WorkOrders
  }

  // Gets the orders of a specified day
  static func getOrdersOfDay(day: Int) -> [WorkOrder]
  {
    return self.Days[day].WorkOrders
  }

  // Returns true if the work order id is assigned to the specified day
  static func IDinDay(id: Int, day: Int) -> Bool
  {
    if day >= Days.count { return false }
    for w in Days[day].WorkOrders {
      if id == w.id {
        return true
      }
    }
    return false
  }

  // Gets the work order of the given id
  static func WorkOrderFromID(id: Int) -> WorkOrder?
  {
    for w in self.WorkOrders
    {
      if id == w.id {
        return w
      }
    }
    return nil
  }

  // Removes a work order from this class
  static func removerOrder(workid: String)
  {
    for i in 0...(WorkOrders.count - 1) {
      if WorkOrders[i].orderID == workid {
        WorkOrders.removeAtIndex(i)
        break
      }
    }

    if self.todayLock {
      for i in 0...(Days[0].WorkOrders.count - 1) {
        if Days[0].WorkOrders[i].orderID == workid {
          Days[0].WorkOrders.removeAtIndex(i)
          return
        }
      }
    }
  }

}
