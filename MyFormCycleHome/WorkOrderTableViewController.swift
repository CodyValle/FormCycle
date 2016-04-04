
//
//  WorkOrderTableViewController.swift
//  FormCycle
//
//  Created by Cross, Adam B on 1/23/16.
//  Copyright © 2016 FormCycle Developers. All rights reserved.
//



/*
 * This class handles the current open WorkOrders table on our main page. It is filled with each currently open work order with the newest on the bottom, and the oldest up top.
 * When a cell is selected, the user will be taken to the TechEdit page, where they will be able to review all information regarding the work order and make any appropriate changes.
 * When a work order is closed, it will be removed from this table and sent over to the WaitingPickupTable
 */

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

    ServerCom.send(MyParams, f: {(succ: Bool, retjson: JSON) in //Recieving all current open orders
      if (succ) {
				if (retjson.count > 0) {
          for var i = 0; i < retjson.count; i++ {
            self.workOrders.append(WorkOrder(tagNumber: retjson[i]["tagnum"].string!,
                                             orderID:   retjson[i]["workid"].string!,
                                             tune:      retjson[i]["tune"].string!,
                                             bikeType:  retjson[i]["brand"].string!,
                                             model:     retjson[i]["model"].string!,
                                             lname:     Crypto.decrypt(retjson[i]["lname"].string!)))   //adding all work orders into the workOrders array to be used to fill out the table.

            dispatch_async(dispatch_get_main_queue()) {
              self.tableView.reloadData()
            }
          }
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
    
  //Creating cells and populating our table
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
  {
    let cellIdentifier = "BikeOrderTableViewCell"
    
    //Set the cell as the BikeOrderTableViewCell class, using the WorkOrder data model
    let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! BikeOrderTableViewCell
    let order = workOrders[indexPath.row]
    
    //Setting cell attributes to those in our array
    cell.bikeInfo.text = order.bikeType
    cell.tuneType.text = "tune1"//Tune.ID(order.getServices()[0])
    cell.referenceNumber.text = order.tagNumber
    cell.lname.text = order.lname
    cell.workid = order.orderID

    //cell.backgroundColor = indexPath.row % 2 == 0 ? UIColor(white: 1.0, alpha: 1.0) : UIColor(white: 0.7, alpha: 1.0)
    return cell
  }
    
  
 //When a cell is selected, the user will be taken to the TechEdit page. The orderid is passed to the new page which will then pull all information for it from the database.
    
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
