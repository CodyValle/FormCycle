//
//  DisplayServicesTableViewController.swift
//  FormCycle
//
//  Created by Merrill Lines on 4/23/16.
//  Copyright © 2016 Merrill Lines. All rights reserved.
//

import UIKit
import SwiftHTTP
import SwiftyJSON

class DisplayServicesTableViewController: UITableViewController
{
    // MARK: Properties
    var myArr :[String] = []
    var myStringArr: [String] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshView",name:"reloadOpenOrderTable", object: nil)
        
        //Load data
        tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        self.tableView.backgroundColor = UIColor.clearColor()
        self.tableView.opaque.boolValue
        self.tableView.backgroundView = nil
        /* Submits the server request */
        var MyParams = ["action":"workSearch"]
        
        // Append possible search data to the parameters. Note: MyParams is changed to a var, instead of a let.
        
        MyParams["workid"] = AddServices.workOrderId
        ServerCom.send(MyParams, f: {(succ: Bool, retjson: JSON) in
            if (succ) {
                if (retjson.count > 0) {
                    self.myArr.append(retjson[0]["tune"].string!)
                    self.myStringArr = self.myArr[0].componentsSeparatedByString(",")
                    var counter = 0
                    while( counter < self.myStringArr.count)
                    {
                        self.myStringArr[counter] = Tune.ID(Int(self.myStringArr[counter])!)!
                        counter++
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
        return myStringArr.count
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            let tune = myStringArr[indexPath.row]
            var DelParams = ["action":"workSearch"]
            //DelParams["tunename"] = edit.tune
            DelParams["workid"] = AddServices.workOrderId
            DelParams["tune"] = myStringArr.removeAtIndex(indexPath.row)
            ServerCom.send(DelParams, f: {(succ: Bool, retjson: JSON) in return succ})
//            myStringArr.removeAtIndex(indexPath.row)
            self.tableView.reloadData()
            // handle delete (by removing the data from your array and updating the tableview)
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cellIdentifier = "displayCell"
        
        //Set the cell as the BikeOrderTableViewCell class, using the WorkOrder data model
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! DisplayCell
        let order = myStringArr[indexPath.row]
        
        //Setting cell attributes to those in our array
        cell.name.text = order
        cell.backgroundColor = UIColor.clearColor()
        return cell
    }
    

}
