//
//  AutoFillTableViewController.swift
//  FormCycle
//
//  Created by Cross, Adam B on 2/20/16.
//  Copyright © 2016 Merrill Lines. All rights reserved.
//


/*
* This is the class that handles the AutoFill table, and uses the Delegate protocol to fill out the relevant fields on the New Order page. 
* When a cell is selected, this class will tell the ViewController class to run the function setTextFields, and pass along all information stored
* in the AutoFillTableViewCell that was selected.
*
* This is handled by a popover segue, meaning when the search customer button is pushed, the search will be executed and the results will be passed back here,
* and then presented as a popover over the NewOrder page.
*
*/
import UIKit
import SwiftyJSON

protocol AutoFillTableViewControllerDelegate
{
   func setTextFields(cust: CustomerAutoFill)
}

class AutoFillTableViewController: UITableViewController
{
  var resultSet = [CustomerAutoFill]()
  var delegate : AutoFillTableViewControllerDelegate! = nil
  var cust : CustomerAutoFill! = nil

  // MARK: - Table view data source
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int
  {
    return 1
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
    return resultSet.count
  }

  /*
   * Function that initilizes each cell. It pulls information from the resultSet array that comes from the search querie sent and recieved
   * from our database.
   */
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
  {
    let cellIdentifier = "CustSearchTableViewCell"
    let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! CustSearchTableViewCell
    let cust = resultSet[indexPath.row]
    
    cell.fullName.text = cust.name
    cell.address.text = cust.address
    cell.phoneNum.text = cust.phone
    cell.bike.text = cust.bike
    cell.address2 = cust.address2
    cell.city = cust.city
    cell.state = cust.state
    cell.zip = cust.zip
    cell.email = cust.email
    cell.lname = cust.lname
    cell.fname = cust.fname
    cell.brand = cust.brand
    cell.model = cust.model
    cell.color = cust.color

    return cell
  }
    
  //When a cell is selected in this table, it takes the infromation and then sends it to the ViewController class via the delegate protocol
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
  {
    if let custIndex = tableView.indexPathForSelectedRow?.row {
      delegate.setTextFields(resultSet[custIndex])
    }
    self.presentingViewController!.dismissViewControllerAnimated(true, completion: nil)
  }

}
