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
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidLoad()
        
        //Load data
        tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        self.tableView.backgroundColor = UIColor.clearColor()
        self.tableView.opaque.boolValue
        self.tableView.backgroundView = nil
        
        //Get and display all users
        var MyParams = ["action":"workSearch"]
        MyParams["workid"] = AddServices.workOrderId
        
        while ServerCom.waiting() {}
        ServerCom.send(MyParams, f: {(succ: Bool, retjson: JSON) in
            if succ {
                if (retjson.count > 0) {
                    self.myStringArr.removeAll()
                    
                    let tuneIDs: [String] = retjson[0]["tune"].string!.componentsSeparatedByString(",")
                    for id in tuneIDs
                    {
                        print(id)
                        self.myStringArr.append(Tune.ID(Int(id)!)!)
                    }
                    print(self.myStringArr)
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        self.tableView.reloadData()
                    }
                }
            }
            else {
                print("Failed to retrieve users.")
            }
            return succ
        })
    }
    
    func refresh(sender:AnyObject)
    {
        
        myArr.removeAll()
        myStringArr.removeAll()
        // Updating your data here...
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
                        counter += 1
                    }
                    dispatch_async(dispatch_get_main_queue()) {
                        self.tableView.reloadData()
                    }
                    
                }
                
                
                
                return true
            }
            return false
        })
        while ServerCom.waiting() {} // Not neccesarily needed, but is for this example
        
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        myArr.removeAll()
        myStringArr.removeAll()
        self.refreshControl?.addTarget(self, action: #selector(DisplayServicesTableViewController.refresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshView",name:"reloadOpenOrderTable", object: nil)
        
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
                        counter += 1
                    }
                    dispatch_async(dispatch_get_main_queue()) {
                        self.tableView.reloadData()
                    }
                    
                }
                
                
                
                return true
            }
            return false
        })
        //while ServerCom.waiting() {} // Not neccesarily needed, but is for this example
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
            //let tune = myStringArr[indexPath.row]
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
