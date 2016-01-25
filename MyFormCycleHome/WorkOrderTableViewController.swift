
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
        /* Submits the server request */
        var MyParams = ["action":"workSearch"]
        
        // Append possible search data to the parameters. Note: MyParams is changed to a var, instead of a let.
        MyParams["open"] = "Y"
        MyParams["lname"] = "Bowers"
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
                        print(response.text!)
                        if let datafromstring = response.text!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
                        {
                            
                            let json = JSON(data: datafromstring)
                            if (json["success"])
                            {
                                
                                // Probably needs more error checks.
                                let retString = json["return"].string!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
                                let orders = JSON(data: retString!)
                                print(orders.count)
                                if (orders.count > 0) // Fill the form
                                {
                                    for var i = 0; i < orders.count; i++
                                    {
                                        
                                        self.workOrders += [WorkOrder(orderNumber: orders[i]["workid"].string!, orderID:orders[i]["workid"].string!, tune: "Bronze", bikeType:orders[i]["brand"].string!)]
                                    }
                                }
                                //else you are done- TO DO LATER
                            }
                            
                            // Some helpful debug data for use when needing to place in table.
                            print("There are \(json.count) rows matching the supplied data.")
                            print(json);
                        }
                    }
            }
        }
        catch let error
        {
            print("got an error creating the request: \(error)")
        }
        
        print(self.workOrders)
        
        /*let order1 = WorkOrder(orderNumber: "12", orderID: "1", tune: "A Thing.", bikeType:"Schwin")
        let order2 = WorkOrder(orderNumber: "13", orderID: "2", tune: "A Thing.", bikeType:"Schwin")
        let order3 = WorkOrder(orderNumber: "14", orderID: "3", tune: "A Thing.", bikeType:"Schwin")
        let order4 = WorkOrder(orderNumber: "15", orderID: "4", tune: "A Thing.", bikeType:"Schwin")
        let order5 = WorkOrder(orderNumber: "16", orderID: "5", tune: "A Thing.", bikeType:"Schwin")
        let order6 = WorkOrder(orderNumber: "17", orderID: "6", tune: "A Thing.", bikeType:"Schwin")
        let order7 = WorkOrder(orderNumber: "18", orderID: "7", tune: "A Thing.", bikeType:"Schwin")
        let order8 = WorkOrder(orderNumber: "19", orderID: "8", tune: "A Thing.", bikeType:"Schwin")
        
        workOrders += [order1,order2,order3,order4,order5,order6,order7,order8]*/
      
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
