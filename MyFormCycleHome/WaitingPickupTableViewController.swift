//
//  WaitingPickupTableViewController.swift
//  FormCycle
//
//  Created by Cross, Adam B on 1/30/16.
//  Copyright © 2016 FormCycle Developers. All rights reserved.
//

import UIKit
import SwiftHTTP
import SwiftyJSON

class WaitingPickupTableViewController: UITableViewController
{
  // MARK: Properties
  var workOrders = [WorkOrder]()
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  let awaitingPickupSegueIdentifier = "awaitingPickupSegue"
    
  override func viewDidLoad()
  {
    super.viewDidLoad()

    //Load data
    workOrders.removeAll()

    /* Submits the server request */
    var MyParams = ["action":"workSearch"]

    // Append possible search data to the parameters. Note: MyParams is changed to a var, instead of a let.
    MyParams["open"] = "N"
    ServerCom.send(MyParams, f: {(json:JSON) in
      if json["success"]
      {
        // Probably needs more error checks.
        let retString = json["return"].string!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        let orders = JSON(data: retString!)
        if (orders.count > 0) // Fill the form
        {
          for var i = 0; i < orders.count; i++
          {
            self.workOrders.append(WorkOrder(tagNumber: orders[i]["tagnum"].string!, orderID:orders[i]["workid"].string!, tune: orders[i]["tune"].string!, bikeType:orders[i]["brand"].string!, model:orders[i]["model"].string!, lname:orders[i]["lname"].string!))
            dispatch_async(dispatch_get_main_queue()) {
              self.tableView.reloadData()
            }
          }
        }
        //else you are done- TO DO LATER
        return true
      }
      return false
    })
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
    let cellIdentifier = "PickupTableViewCell"
    
    //Set the cell as the BikeOrderTableViewCell class, using the WorkOrder data model
    let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! PickupTableViewCell
    let order = workOrders[indexPath.row]
    
    //Setting cell attributes to those in our array
    cell.bikeInfo.text = order.bikeType
    cell.tuneType.text = order.tune
    cell.tagNum.text = order.tagNumber
    cell.lname.text = order.lname

    cell.backgroundColor = indexPath.row % 2 == 0 ? UIColor(white: 0.7, alpha: 1.0) : UIColor(white: 1.0, alpha: 1.0)

    return cell
  }
    
  // MARK: - Navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
  {
    if segue.identifier == awaitingPickupSegueIdentifier {
      if let destination = segue.destinationViewController as? AwaitingOrderViewController {
        if let orderIndex = tableView.indexPathForSelectedRow?.row {
          destination.workidPassedWait = workOrders[orderIndex].orderID
        }
      }
    }
  }
}
