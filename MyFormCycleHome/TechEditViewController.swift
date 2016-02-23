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
    @IBOutlet weak var userID: UILabel!

    var storedNote = ""
    
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
                                self.userID.text = order[0]["userID"].string!
                                self.fullName.text = order[0]["fname"].string! + " " + order[0]["lname"].string!
                                self.address.text = order[0]["address"].string!
                                if(order[0]["address2"] != nil)
                                {
                                    self.address.text =  self.address.text! + " " + order[0]["address2"].string!
                                }
                                self.cityNState.text = order[0]["city"].string! + ", " + order[0]["state"].string! + ", " + order[0]["zip"].string!
                                self.bikeInfo.text = order[0]["brand"].string! + " " + order[0]["model"].string! + ", " + order[0]["color"].string!
                                self.tune.text = order[0]["tune"].string!
                                self.tagNum.text = order[0]["tagnum"].string!
                                if(order[0]["notes"] != nil)
                                {
                                  self.storedNote = order[0]["notes"].string!
                                }
                              //self.notes.text = "Hello"
                                
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
    
    func submitServerRequest()
    {
        /* Submits the server request */
        var MyParams = ["action":"workUpdate"]
        MyParams["workid"] = workid
        MyParams["open"] = "N"
	      MyParams["notes"] = notes.text
      
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
                                //print("Successfully closed order")
                            }
                            else
                            {
                                // print("Failed to close order")
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

    @IBAction func BackToHomePage(sender: AnyObject)
    {
      /* Updates the notes */
      var MyParams = ["action":"workUpdate"]
      MyParams["workid"] = workid
      MyParams["notes"] = notes.text
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
                  //print("Successfully closed order")
                }
                else
                {
                  // print("Failed to close order")
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

    @IBAction func closeOrder(sender: AnyObject)
    {
        let refreshAlert = UIAlertController(title: "Confirmation", message: "Order will be closed and can no longer be edited.", preferredStyle: UIAlertControllerStyle.Alert)

        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            self.submitServerRequest()
            self.performSegueWithIdentifier("closedOrderSegue", sender: self)
            
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
            
        }))
        
        presentViewController(refreshAlert, animated: true, completion: nil)
    }
    
    
    
    
    override func viewDidLoad() {
        
    
        self.workid = workidPassed
        //Load data
        loadData()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.notes.text = storedNote
    }

    

    
    
    
    
    
    
}