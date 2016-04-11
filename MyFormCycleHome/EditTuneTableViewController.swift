//
//  EditTuneTableViewController.swift
//  FormCycle
//
//  Created by Merrill Lines on 4/2/16.
//  Copyright © 2016 Merrill Lines. All rights reserved.
//

import UIKit
import SwiftHTTP
import SwiftyJSON

class EditTuneTableViewController: UITableViewController
{
    
    
    // MARK: Properties
    var editTune = [EditTune]()
    
    
    /* Reloads data after coming back from Editing a User */
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidLoad()
        
        
        //Load data
        editTune.removeAll()
        
        
        //Get and display all users
        var MyParams = ["action":"retrieveTunes"]
        MyParams["tunetype"] = "1"
        ServerCom.send(MyParams, f: {(succ: Bool, retjson: JSON) in
            if succ {
                for (var i = 0; i < retjson.count; i++) {
                    self.editTune.append(EditTune(name: retjson[i]["name"].string!,
                        cost: Int(retjson[i]["cost"].string!)!,
                        id: Int(retjson[i]["tune"].string!)!,
                        time: retjson[i]["time"].string!.floatValue,
                        tune: retjson[i]["tune"].string!))
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
        
        
        //Load data
        editTune.removeAll()
        
        
        //Get and display all users
        var MyParams = ["action":"retrieveTunes"]
        MyParams["tunetype"] = "1"
            ServerCom.send(MyParams, f: {(succ: Bool, retjson: JSON) in
                if succ {
                    for (var i = 0; i < retjson.count; i++) {
                        
                        self.editTune.append(EditTune(name: retjson[i]["name"].string!,
                            cost: Int(retjson[i]["cost"].string!)!,
                            id: Int(retjson[i]["tune"].string!)!,
                            time: retjson[i]["time"].string!.floatValue,
                            tune: retjson[i]["tune"].string!))
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
        return editTune.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cellIdentifier = "TuneCell"
        
        //Set the cell as the BikeOrderTableViewCell class, using the WorkOrder data model
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! TuneTableViewCell
        let user = editTune[indexPath.row]
        
        //Setting cell attributes to those in our array
        cell.name.text = user.name
        cell.cost.text = "$" + String(user.cost)
        
        
        cell.backgroundColor = indexPath.row % 2 == 0 ? UIColor(white: 1.0, alpha: 1.0) : UIColor(white: 0.7, alpha: 1.0)
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            let tune = editTune[indexPath.row]
            var DelParams = ["action":"editTune"]
            DelParams["tunename"] = tune.name
            ServerCom.send(DelParams, f: {(succ: Bool, retjson: JSON) in return succ})
            editTune.removeAtIndex(indexPath.row)
            self.tableView.reloadData()
            // handle delete (by removing the data from your array and updating the tableview)
        }
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    let editSegueIndetifier = "ModifyTune"
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        
        if segue.identifier == editSegueIndetifier {
            if let destination = segue.destinationViewController as? ModifyTuneViewController {
                if let orderIndex = tableView.indexPathForSelectedRow?.row {
                    destination.namePassed = editTune[orderIndex].name
                    destination.idPassed = editTune[orderIndex].id
                    destination.costPassed = editTune[orderIndex].cost
                    destination.timePassed = editTune[orderIndex].time
                }
            }
        }
    }
    
}
