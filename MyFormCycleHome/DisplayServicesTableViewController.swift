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
        //workOrders.removeAll()
        tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        self.tableView.backgroundColor = UIColor.clearColor()
        self.tableView.opaque.boolValue
        self.tableView.backgroundView = nil
        /* Submits the server request */
        var MyParams = ["action":"workSearch"]
        
        // Append possible search data to the parameters. Note: MyParams is changed to a var, instead of a let.
        //MyParams["open"] = "Y"
        print("Inside display services:",AddServices.workOrderId)
        MyParams["workid"] = AddServices.workOrderId
        ServerCom.send(MyParams, f: {(succ: Bool, retjson: JSON) in
            if (succ) {
                if (retjson.count > 0) {
                    self.myArr.append(retjson[0]["tune"].string!)
                    print("MyFirst array:",self.myArr)
                    self.myStringArr = self.myArr[0].componentsSeparatedByString(",")
                    var counter = 0
                    while( counter < self.myStringArr.count)
                    {
                        self.myStringArr[counter] = Tune.ID(Int(self.myStringArr[counter])!)!
                        counter++
                    }
                        //self.myStringArr.append(self.myStringArr.first!)
                        
                        //self.myStringArr = Tune.ID(Int(self.myStringArr)!)!
                    //}
                    //let tuneList = myArr.characters.split{$0 == ","}.map(String.init)
                    print(self.myStringArr)
                    
                    
                    //self.myArr.append(Tune.ID(Int(retjson[0]["tune"].string!)!)!)
//                    for var i = 0; i < retjson.count; i++ {
//                        self.myArr.append(Tune.ID(Int(retjson[i]["tune"].string!)!)!)
//                        
//                    }
                }
                
                
                
                return true
            }
            return false 
        })
    }
    
//    func refreshView()
//    {
//        if self.workOrders.count == 0 { return }
//        self.workOrders.sortInPlace({ $0.day < $1.day })
//        /*for i in 0...(self.workOrders.count - 1) {
//         if self.workOrders[i].day == WeeklyGlance.getDaySelected() {
//         let w = self.workOrders.removeAtIndex(i)
//         self.workOrders.insert(w, atIndex: 0)
//         }
//         }*/
//        
//        dispatch_async(dispatch_get_main_queue()) {
//            self.tableView.reloadData()
//        }
//        NSNotificationCenter.defaultCenter().postNotificationName("refreshWeeklyGlance", object: nil)
//    }
    
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
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cellIdentifier = "displayCell"
        
        //Set the cell as the BikeOrderTableViewCell class, using the WorkOrder data model
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! DisplayCell
        let order = myStringArr[indexPath.row]
        
        //Setting cell attributes to those in our array
        cell.name.text = order
        //print(myArr)
//        cell.bikeInfo.text = order.bikeType
//        cell.tuneType.text = Tune.ID(order.getServices()[0])
//        cell.referenceNumber.text = order.tagNumber
//        cell.lname.text = order.lname
//        cell.workid = order.orderID
        
        cell.backgroundColor = UIColor.clearColor()
        
        //indexPath.row % 2 == 0 ? UIColor(white: 1.0, alpha: 1.0) : UIColor(white: 0.7, alpha: 1.0)
        //red: 0.2608, green: 0.6255, blue: 1, alpha: 0.75
        return cell
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
//let techSegueIndetifier = "TechEditSegue"
    
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
//    
//}

}
