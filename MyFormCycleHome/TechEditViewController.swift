//
//  TechEdit.swift
//  FormCycle
//
//  Created by Cross, Adam B on 2/6/16.
//  Copyright © 2016 FormCycle Developers. All rights reserved.
//

import Foundation
import UIKit
import SwiftHTTP
import SwiftyJSON

class TechEditViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIPickerViewDelegate
{

    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var cityNState: UILabel!
    @IBOutlet weak var bikeInfo: UILabel!
    @IBOutlet weak var tune: UILabel!
    @IBOutlet weak var tagNum: UILabel!
    @IBOutlet weak var notes: UITextView!

    
    var workidPassed = ""
    var workid = ""
    
    func loadData()
    {
        /* Submits the server request */
        var MyParams = ["action":"workSearch"]
        var isDoneLoading = false //using for concurrency
        
        // Append possible search data to the parameters. Note: MyParams is changed to a var, instead of a let.
        MyParams["workid"] = workid
        do
        {
            /* tries to submit to server */
            let opt = try HTTP.POST("http://107.170.219.218/Capstone/delegate.php", parameters: MyParams)
            
            opt.start
                {
                    response in
                    if let error = response.error
                    {
                        print("got an error: \(error)") /* if error, prints the error code saved on server */
                        return
                    }
                    if (response.text != nil)
                    {
                        if let datafromstring = response.text!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
                        {
                            let json = JSON(data: datafromstring)
                            if (json["success"])
                            {
                                // Probably needs more error checks.
                                let retString = json["return"].string!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
                                let order = JSON(data: retString!)
                                if (order.count > 0) // Fill the form
                                {
                                    self.fullName.text = order[0]["fname"].string! + " " + order[0]["lname"].string!
                                    self.address.text = order[0]["address"].string!
                                    if(order[0]["address2"] != nil)
                                    {
                                        self.address.text =  self.address.text! + " " + order[0]["address2"].string!
                                    }
                                    self.cityNState.text = order[0]["city"].string! + ", " + order[0]["state"].string! + ", " + order[0]["zip"].string!
                                    self.bikeInfo.text = order[0]["brand"].string! + " " + order[0]["model"].string! + ", " + order[0]["color"].string!
                                    self.tune.text = "Bronze"
                                    self.tagNum.text = order[0]["tagnum"].string!
                                    //self.notes.text = order[0]["notes"].string!
                                    
                                }
                                //else you are done- TO DO LATER
                            }
                        }
                    }
                    // Some helpful debug data for use when needing to place in table.
                    isDoneLoading = true
            }
        }
        catch let error
        {
            print("got an error creating the request: \(error)")
        }
        while(!isDoneLoading){} //Pretty stinky, forcing our app to wait for the data to come back from the server before loading the table
        
    }
    
    
    @IBAction func closeOrder(sender: AnyObject) {
        /* Submits the server request */
        var MyParams = ["action":"workUpdate"]
        MyParams["workid"] = workid
        MyParams["open"] = "N"
        do
        {
            /* tries to submit to server */
            let opt = try HTTP.POST("http://107.170.219.218/Capstone/delegate.php", parameters: MyParams)
            opt.start
                {
                    response in
                    if let error = response.error
                    {
                        print("got an error: \(error)") /* if error, prints the error code saved on server */
                        return
                    }
                    
                    // No errors
                    if (response.text != nil)
                    {
                        if let datafromstring = response.text!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
                        {
                            let json = JSON(data: datafromstring)
                            
                            if (json["success"])
                            {
                                print("Successfully closed order")
                            }
                            else
                            {
                                print("Failed to close order")
                            }
                        } //if let datastring = ...
                    } // if (response.text != null)
            } // opt.start
        } // do
        catch let error
        {
            print("got an error creating the request: \(error)")
        } // catch

    }
    
    
    
    
    override func viewDidLoad() {
        
    
        self.workid = workidPassed
        //Load data
        loadData()
        
    }

    

    
    
    
    
    
    
}