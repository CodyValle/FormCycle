/*
 *  AddServicesViewController.swift
 *
 *  This page is the View Controller for the Additional Services Page.
 *  This handles the actions for any buttons that may be defined on this
 *  page.
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

import Foundation
import UIKit
import SwiftHTTP
import SwiftyJSON

class AddServicesViewController: UIViewController
{
    var myArr:[String] = []
    var myStringArr:[String] = [""]
    
    
    @IBAction func backToOrderDetails(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil) /* dismisses the current view */
    }
    @IBAction func SubmitAddServices(sender: AnyObject) {
        var myArray:[String] = AddServices.serviceName
        var newArray:[String] = [""]
        
        for (var i = 0; i < myArray.count; i++)
        {
            if (i == 0)
            {
                newArray[0] = newArray[0] + myArray[i]
            }
            else
            {
                newArray[0] = newArray[0] + "," + myArray[i]
            }
        }
        //print(newArray)
        /* Updates the notes */
        var MyParams = ["action":"workUpdate"]
        MyParams["tune"] = newArray[0]
        ServerCom.send(MyParams, f: {(succ: Bool, retjson: JSON) in return succ})
        

        var myArray1:[String] = AddServices.serviceName
        var newArray1:[String] = self.myArr
        
        
        var MyParams1 = ["action":"workSearch"]
        var MyParams2 = ["action":"workUpdate"]
        // Append possible search data to the parameters. Note: MyParams is changed to a var, instead of a let.
        
        MyParams1["workid"] = AddServices.workOrderId
        ServerCom.send(MyParams1, f: {(succ: Bool, retjson: JSON) in
            if (succ) {
                if (retjson.count > 0) {
                    self.myArr.append(retjson[0]["tune"].string!)
                    self.myStringArr = self.myArr[0].componentsSeparatedByString(",")
                    var counter = 0
                    while( counter < self.myStringArr.count)
                    {
                        self.myStringArr[counter] = Tune.ID(Int(self.myStringArr[counter])!)!
                        counter++
                    }
                    
                    for (var i = 0; i < myArray1.count; i++)
                    {
                        self.myArr[0] = self.myArr[0] + "," + myArray1[i]
                    }
                    AddServices.editServiceArray = self.myArr
                }
                MyParams2["workid"] = AddServices.workOrderId
                MyParams2["tune"] = AddServices.editServiceArray[0]
                ServerCom.send(MyParams2, f: {(succ: Bool, retjson: JSON) in return succ})
                AddServices.editServiceArray.removeAll()
                return true
            }
            return false
        })
        while ServerCom.waiting() {} // Not neccesarily needed, but is for this example
        
        dismissViewControllerAnimated(true, completion: nil) /* dismisses the current view */
        
    }
    
}
