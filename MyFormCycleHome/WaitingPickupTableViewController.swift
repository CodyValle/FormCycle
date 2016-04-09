//
//  WaitingPickupTableViewController.swift
//  FormCycle
//
//  Created by Cross, Adam B on 1/30/16.
//  Copyright © 2016 FormCycle Developers. All rights reserved.
//


/*
 * This class handles all recently closed work orders that are waiting to be picked up. It is very similar to the WorkOrder table,
 * the cells contain the same information and is also on the main page. However when a cell is selected in this table, the user will
 * be taken to a new page where they will have the option to complete the order, and set it as picked up and finished.
 */

import UIKit
import SwiftHTTP
import SwiftyJSON

class WaitingPickupTableViewController: UITableViewController
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
    MyParams["open"] = "N"

    ServerCom.send(MyParams, f: {(succ: Bool, retjson: JSON) in //Receiving all recently closed waiting to be picked up orders
      if succ {
        if (retjson.count > 0) {
          for var i = 0; i < retjson.count; i++
          {
            self.workOrders.append(WorkOrder(id: i,
              tagNumber: retjson[i]["tagnum"].string!,
              orderID:   retjson[i]["workid"].string!,
                        tune:      retjson[i]["tune"].string!,
                         bikeType:  retjson[i]["brand"].string!,
                         model:     retjson[i]["model"].string!,
                         lname:     Crypto.decrypt(retjson[i]["lname"].string!))) //putting all relevant information into the workOrders array for cell creation

            dispatch_async(dispatch_get_main_queue()){
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
    
   //Creating our cells and populating our table
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
  {
    let cellIdentifier = "PickupTableViewCell"
    
    //Set the cell as the BikeOrderTableViewCell class, using the WorkOrder data model
    let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! PickupTableViewCell
    let order = workOrders[indexPath.row]
    
    //Setting cell attributes to those in our array
    cell.bikeInfo.text = order.bikeType
    cell.tuneType.text = "tune1"//Tune.ID(order.getServices()[0])
    cell.tagNum.text = order.tagNumber
    cell.lname.text = order.lname

    //cell.backgroundColor = indexPath.row % 2 == 0 ? UIColor(white: 0.7, alpha: 1.0) : UIColor(white: 1.0, alpha: 1.0)

    return cell
  }

  // MARK: - Navigation

  //When a cell is slected, the user will be brought to a new page showing all notes and descriptions of the work done. From here the user can set the bike as picked up.
  // When a bike is picked up, it will be removed from this table
  let awaitingPickupSegueIdentifier = "awaitingPickupSegue"
  
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
