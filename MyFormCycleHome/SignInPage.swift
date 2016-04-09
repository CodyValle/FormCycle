//
//  SignInPage.swift
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
  /*+------------------------------------ SIGN IN PAGE ------------------------------------+
  | This is the Login Page which will be implemented at a later date.                    |
  | Due to this, the section referred to as MARK: Login Page text and Server Request     |
  | will remain commented out until finally becoming implemented.                        |
  | MARK: Login Page text and Server Request                                             |
  +--------------------------------------------------------------------------------------+*/
  
  
  /* Function to allow the user a secret link to "This Bike Life's" Webpage.
  *  We just wanted to have some fun and see if anyone finds this easter egg.
  */
  @IBAction func myLogoWebpageLink(sender: AnyObject)
  {
   if let url = NSURL(string: "http://www.thisbikelife.com") {
      UIApplication.sharedApplication().openURL(url)
   }
  }

    /* Admin login button to transition to forgot password recovery page */
    @IBAction func forgotPassword(sender: AnyObject)
    {
      let alert = UIAlertController(title: "Admin Login", message: "Enter Username and Password", preferredStyle: UIAlertControllerStyle.Alert)

        alert.addTextFieldWithConfigurationHandler(configurationTextField)
        alert.addTextFieldWithConfigurationHandler(passwordTextField)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: handleCancel))
        alert.addAction(UIAlertAction(title: "Submit", style: UIAlertActionStyle.Default, handler:{(UIAlertAction) in
            /* Submits the server request */
            var MyParams = ["action":"login"]
            
            // Append possible search data to the parameters.
            if (self.tField.text != nil) {
                MyParams["logid"] = self.tField.text
            }
            if (self.pField.text != nil) {
                MyParams["pwd"] = Crypto.encrypt(self.pField.text!)
            }
            
            ServerCom.send(MyParams, f: {(succ: Bool, retjson: JSON) in
                if (succ)
                {
                    if let retjson = retjson[0]["admin"].string {

                      if retjson == "Y" {
                        generateIncorrectLoginAttempts.loginAttempts = 0
                        newOrderTextFieldStruct.USRname = self.tField.text!
                        self.performSegueWithIdentifier("segueIdentifier", sender: self)
                        return true
                      }

                    }


                    NSOperationQueue.mainQueue().addOperationWithBlock
                      {
                        alert.title = "Incorrect Username or Password"
                        alert.message = "Try Again"

                        self.presentViewController(alert, animated: true, completion: { })

                  }


                    return false
                }
                else
                {


                        NSOperationQueue.mainQueue().addOperationWithBlock
                            {
                                alert.title = "Incorrect Username or Password"
                                alert.message = "Try Again"
                                
                                self.presentViewController(alert, animated: true, completion: { })
                        }

                    return false
                }
            }) // ServerCom...
            
            while ServerCom.waiting() {}
        })) // add Action..."Submit"...
        
        self.presentViewController(alert, animated: true, completion: { })
    }

  struct generateIncorrectLoginAttempts
  {
    static var loginAttempts = 0
  }

  /* Sign in button. Will check with the database if the matching username and password
  *  are found. If they are then proceed to open the app. If not, then halt.
  */
  @IBAction func MyButton(sender: AnyObject)
  {
		/* Submits the server request */
    var MyParams = ["action":"login"]

    // Append possible search data to the parameters. Note: MyParams is changed to a var, instead of a let.
    if (USRTextField.text != nil) {
      MyParams["logid"] = USRTextField.text!
    }
    if (PWDTextField.text != nil) {
      MyParams["pwd"] = Crypto.encrypt(PWDTextField.text!)
    }

    ServerCom.send(MyParams, f: {(succ: Bool, retjson: JSON) in

      //print("{\"SelectSQL\":\"SELECT HEX(w.workid) as workid, HEX(w.custid) as custid, HEX(w.bikeid) as bikeid, w.username as userID, w.open as open, w.tune as tune, w.tagid as tagnum, w.createtime, o.notes as notes, b.brand as brand, b.model as model, b.color as color, c.fname, c.lname, c.address, c.address2, c.city, c.state, c.country, c.zip, c.phone, c.email FROM WorkOrderData as w JOIN WorkOrderNotes as o ON (o.workid = w.workid) JOIN BikeData as b ON (w.bikeid = b.bikeid) JOIN CustData as c ON (w.custid = c.custid) WHERE w.open='N' ORDER BY c.lname ASC ;\",\"return\":\"[{\"workid\":\"291A46CEEFB711E591F504012F020E01\",\"custid\":\"2919E28DEFB711E591F504012F020E01\",\"bikeid\":\"291A2C36EFB711E591F504012F020E01\",\"userID\":\"3\",\"open\":\"N\",\"tune\":\"Complete Overhaul: $199\",\"tagnum\":\"45\",\"createtime\":\"2016-03-21 18:49:25\",\"notes\":\"Adding some flames to this mo fo\",\"brand\":\"Schwin\",\"model\":\"Trike\",\"color\":\"Red\",\"fname\":\"HIqUxzShXCZToaDfJSz%2BHw==\",\"lname\":\"1hOzOcEH7gHYb3agfPPOeQ==\",\"address\":\"Lkup8bOMvR6kFpIy3GbDmaULTde%2FSsjUghFn4DA4%2B%2BU=\",\"address2\":\"NLLtc9KpxybEZZNm68%2FU9Q==\",\"city\":\"qGJ8KLyzQH9CN%2BhfMhtLcQ==\",\"state\":\"WA\",\"country\":\"USA\",\"zip\":\"fuDDyKSWZvlEzNf%2BWJOxXw==\",\"phone\":\"PYh5z820Jj6XZ9SceNamEQ==\",\"email\":\"NLLtc9KpxybEZZNm68%2FU9Q==\"},{\"workid\":\"027DBEA4EFB711E591F504012F020E01\",\"custid\":\"027D46B1EFB711E591F504012F020E01\",\"bikeid\":\"027DA225EFB711E591F504012F020E01\",\"userID\":\"3\",\"open\":\"N\",\"tune\":\"ATD: $120\",\"tagnum\":\"3\",\"createtime\":\"2016-03-21 18:48:20\",\"notes\":\"This is a bike or something\",\"brand\":\"Trek\",\"model\":\"Y560\",\"color\":\"Blue\",\"fname\":\"mMc0QBOsyGZikpIBCSan2Q==\",\"lname\":\"YgenyQFHl9DwTBLN4%2BtBUA==\",\"address\":\"1ur8GfFB0umaSvrFIlNPdt9G0s3UmSVFcVBB6EywS74=\",\"address2\":\"NLLtc9KpxybEZZNm68%2FU9Q==\",\"city\":\"9hgh1Xwtc99cQAhX%2F9sCZQ==\",\"state\":\"WA\",\"country\":\"USA\",\"zip\":\"zC3nmQRQBacQH02zScxNcA==\",\"phone\":\"4%2FdhslwiZBpciATTz06Ylw==\",\"email\":\"hPmnVG7cOEMWNfgD7l7COw==\"}]".stringByRemovingPercentEncoding)

      if succ
      {
        newOrderTextFieldStruct.welcomePopup = true

        if let adminRet = retjson[0]["admin"].string {
          newOrderTextFieldStruct.admin = adminRet == "Y"
        }

        generateIncorrectLoginAttempts.loginAttempts = 0
        newOrderTextFieldStruct.USRname = self.USRTextField.text!
        return true
      }
      else
      {
        generateIncorrectLoginAttempts.loginAttempts += 1
        if(generateIncorrectLoginAttempts.loginAttempts >= 5)
        {
          NSOperationQueue.mainQueue().addOperationWithBlock
          {
            let refreshAlert = UIAlertController(title: "Incorrect Username or Password, No remaining attempts left!", message: "Try Clicking \"Forgot Password\" Below", preferredStyle: UIAlertControllerStyle.Alert)
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in }))
            self.presentViewController(refreshAlert, animated: true, completion: nil)
          }
        }
        else
        {
          NSOperationQueue.mainQueue().addOperationWithBlock
          {
            let refreshAlert = UIAlertController(title: "Incorrect Username or Password", message: "Try Again", preferredStyle: UIAlertControllerStyle.Alert)
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in }))
            self.presentViewController(refreshAlert, animated: true, completion: nil)
          }
        }
      }
      return false
    })

    while ServerCom.waiting() {}

      // Leaving the login page
      newOrderTextFieldStruct.loginPage = !ServerCom.success()
    }
}
