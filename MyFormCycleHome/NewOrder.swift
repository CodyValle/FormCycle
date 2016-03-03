//
//  NewOrder.swift
//  FormCycle
//
//  Created by Valle, Cody J on 1/21/16.
//  Copyright © 2016 FormCycle Developers. All rights reserved.
//

import UIKit
import SwiftHTTP
import SwiftyJSON

extension ViewController
{
  /*+------------------------------------ NEW ORDER PAGE ------------------------------------+
  | New Order Page is the hub for a new order. This will collect all the customer info     |
  | and save those values to a global struct. This struct allows us to access the saved    |
  | values from this page on any other page in the app.                                    |
  | MARK: New Order Page Text and Server Request                                           |
  +----------------------------------------------------------------------------------------+*/
  
  /* newOrderTextFieldStruct is a struct made to store text in Text Fields for
  *  use when submitting the order on the Bike Info Page.
  *  Initially sets all values in struct to the empty
  *  string. */
  struct newOrderTextFieldStruct 
  {
    static var custid = ""
    static var workid = ""
    static var bikeid = ""
    static var USRname = ""
    static var PWDtext = ""
    static var admin = false
    static var firstName = ""
    static var lastName = ""
    static var myAddress = ""
    static var myAddress2 = ""
    static var myCity = ""
    static var myState = ""
    static var myZip = ""
    static var myPhone = ""
    static var myEmail = ""
    static var myBrand = ""
    static var myModel = ""
    static var myColor = ""
    static var myNotes = ""
    static var myTagNumber = ""
    static var tunePicker = "Basic Tune: $70"
    static var neworderpage = false
    static var bikeInfoPage = false
    static var invoicePage = false
    static var loginPage = true
    static var addServicesPage = false
    static var autoFillPopUp = false
    static var mainPage = false
    static var welcomePopup = true
  }
    
  /* Sends the user back to the Home Page if currently on the Customer Information page. */
  @IBAction func backToMainPageBtn(sender: AnyObject)
  {
    newOrderTextFieldStruct.neworderpage = false /* sets current view to false */
  }

  /* New Order Page: Customer Information. This section denotes the variables
  * as well as the functions that pretain to the Customer Information Page.
  */
  //MARK: Variables and functions for Customer Information Page.
  @IBAction func submitCustInfo(sender: AnyObject)
  {
    newOrderTextFieldStruct.firstName = fname.text!
    newOrderTextFieldStruct.lastName = lname.text!
    newOrderTextFieldStruct.myAddress = address.text!
    newOrderTextFieldStruct.myAddress2 = address2.text!
    newOrderTextFieldStruct.myCity = city.text!
    newOrderTextFieldStruct.myState = state.text!
    newOrderTextFieldStruct.myZip = zip.text!
    newOrderTextFieldStruct.myPhone = phone.text!
    newOrderTextFieldStruct.myEmail = email.text!
  }

  @IBAction func ClearForm(sender: AnyObject)
  {
    fname.text = ""
    lname.text = ""
    address.text = ""
    address2.text = ""
    city.text = ""
    state.text = ""
    zip.text = ""
    phone.text = ""
    email.text = ""
  }

  @IBAction func RetrieveCustomerInfo(sender: AnyObject)
  {
    newOrderTextFieldStruct.autoFillPopUp = true
    /* Submits the server request */
    var MyParams = ["action":"custSearch"]

    if (fname.text != nil) {
        MyParams["fname"] = fname.text!
    }
    if (lname.text != nil) {
        MyParams["lname"] = lname.text!
    }
    if (address.text != nil) {
        MyParams["address"] = address.text!
    }
    if (address2.text != nil) {
        MyParams["address2"] = address2.text!
    }
    if (city.text != nil) {
        MyParams["city"] = city.text!
    }
    if (state.text != nil) {
        MyParams["state"] = state.text!
    }
    if (zip.text != nil) {
        MyParams["zip"] = zip.text!
    }
    if (phone.text != nil) {
        MyParams["phone"] = phone.text!
    }
    if (email.text != nil) {
        MyParams["email"] = email.text!
    }
    ServerCom.send(MyParams, f: {(succ: Bool, retjson: JSON) in
      if succ {
        self.customers = retjson
      }
      return succ
    })
  }

  func setTextFields(cust: CustomerAutoFill)
  {
    self.fname.text = cust.fname
    self.lname.text = cust.lname
    self.address.text = cust.address
    self.address2.text = cust.address2
    self.city.text = cust.city
    self.state.text = cust.state
    self.zip.text = cust.zip
    self.phone.text = cust.phone
    self.email.text = cust.email
  }
   
}

