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
  
  var workidPassed = ""
  var workid = ""

  @IBAction func BackToHomePage(sender: AnyObject)
  {
    /* Updates the notes */
    var MyParams = ["action":"workUpdate"]
    MyParams["workid"] = workid
    MyParams["notes"] = notes.text

    ServerCom.send(MyParams, f: {(json:JSON) in return json["success"].bool! })
  }

  @IBAction func closeOrder(sender: AnyObject)
  {
    let refreshAlert = UIAlertController(title: "Confirmation", message: "Order will be closed and can no longer be edited.", preferredStyle: UIAlertControllerStyle.Alert)

    refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler:
      { (action: UIAlertAction!) in
        /* Submits the server request */
        var MyParams = ["action":"workUpdate"]
        MyParams["workid"] = self.workid
        MyParams["open"] = "N"
        MyParams["notes"] = self.notes.text
        ServerCom.send(MyParams, f: {(json:JSON) in return json["success"].bool! })

        self.performSegueWithIdentifier("closedOrderSegue", sender: self)
        
    	}))
    
    refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in }))
    
    presentViewController(refreshAlert, animated: true, completion: nil)
  }

  override func viewDidLoad()
  {
    self.workid = workidPassed

    //Load data
    /* Submit the server request */
    var MyParams = ["action":"workSearch"]

    // Append possible search data to the parameters.
    MyParams["workid"] = workid

    ServerCom.send(MyParams, f: {(json:JSON) in
      if (json["success"])
      {
        let retString = json["return"].string!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        let order = JSON(data: retString!)

        if (order.count > 0) // Fill the form
        {
          dispatch_async(dispatch_get_main_queue())
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
            if(order[0]["notes"] != nil) {
              self.notes.text = order[0]["notes"].string!
            }
          }
        }
        //else you are done- TO DO LATER
        return true
      }
      return false

    })
  }
}