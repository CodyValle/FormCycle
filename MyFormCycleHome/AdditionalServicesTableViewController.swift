//
//  AdditionalServicesViewController.swift
//  FormCycle
//
//  Created by John Ragan on 2/21/16.
//  Copyright © 2016 Merrill Lines. All rights reserved.
//

import UIKit
import SwiftHTTP
import SwiftyJSON

class AdditionalServicesTableViewController: UITableViewController//UIViewController, UITableViewDataSource
{
    
    
    // MARK: Properties
    var addServices = [AddServices]()
    
    
    /* Reloads data after coming back from Editing a User */
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidLoad()
        
        
        //Load data
        addServices.removeAll()
        
        
        //Get and display all users
        var MyParams = ["action":"retrieveTunes"]
        MyParams["tunetype"] = "1"
        ServerCom.send(MyParams, f: {(succ: Bool, retjson: JSON) in
            if succ {
                for (var i = 0; i < retjson.count; i++) {
                    self.addServices.append(AddServices(title: retjson[i]["name"].string!,
                        detail: retjson[i]["cost"].string!))
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
        addServices.removeAll()
        
        
        //Get and display all users
        var MyParams = ["action":"retrieveTunes"]
        MyParams["tunetype"] = "0"
        ServerCom.send(MyParams, f: {(succ: Bool, retjson: JSON) in
            if succ {
                for (var i = 0; i < retjson.count; i++) {
                    self.addServices.append(AddServices(title: retjson[i]["name"].string!,
                        detail: retjson[i]["cost"].string!))
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
        return addServices.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cellIdentifier = "servicesCell"
        
        //Set the cell as the BikeOrderTableViewCell class, using the WorkOrder data model
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! AddServViewCell
        let user = addServices[indexPath.row]
        
        //Setting cell attributes to those in our array
        cell.Title.text = user.title
        cell.Detail.text = user.detail
        
        
        cell.backgroundColor = indexPath.row % 2 == 0 ? UIColor(white: 1.0, alpha: 1.0) : UIColor(white: 0.7, alpha: 1.0)
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
//    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if (editingStyle == UITableViewCellEditingStyle.Delete) {
////            let tune = addServices[indexPath.row]
////            var DelParams = ["action":"editTune"]
////            DelParams["tunename"] = tune.title
////            ServerCom.send(DelParams, f: {(succ: Bool, retjson: JSON) in return succ})
////            addServices.removeAtIndex(indexPath.row)
////            self.tableView.reloadData()
//            // handle delete (by removing the data from your array and updating the tableview)
//        }
//    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //let editSegueIndetifier = "ModifyTune"
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
//    {
//        
//        if segue.identifier == editSegueIndetifier {
//            if let destination = segue.destinationViewController as? ModifyTuneViewController {
//                if let orderIndex = tableView.indexPathForSelectedRow?.row {
//                    destination.namePassed = editTune[orderIndex].name
//                    destination.idPassed = editTune[orderIndex].id
//                    destination.costPassed = editTune[orderIndex].cost
//                    destination.timePassed = editTune[orderIndex].time
//                }
//            }
//        }
//    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//  let Brakes = [
//    ("Brake Adjustment/Rotor True","$14"),
//    ("Brake Cable/Housing Install Basic","$14"),
//    ("Brake Cable/Housing Install Advanced", "$24"),
//    ("Disc Brake Bleed","$30"),
//    ("Brake Surface Cleaning/Pad De-Glazing", "$26"),
//    ("Disc Brake Install w/housing Adjustment", "$30"),
//    ("Disc Brake Install w/o housing Adjustment", "$22") ]
//    
//  let Wheels = [
//    ("Flat Repair","$14"),
//    ("Tubless Tire Install w/ Stans Latex","$26"),
//    ("Tubular Tire w/Glue", "$40"),
//    ("Wheel True","$15 - $30"),
//    ("Spoke Replacement (Spokes Extra)", "$15 - $40"),
//    ("Traditional Wheel Build", "$45"),
//    ("Hub Adjustment Front", "$14"),
//    ("Hub Adjustment Rear", "$18"),
//    ("Hub Overhaul Front", "$24"),
//    ("Hub Overhaul Rear" , "$30") ]
//    
//  let Stem = [
//    ("Headset Adjustment","$10-$20"),
//    ("Headset Installation","$30"),
//    ("Fork Installation", "$35 - $60"),
//    ("Road Bar Installation w/Wrap","$50"),
//    ("Flat Bar Installation", "$30"),
//    ("Aero Bar Installation", "$30"),
//    ("Road Bar Wrap", "$18"),
//    ("Handlebar Cut", "$20"),
//    ("Face Head Tube", "$50") ]
//    
//  let Shifters = [
//    ("Front Derailleur Adjustment","$18"),
//    ("Rear Derailleur Adjustment","$18"),
//    ("Derailleur Cable Installation", "$18"),
//    ("Derailleur Cable Install - Basic","$18"),
//    ("Derailleur Cable Install - Advanced", "$20 - $35"),
//    ("Derailleur Hanger Alignment", "$20 - $35"),
//    ("Rear Derailleur Installation", "$24"),
//    ("Front Derailleur Installation", "$24"),
//    ("Shifter Refurbish and Cleaning (Per Side)", "$30"),
//    ("Road Shifter Install (With Bar Wrap)" , "$40"),
//    ("MTB Shifter Install - Basic", "$30"),
//    ("Road Shifter Install - Basic", "$30") ]
//
//    
//  let Chain = [
//    ("Chain Install","$10"),
//    ("Cassette/Freewheel Install","$10"),
//    ("Chainring Install", "$15 - $30"),
//    ("Crank and BB Install","$35"),
//    ("Chase/Face Bottom Bracket Shell", "$50"),
//    ("Bottom Bracket Install", "$22") ]
//
//  let Computer = [
//    ("Basic Installation","$12"),
//    ("Computer With Cadence","$20") ]
//
//  let Boxing = [
//    ("Box a Bike","$80"),
//    ("Boxed Bike Build","$95 - $125") ]
//
//  override func numberOfSectionsInTableView(tableView: UITableView) -> Int
//  {
//    print(self)
//    return 7
//  }
//   
//  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
//  {
//    switch section
//    {
//      case 0:
//        return Brakes.count
//      case 1:
//        return Wheels.count
//      case 2:
//        return Stem.count
//      case 3:
//        return Shifters.count
//      case 4:
//        return Chain.count
//      case 5:
//        return Computer.count
//      default:
//        return Boxing.count
//    }
//  }
//    
//  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
//  {
//    let  cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
//    
//    if cell.selected
//    {
//        cell.accessoryType = UITableViewCellAccessoryType.Checkmark
//        //print("Cell Selected")
//    }
//    else
//    {
//        cell.accessoryType = UITableViewCellAccessoryType.None
//        //print("Cell not selected")
//    }
//    switch indexPath.section
//    {
//      case 0:
//        let (serviceType, Price) = Brakes[indexPath.row]
//        cell.textLabel!.text = serviceType
//          cell.detailTextLabel?.text = Price
//          
//      case 1:
//        let (serviceType, Price) = Wheels[indexPath.row]
//        cell.textLabel!.text = serviceType
//        cell.detailTextLabel?.text = Price
//          
//      case 2:
//        let (serviceType, Price) = Stem[indexPath.row]
//        cell.textLabel!.text = serviceType
//        cell.detailTextLabel?.text = Price
//          
//      case 3:
//        let (serviceType, Price) = Shifters[indexPath.row]
//        cell.textLabel!.text = serviceType
//        cell.detailTextLabel?.text = Price
//
//      case  4:
//        let (serviceType, Price) = Chain[indexPath.row]
//        cell.textLabel!.text = serviceType
//        cell.detailTextLabel?.text = Price
//        
//      case 5:
//        let (serviceType, Price) = Computer[indexPath.row]
//        cell.textLabel!.text = serviceType
//        cell.detailTextLabel?.text = Price
//
//      default:
//        let (serviceType, Price) = Boxing[indexPath.row]
//        cell.textLabel!.text = serviceType
//        cell.detailTextLabel?.text = Price
//    }
//
//    return cell
//  }
//    
//    
//  override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
//  {
//    switch section
//    {
//      case 0:
//        return "Brakes - Prices are Per Wheel"
//      case 1:
//        return "Wheels - Prices are Per Wheel"
//      case 2:
//        return "Stem, Bars, and Headset"
//      case 3:
//        return "Derailleur and Shifters"
//      case 4:
//        return "Chain and Cranks"
//      case 5:
//        return "Cycling Computer"
//      default:
//        return "Boxing"
//    }
//  }
//    class ListItem: NSObject {
//        let itemName: String
//        var completed: Bool
//        
//        init(itemName: String, completed: Bool = false)
//        {
//            self.itemName = itemName
//            self.completed = completed
//        }
//    }
//  override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
//  {
//    let header = view as! UITableViewHeaderFooterView
//    header.textLabel?.font = UIFont(name: "helvetica", size: 25)
//  }
//    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
//    {
//        let cell = tableView.cellForRowAtIndexPath(indexPath)
//        
//        if (cell?.accessoryType == UITableViewCellAccessoryType.Checkmark){
//            
//            cell!.accessoryType = UITableViewCellAccessoryType.None;
//            
//        }else{
//            
//            cell!.accessoryType = UITableViewCellAccessoryType.Checkmark;
//            
//        }
//    }
    
    


}
