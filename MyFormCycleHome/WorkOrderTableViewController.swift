
//
//  WorkOrderTableViewController.swift
//  FormCycle
//
//  Created by Cross, Adam B on 1/23/16.
//  Copyright © 2016 FormCycle Developers. All rights reserved.
//

import UIKit
import SwiftHTTP
import SwiftyJSON

class WorkOrderTableViewController: UITableViewController
{
  // MARK: Properties
  var workOrders = [WorkOrder]()

  override func viewDidLoad()
  {
    super.viewDidLoad()

    //Load data
    workOrders.removeAll()

    /* Submits the server request */
    var MyParams = ["action":"workSearch"]

    // Append possible search data to the parameters. Note: MyParams is changed to a var, instead of a let.
    MyParams["open"] = "Y"

    ServerCom.send(MyParams, f: {(succ: Bool, retjson: JSON) in
      if (succ) {
        if (retjson.count > 0) {
          for var i = 0; i < retjson.count; i++ {
            self.workOrders.append(WorkOrder(id:        Int(retjson[i]["rowid"].string!)!,
              open: 0,
              tagNumber: retjson[i]["tagnum"].string!,
              orderID:   retjson[i]["workid"].string!,
              tune:      retjson[i]["tune"].string!,
              bikeType:  retjson[i]["brand"].string!,
              model:     retjson[i]["model"].string!,
              lname:     Crypto.decrypt(retjson[i]["lname"].string!)))
          }
        }


        BinPacker.setOrders(self.workOrders)
        BinPacker.packBins()

        // Set the last loaded date
        let defaults = NSUserDefaults.standardUserDefaults()

        let formatter = NSDateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        let stringDate: String = formatter.stringFromDate(NSDate())

        defaults.setValue(stringDate, forKey: "LastLoaded")

        defaults.synchronize()

        BinPacker.saveToday()

        self.workOrders = BinPacker.getOrders()

        self.workOrders.sortInPlace({ $0.day < $1.day })
        for i in 0...(self.workOrders.count - 1) {
          if self.workOrders[i].day == 0 {                    // This is the day we want on top.
            let w = self.workOrders.removeAtIndex(i)
            self.workOrders.insert(w, atIndex:  0)
          }
        }

        dispatch_async(dispatch_get_main_queue()) {
          self.tableView.reloadData()
        }
        return true
      }
      return false
    })
  }

  override func didReceiveMemoryWarning()
  {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  // MARK: - Table view data source
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int
  {
    return 1
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
    return workOrders.count
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
  {
    let cellIdentifier = "BikeOrderTableViewCell"

    //Set the cell as the BikeOrderTableViewCell class, using the WorkOrder data model
    let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! BikeOrderTableViewCell
    let order = workOrders[indexPath.row]

    //Setting cell attributes to those in our array
    cell.bikeInfo.text = order.bikeType
    cell.tuneType.text = Tune.ID(order.getServices()[0])
    cell.referenceNumber.text = order.tagNumber
    cell.lname.text = order.lname
    cell.workid = order.orderID


    cell.backgroundColor = BinPacker.IDinDay(order.id, day: 0) ?              // This is the day we want to color
      indexPath.row % 2 == 0 ? UIColor(red: 0.1608, green: 0.7255, blue: 1, alpha: 1.0) : UIColor(red: 0, green: 0.8471, blue: 0.9255, alpha: 1.0)
      :
      indexPath.row % 2 == 0 ? UIColor(white: 1.0, alpha: 1.0) : UIColor(white: 0.7, alpha: 1.0)

    return cell
  }

  // MARK: - Navigation
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  let techSegueIndetifier = "TechEditSegue"

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
  {
    if segue.identifier == techSegueIndetifier {
      if let destination = segue.destinationViewController as? TechEditViewController {
        if let orderIndex = tableView.indexPathForSelectedRow?.row {
          destination.workidPassed = workOrders[orderIndex].orderID
        }
      }
    }
  }

}
