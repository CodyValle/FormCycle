//
//  WeeklyGlance.swift
//  FormCycle
//
//  Created by Lines, Merrill A on 4/15/16.
//  Copyright © 2016 Merrill Lines. All rights reserved.
//

import UIKit

class WeeklyGlance
{
  static private var daySelected: Int = 0

  static func getDaySelected() -> Int
  {
  return daySelected
  }

  static func setDaySelected(day: Int)
  {
    if daySelected == day { return }
    daySelected = day

    // Refresh the table
    NSNotificationCenter.defaultCenter().postNotificationName("reloadOpenOrderTable", object: nil)
  }
  
}
