//
//  AutoFillTableViewController.swift
//  FormCycle
//
//  Created by Cross, Adam B on 2/20/16.
//  Copyright © 2016 Merrill Lines. All rights reserved.
//

import UIKit
import SwiftyJSON

class AutoFillTableViewController: UITableViewController {
    
    var resultSet = [CustomerAutoFill]()

    
  
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("In the table")
        print(resultSet.count)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        // #warning Incomplete implementation, return the number of rows
        return resultSet.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "CustSearchTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! CustSearchTableViewCell
        let cust = resultSet[indexPath.row]
        
        cell.fullName.text = cust.name
        cell.address.text = cust.address
        cell.phoneNum.text = cust.phone
        cell.address2 = cust.address2
        cell.city = cust.city
        cell.state = cust.state
        cell.zip = cust.zip
        cell.email = cust.email
        cell.lname = cust.lname
        cell.fname = cust.fname

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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "autoFillSelection"
        {
            if let destination = segue.destinationViewController as? ViewController
            {
                if let custIndex = tableView.indexPathForSelectedRow?.row
                {
                    destination.fname.text = resultSet[custIndex].fname
                    destination.lname.text = resultSet[custIndex].lname
                    destination.address.text = resultSet[custIndex].address
                    destination.address2.text = resultSet[custIndex].address2
                    destination.city.text = resultSet[custIndex].city
                    destination.state.text = resultSet[custIndex].state
                    destination.zip.text = resultSet[custIndex].zip
                    destination.phone.text = resultSet[custIndex].phone
                    destination.email.text = resultSet[custIndex].email
                }
            }
        }
    }

}
