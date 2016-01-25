
//
//  WorkOrderTableViewController.swift
//  FormCycle
//
//  Created by Cross, Adam B on 1/23/16.
//  Copyright © 2016 Merrill Lines. All rights reserved.
//

import UIKit

class WorkOrderTableViewController: UITableViewController {
    
    // MARK: Properties
    
    var workOrders = [WorkOrder]()
    
    func loadSampleData()
    {
        let order1 = WorkOrder(orderNumber: "12", orderID: "1", tune: "A Thing.", bikeType:"Schwin")
        let order2 = WorkOrder(orderNumber: "13", orderID: "2", tune: "A Thing.", bikeType:"Schwin")
        let order3 = WorkOrder(orderNumber: "14", orderID: "3", tune: "A Thing.", bikeType:"Schwin")
        let order4 = WorkOrder(orderNumber: "15", orderID: "4", tune: "A Thing.", bikeType:"Schwin")
        let order5 = WorkOrder(orderNumber: "16", orderID: "5", tune: "A Thing.", bikeType:"Schwin")
        let order6 = WorkOrder(orderNumber: "17", orderID: "6", tune: "A Thing.", bikeType:"Schwin")
        let order7 = WorkOrder(orderNumber: "18", orderID: "7", tune: "A Thing.", bikeType:"Schwin")
        let order8 = WorkOrder(orderNumber: "19", orderID: "8", tune: "A Thing.", bikeType:"Schwin")
        
        workOrders += [order1,order2,order3,order4,order5,order6,order7,order8]
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //Load Sample data
        loadSampleData()
        
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
        let cellIdentifier = "BikeOrderTableViewCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! BikeOrderTableViewCell
        let order = workOrders[indexPath.row]
        
        cell.bikeInfo.text = order.bikeType
        cell.tuneType.text = order.tune
        cell.referenceNumber.text = order.orderNumber
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
