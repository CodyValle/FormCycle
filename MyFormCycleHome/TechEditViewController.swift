//
//  TechEdit.swift
//  FormCycle
//
//  Created by Cross, Adam B on 2/6/16.
//  Copyright © 2016 FormCycle Developers. All rights reserved.
//

/*
 * This class will handle the TechEdit page. The user will come to this page when they select a currently open work order from the
 * WorkOrders table. On this page, they will be able to edit notes and read all information regarding the selected work order.
 * The user can also add on more additional services that need to be done to the bike, or close the order and move it to the waiting
 * pickup table.
 */

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
  
  func submitServerRequest()
  {
    /* Submits the server request */
    var MyParams = ["action":"workUpdate"]
    MyParams["workid"] = workid
    MyParams["open"] = "N"
    MyParams["notes"] = notes.text

    ServerCom.send(MyParams, f: {(succ: Bool, retjson: JSON) in
      if succ { BinPacker.removerOrder(self.workid) }
      return succ
    })
  }

  @IBAction func BackToHomePage(sender: AnyObject)
  {
    /* Updates the notes */
    var MyParams = ["action":"workUpdate"]
    MyParams["workid"] = workid
    MyParams["notes"] = notes.text

    ServerCom.send(MyParams, f: {(succ: Bool, retjson: JSON) in return succ})
  }

  @IBAction func closeOrder(sender: AnyObject)
  {
    let refreshAlert = UIAlertController(title: "Confirmation", message: "Order will be closed and can no longer be edited.", preferredStyle: UIAlertControllerStyle.Alert)

    refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
      self.submitServerRequest()
      self.performSegueWithIdentifier("closedOrderSegue", sender: self)
    }))
    
    refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in }))
    
    presentViewController(refreshAlert, animated: true, completion: nil)
  }

    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
  override func viewDidLoad()
  {
    self.workid = workidPassed

    //Looks for single or multiple taps.
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
    view.addGestureRecognizer(tap)
    //Load data
    /* Submits the server request */
    var MyParams = ["action":"workSearch"]

    // Append possible search data to the parameters. Note: MyParams is changed to a var, instead of a let.
    MyParams["workid"] = workid

    ServerCom.send(MyParams, f: {(succ: Bool, retjson: JSON) in
      if succ
      {
        if (retjson.count > 0) // Fill the form
        {
          self.userID.text = retjson[0]["userID"].string!
          self.fullName.text = Crypto.decrypt(retjson[0]["fname"].string!) + " " + Crypto.decrypt(retjson[0]["lname"].string!)
          self.address.text = Crypto.decrypt(retjson[0]["address"].string!)
          if(retjson[0]["address2"] != nil) {
            self.address.text =  self.address.text! + " " + Crypto.decrypt(retjson[0]["address2"].string!)
          }
          self.cityNState.text = Crypto.decrypt(retjson[0]["city"].string!) + ", " + retjson[0]["state"].string! + ", " + Crypto.decrypt(retjson[0]["zip"].string!)
          self.bikeInfo.text = retjson[0]["brand"].string! + " " + retjson[0]["model"].string! + ", " + retjson[0]["color"].string!

          var tuneString = retjson[0]["tune"].string!
          if let tuneID = Int(tuneString)
          {
            tuneString = Tune.ID(tuneID)!
          }
          self.tune.text = tuneString
          self.tagNum.text = retjson[0]["tagnum"].string!
          if(retjson[0]["notes"] != nil) {
            self.storedNote = retjson[0]["notes"].string!
          }
          
        }
        return true
      }
      return false
    })

    while ServerCom.waiting() {}
  }
    
  override func viewWillAppear(animated: Bool)
  {
    self.notes.text = storedNote //Only set the notes field when the view has finished loading. Cannot access the text area before this point.
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
  {
    if segue.identifier == "AddlServices"
    {
      segue.destinationViewController
      print(self)
    }
  }
    
}