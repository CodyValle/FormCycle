
//
//  WorkOrderTableViewController.swift
//  FormCycle
//
//  Created by Lines, Merrill on 3/26/2016
//  Copyright © 2016 FormCycle Developers. All rights reserved.
//

import UIKit
import SwiftHTTP
import SwiftyJSON

class EditUsersTableViewController: UITableViewController
{
    
    // MARK: Properties
    var editUser = [EditUser]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //Load data
        editUser.removeAll()
        
        
         //Get and display all users
              let MyParams = ["action":"retrieveUsers"]
        
              ServerCom.send(MyParams, f: {(succ: Bool, retjson: JSON) in
                if succ {
                  //print("There are \(retjson.count) tunes on the server")
                  for (var i = 0; i < retjson.count; i++) {
                    self.editUser.append(EditUser(username: retjson[i]["username"].string!,
                        admin: retjson[i]["admin"].string!))
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        self.tableView.reloadData()
                    }
//                    print("User \(i):")
//                    print("username: \(retjson[i]["username"].string!)")
//                    print("admin: \(retjson[i]["admin"].string!)")
//                    print("\n")
                  }
                }
                else {
                  print("Failed to retrieve users.")
                }
                return succ
              })
              
              while ServerCom.waiting() {} // Not neccesarily needed, but is for this example
        
        /* Submits the server request */
//        var MyParams = ["action":"workSearch"]
//        
//        // Append possible search data to the parameters. Note: MyParams is changed to a var, instead of a let.
//        MyParams["open"] = "Y"
//        
//        ServerCom.send(MyParams, f: {(succ: Bool, retjson: JSON) in
//            if (succ) {
//                if (retjson.count > 0) {
//                    for var i = 0; i < retjson.count; i++ {
//                        self.workOrders.append(WorkOrder(tagNumber: retjson[i]["tagnum"].string!,
//                            orderID:   retjson[i]["workid"].string!,
//                            tune:      retjson[i]["tune"].string!,
//                            bikeType:  retjson[i]["brand"].string!,
//                            model:     retjson[i]["model"].string!,
//                            lname:     Crypto.decrypt(retjson[i]["lname"].string!)))
//                        
//                        dispatch_async(dispatch_get_main_queue()) {
//                            self.tableView.reloadData()
//                        }
//                    }
//                }
//                //else you are done- TO DO LATER
//                return true
//            }
//            return false
//        })
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
        return editUser.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cellIdentifier = "UserCell"
        
        //Set the cell as the BikeOrderTableViewCell class, using the WorkOrder data model
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! UsersTableViewCell
        let user = editUser[indexPath.row]
        
        //Setting cell attributes to those in our array
        cell.username.text = user.username
        cell.admin.text = user.admin
        //cell.username.text = "161616"//order.tagNumber
        
        
        cell.backgroundColor = indexPath.row % 2 == 0 ? UIColor(white: 1.0, alpha: 1.0) : UIColor(white: 0.7, alpha: 1.0)
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            editUser.removeAtIndex(indexPath.row)
            self.tableView.reloadData()
            // handle delete (by removing the data from your array and updating the tableview)
        }
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    let techSegueIndetifier = "TechEditSegue"
//    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
//    {
//        if segue.identifier == techSegueIndetifier {
//            if let destination = segue.destinationViewController as? TechEditViewController {
//                if let orderIndex = tableView.indexPathForSelectedRow?.row {
//                    destination.workidPassed = workOrders[orderIndex].orderID
//                }
//            }
//        }
//    }
    
}