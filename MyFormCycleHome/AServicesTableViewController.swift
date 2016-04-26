/*
*  AServicesTableViewController.swift
*  FormCycle
*
*  Created by John Ragan on 4/11/16.
*  Copyright © 2016 Merrill Lines. All rights reserved.
*
*  This page is the View Controller for the Additional Services Table. 
*  This defines the elements in the table as being pulled from the
*  server. This includes the sections for different types of addtional
*  services.
*
*  Created by FormCycle Development Team on 4/11/16.
*  Copyright © 2016 FormCycle. All rights reserved.
*  License:
*   The MIT License (MIT)
 
 Copyright (c) 2015 FormCycle.
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

import UIKit
import SwiftHTTP
import SwiftyJSON

class AServicesTableViewController: UITableViewController
{
    // MARK: Properties
    var editTune = [EditTune]()
    var brakeSection = [EditTune]()
    var wheelSection = [EditTune]()
    var barStemSection = [EditTune]()
    var derailleurShifterSection = [EditTune]()
    var chainCranksSection = [EditTune]()
    var computerSection = [EditTune]()
    var boxingSection = [EditTune]()
//    struct AddServices
//    {
//        static var serviceName:[String] = []
//    }
    
    /* Initially loads the table as soon as the view loads. */
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        
        
        //Load data
        editTune.removeAll()
        tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        self.tableView.backgroundColor = UIColor.clearColor()
        self.tableView.opaque.boolValue
        self.tableView.backgroundView = nil
        
        
        //Get and display all users
        let MyParams = ["action":"retrieveTunes"]
        ServerCom.send(MyParams, f: {(succ: Bool, retjson: JSON) in
            if succ
            {
                for (var i = 0; i < retjson.count; i++) {
                    if(retjson[i]["type"].string! == "0" ) { /*Do Nothing*/ }
                    else if(retjson[i]["type"].string! == "1") { /*Do Nothing*/ }
                    else if(retjson[i]["type"].string! == "2")
                    {
                        self.brakeSection.append(EditTune(name: retjson[i]["name"].string!,
                            cost: Int(retjson[i]["cost"].string!)!,
                            id: Int(retjson[i]["tune"].string!)!,
                            time: retjson[i]["time"].string!.floatValue,
                            tune: retjson[i]["type"].string!))
                        
                    }
                    else if(retjson[i]["type"].string! == "3")
                    {
                        self.wheelSection.append(EditTune(name: retjson[i]["name"].string!,
                            cost: Int(retjson[i]["cost"].string!)!,
                            id: Int(retjson[i]["tune"].string!)!,
                            time: retjson[i]["time"].string!.floatValue,
                            tune: retjson[i]["type"].string!))                    }
                    else if(retjson[i]["type"].string! == "4")
                    {
                        self.barStemSection.append(EditTune(name: retjson[i]["name"].string!,
                            cost: Int(retjson[i]["cost"].string!)!,
                            id: Int(retjson[i]["tune"].string!)!,
                            time: retjson[i]["time"].string!.floatValue,
                            tune: retjson[i]["type"].string!))                    }
                    else if(retjson[i]["type"].string! == "5")
                    {
                        self.derailleurShifterSection.append(EditTune(name: retjson[i]["name"].string!,
                            cost: Int(retjson[i]["cost"].string!)!,
                            id: Int(retjson[i]["tune"].string!)!,
                            time: retjson[i]["time"].string!.floatValue,
                            tune: retjson[i]["type"].string!))                    }
                    else if(retjson[i]["type"].string! == "6")
                    {
                        self.chainCranksSection.append(EditTune(name: retjson[i]["name"].string!,
                            cost: Int(retjson[i]["cost"].string!)!,
                            id: Int(retjson[i]["tune"].string!)!,
                            time: retjson[i]["time"].string!.floatValue,
                            tune: retjson[i]["type"].string!))                    }
                    else if(retjson[i]["type"].string! == "7")
                    {
                        self.computerSection.append(EditTune(name: retjson[i]["name"].string!,
                            cost: Int(retjson[i]["cost"].string!)!,
                            id: Int(retjson[i]["tune"].string!)!,
                            time: retjson[i]["time"].string!.floatValue,
                            tune: retjson[i]["type"].string!))                    }
                    else if(retjson[i]["type"].string! == "8")
                    {
                        self.boxingSection.append(EditTune(name: retjson[i]["name"].string!,
                            cost: Int(retjson[i]["cost"].string!)!,
                            id: Int(retjson[i]["tune"].string!)!,
                            time: retjson[i]["time"].string!.floatValue,
                            tune: retjson[i]["type"].string!))                    }
                    else
                    {
                        self.editTune.append(EditTune(name: retjson[i]["name"].string!,
                            cost: Int(retjson[i]["cost"].string!)!,
                            id: Int(retjson[i]["tune"].string!)!,
                            time: retjson[i]["time"].string!.floatValue,
                            tune: retjson[i]["type"].string!))                    }                }
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
        return 8
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        switch section
        {
        case 0:
            return brakeSection.count
        case 1:
            return wheelSection.count
        case 2:
            return barStemSection.count
        case 3:
            return derailleurShifterSection.count
        case 4:
            return chainCranksSection.count
        case 5:
            return computerSection.count
        case 6:
            return boxingSection.count
        default:
            return editTune.count
        }
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.section
        {
            
        case 0:
            let user = brakeSection[indexPath.row]
            AddServices.serviceName = AddServices.serviceName.filter{$0 != (String(user.id))}
        case 1:
            let user = wheelSection[indexPath.row]
            AddServices.serviceName = AddServices.serviceName.filter{$0 != (String(user.id))}
        case 2:
            let user = barStemSection[indexPath.row]
            AddServices.serviceName = AddServices.serviceName.filter{$0 != (String(user.id))}
        case 3:
            let user = derailleurShifterSection[indexPath.row]
            AddServices.serviceName = AddServices.serviceName.filter{$0 != (String(user.id))}
        case 4:
            let user = chainCranksSection[indexPath.row]
            AddServices.serviceName = AddServices.serviceName.filter{$0 != (String(user.id))}
        case 5:
            let user = computerSection[indexPath.row]
            AddServices.serviceName = AddServices.serviceName.filter{$0 != (String(user.id))}
        case 6:
            let user = boxingSection[indexPath.row]
            AddServices.serviceName = AddServices.serviceName.filter{$0 != (String(user.id))}
        default:
            let user = editTune[indexPath.row]
            AddServices.serviceName = AddServices.serviceName.filter{$0 != (String(user.id))}
        }
           }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch indexPath.section
        {
            
        case 0:
            let user = brakeSection[indexPath.row]
            AddServices.serviceName.append(String(user.id))
            //print(user.id)
        case 1:
            let user = wheelSection[indexPath.row]
            AddServices.serviceName.append(String(user.id))
            //print(user.id)
        case 2:
            let user = barStemSection[indexPath.row]
            AddServices.serviceName.append(String(user.id))
            //print(user.id)
        case 3:
            let user = derailleurShifterSection[indexPath.row]
            AddServices.serviceName.append(String(user.id))
        case 4:
            let user = chainCranksSection[indexPath.row]
            AddServices.serviceName.append(String(user.id))
        case 5:
            let user = computerSection[indexPath.row]
            AddServices.serviceName.append(String(user.id))
        case 6:
            let user = boxingSection[indexPath.row]
            AddServices.serviceName.append(String(user.id))
        default:
            let user = editTune[indexPath.row]
            AddServices.serviceName.append(String(user.id))
        }
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cellIdentifier = "AddCell"
        
        //Set the cell as the BikeOrderTableViewCell class, using the WorkOrder data model
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! AddServCell
        switch indexPath.section
        {
        //Setting cell attributes to those in our array
        case 0:
            let user = brakeSection[indexPath.row]
            cell.name.text = user.name
            cell.cost.text = "$" + String(user.cost)
            cell.time.text = String(user.time)
        case 1:
            let user = wheelSection[indexPath.row]
            cell.name.text = user.name
            cell.cost.text = "$" + String(user.cost)
            cell.time.text = String(user.time)
        case 2:
            let user = barStemSection[indexPath.row]
            cell.name.text = user.name
            cell.cost.text = "$" + String(user.cost)
            cell.time.text = String(user.time)
        case 3:
            let user = derailleurShifterSection[indexPath.row]
            cell.name.text = user.name
            cell.cost.text = "$" + String(user.cost)
            cell.time.text = String(user.time)
        case 4:
            let user = chainCranksSection[indexPath.row]
            cell.name.text = user.name
            cell.cost.text = "$" + String(user.cost)
            cell.time.text = String(user.time)
        case 5:
            let user = computerSection[indexPath.row]
            cell.name.text = user.name
            cell.cost.text = "$" + String(user.cost)
            cell.time.text = String(user.time)
        case 6:
            let user = boxingSection[indexPath.row]
            cell.name.text = user.name
            cell.cost.text = "$" + String(user.cost)
            cell.time.text = String(user.time)
        default:
            let user = editTune[indexPath.row]
            cell.name.text = user.name
            cell.cost.text = "$" + String(user.cost)
            cell.time.text = String(user.time)
        }
        cell.backgroundColor = UIColor.clearColor()
        cell.backgroundColor = UIColor(white: 0.01, alpha:0.7) //Gives a nice dark transparent background
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        return true
    }
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        switch section
        {
        case 0:
            return "Brakes - Prices are Per Wheel"
        case 1:
            return "Wheels - Prices are Per Wheel"
        case 2:
            return "Stem, Bars, and Headset"
        case 3:
            return "Derailleur and Shifters"
        case 4:
            return "Chain and Cranks"
        case 5:
            return "Cycling Computer"
        case 6:
            return "Boxing"
        default:
            return "Misc"
        }
        
        
    }
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView //recast view as a UITableViewHeaderFooterView
        header.contentView.backgroundColor = UIColor(white: 0.01, alpha:0.7) //make the background color light gray
        header.textLabel!.textColor = UIColor.whiteColor() //make the text white
        header.alpha = 0.5 //make the header transparent
    }
    
    
}

