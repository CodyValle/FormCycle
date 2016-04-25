
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
    
    let myValue = 0
    
    
    /* Reloads data after coming back from Editing a User */
    override func viewDidAppear(animated: Bool) {
        
        
        super.viewDidLoad()
        
        
        //Load data
        editUser.removeAll()
        tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        self.tableView.backgroundColor = UIColor.clearColor()
        self.tableView.opaque.boolValue
        self.tableView.backgroundView = nil
        
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
                }
            }
            else {
                print("Failed to retrieve users.")
            }
            return succ
        })
        
        while ServerCom.waiting() {} // Not neccesarily needed, but is for this example
        
    }
    
    
    /* Initially loads the table as soon as the view loads. */
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
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

                  }
                }
                else {
                  print("Failed to retrieve users.")
                }
                return succ
              })
              
              while ServerCom.waiting() {}
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
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
        
        //Setting the cell background color
        cell.backgroundColor = UIColor.clearColor()
        cell.backgroundColor = UIColor(white: 0.01, alpha:0.75) //Gives a nice dark transparent background
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if (editingStyle == UITableViewCellEditingStyle.Delete)
        {
            
            let user = editUser[indexPath.row]
            var DelParams = ["action":"updateLogin"]
            DelParams["logid"] = user.username
            ServerCom.send(DelParams, f: {(succ: Bool, retjson: JSON) in return succ})
            editUser.removeAtIndex(indexPath.row)
            switch editingStyle {
            case .Delete:
                // remove the deleted item from the model
                self.editUser.removeAtIndex(indexPath.row)
                
                // remove the deleted item from the `UITableView`
                self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            default:
                return
            }
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    let editSegueIndetifier = "editUserSegue"
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        
        if segue.identifier == editSegueIndetifier
        {
            if let destination = segue.destinationViewController as? EditUserViewController
            {
                if let orderIndex = tableView.indexPathForSelectedRow?.row
                {
                    destination.useridPassed = editUser[orderIndex].username
                    destination.adminPassed = editUser[orderIndex].admin
                }
            }
        }
    }
    
}
