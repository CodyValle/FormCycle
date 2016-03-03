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

  @IBAction func ForgotPWD(sender: AnyObject)
  {
    /* Submits the server request */
    var MyParams = ["action":"register"]

    // Append possible search data to the parameters. Note: MyParams is changed to a var, instead of a let.
    if (USRTextField.text != nil) {
      MyParams["logid"] = USRTextField.text!
    }
    if (PWDTextField.text != nil) {
      MyParams["pwd"] = PWDTextField.text!
    }

    ServerCom.send(MyParams, f: {(succ: Bool, retjson: JSON) in
      if succ
      {
        NSOperationQueue.mainQueue().addOperationWithBlock
        {
          let refreshAlert = UIAlertController(title: "Success", message: "Registered New User", preferredStyle: UIAlertControllerStyle.Alert)
          refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in }))
          self.presentViewController(refreshAlert, animated: true, completion: nil)
        }
        return true
      }
      else
      {
        NSOperationQueue.mainQueue().addOperationWithBlock
        {
          let refreshAlert = UIAlertController(title: "Failed to Registered New User", message: "Username Taken", preferredStyle: UIAlertControllerStyle.Alert)
          refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in }))
          self.presentViewController(refreshAlert, animated: true, completion: nil)
        }
      }
      return false
    })
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
      MyParams["pwd"] = PWDTextField.text!
    }

    ServerCom.send(MyParams, f: {(succ: Bool, retjson: JSON) in
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
