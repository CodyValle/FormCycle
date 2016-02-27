//
//  AutoFillTableViewController.swift
//  FormCycle
//
//  Created by Cross, Adam B on 2/20/16.
//  Copyright © 2016 Merrill Lines. All rights reserved.
//

import UIKit
import SwiftyJSON

protocol AutoFillTableViewControllerDelegate {
    func setTextFields(cust: CustomerAutoFill)
}

class AutoFillTableViewController: UITableViewController {
    
    var resultSet = [CustomerAutoFill]()
    var delegate : AutoFillTableViewControllerDelegate! = nil
    var cust : CustomerAutoFill! = nil
  
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let custIndex = tableView.indexPathForSelectedRow?.row
       {
            delegate.setTextFields(resultSet[custIndex])
    
        }
        self.presentingViewController!.dismissViewControllerAnimated(true, completion: nil)
    }


}
