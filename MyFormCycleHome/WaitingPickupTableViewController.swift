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

class WaitingPickupTableViewController: UITableViewController {
    
    // MARK: Properties
    
    var workOrders = [WorkOrder]()
    
    func loadData()
    {
        /* Submits the server request */
        var MyParams = ["action":"workSearch"]
        var isDoneLoading = false //using for concurrency
        
        // Append possible search data to the parameters. Note: MyParams is changed to a var, instead of a let.
        MyParams["open"] = "N"
        do
        {
            /* tries to submit to server */
            let opt = try HTTP.POST("http://107.170.219.218/Capstone/delegate.php", parameters: MyParams)
            opt.start
                {
                    response in
                    if let error = response.error
                    {
                        print("got an error: \(error)") /* if error, prints the error code saved on server */
                        return
                    }
                    if (response.text != nil)
                    {
                        if let datafromstring = response.text!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
                        {
                            
                            let json = JSON(data: datafromstring)
                            if (json["success"])
                            {
                                
                                // Probably needs more error checks.
                                let retString = json["return"].string!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
                                let orders = JSON(data: retString!)
                                //print(orders[0]["tune"].string!)
                                if (orders.count > 0) // Fill the form
                                {
                                    for var i = 0; i < orders.count; i++
                                    {
                                        self.workOrders.append(WorkOrder(tagNumber: orders[i]["tagnum"].string!, orderID:orders[i]["workid"].string!, tune: "Tune: Bronze", bikeType:orders[i]["brand"].string!, model:orders[i]["model"].string!, lname:orders[i]["lname"].string!))
                                    }
                                }
                                //else you are done- TO DO LATER
                            }
                            
                            // Some helpful debug data for use when needing to place in table.
                            print("There are \(json.count) rows matching the supplied data.")
                            isDoneLoading = true
                        }
                    }
            }
        }
        catch let error
        {
            print("got an error creating the request: \(error)")
        }
        while(!isDoneLoading){} //Pretty stinky, forcing our app to wait for the data to come back from the server before loading the table
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //Load data

        loadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return workOrders.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "PickupTableViewCell"
        
        //Set the cell as the BikeOrderTableViewCell class, using the WorkOrder data model
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! PickupTableViewCell
        let order = workOrders[indexPath.row]
        
        //Setting cell attributes to those in our array
        cell.bikeInfo.text = order.bikeType
        cell.tuneType.text = order.tune
        cell.tagNum.text = order.tagNumber
        cell.lname.text = order.lname
        return cell
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
    }
    */
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    let awaitingPickupSegueIdentifier = "awaitingPickupSegue"
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == awaitingPickupSegueIdentifier
        {
            if let destination = segue.destinationViewController as? AwaitingOrderViewController
            {
                if let orderIndex = tableView.indexPathForSelectedRow?.row
                {
                    destination.workidPassedWait = workOrders[orderIndex].orderID
                }
            }
        }
    }
    
}
