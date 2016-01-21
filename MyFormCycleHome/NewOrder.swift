//
//  NewOrder.swift
//  FormCycle
//
//  Created by Valle, Cody J on 1/21/16.
//  Copyright © 2016 Merrill Lines. All rights reserved.
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
        static var neworderpage = false
        static var bikeInfoPage = false
        static var invoicePage = false
    }
    
    /* Sends the user back to the Home Page if currently on the Customer Information page. */
    @IBAction func backToHomePageBtn(sender: AnyObject)
    {
        newOrderTextFieldStruct.neworderpage = false /* sets current view to false */
        dismissViewControllerAnimated(true, completion: nil) /* dismisses the view controller */
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
    
    @IBAction func RetrieveCustomerInfo(sender: AnyObject)
    {
        /* Submits the server request */
        var MyParams = ["action":"custSearch"]
        
        // Append possible search data to the parameters. Note: MyParams is changed to a var, instead of a let.
        /*if (DEBUG) {
        MyParams["DEBUG"] = "true"
        }*/
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
                            
                            // Some helpful debug data for use when needing to place in table.
                            print("There are \(json.count) rows matching the supplied data.")
                            if (json.count > 0)
                            {
                                // UI updates should not occur on a non-main thread. So call it on the main thread.
                                dispatch_async(dispatch_get_main_queue())
                                    {
                                        // Write all the data to the text fields. We first check to make sure the textfield does not already contain data and that the wanted value exists in the JSON string.
                                        // The [0] is the index of the row that we want to auto fill with.
                                        if (json[0]["fname"].isExists()) {
                                            self.fname.text = json[0]["fname"].string
                                        }
                                        if (json[0]["lname"].isExists()) {
                                            self.lname.text = json[0]["lname"].string
                                        }
                                        if (json[0]["address"].isExists()) {
                                            self.address.text = json[0]["address"].string
                                        }
                                        if (json[0]["address2"].isExists()) {
                                            self.address2.text = json[0]["address2"].string
                                        }
                                        if (json[0]["city"].isExists()) {
                                            self.city.text = json[0]["city"].string
                                        }
                                        if (json[0]["state"].isExists()) {
                                            self.state.text = json[0]["state"].string
                                        }
                                        if (json[0]["zip"].isExists()) {
                                            self.zip.text = json[0]["zip"].string
                                        }
                                        if (json[0]["phone"].isExists()) {
                                            self.phone.text = json[0]["phone"].string
                                        }
                                        if (json[0]["email"].isExists()) {
                                            self.email.text = json[0]["email"].string
                                        }
                                }
                            }
                        }
                    }
            }
        }
        catch let error
        {
            print("got an error creating the request: \(error)")
        }
    }

}
