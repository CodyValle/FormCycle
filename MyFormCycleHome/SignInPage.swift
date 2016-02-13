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
    @IBAction func myLogoWebpageLink(sender: AnyObject) {
       if let url = NSURL(string: "http://www.thisbikelife.com") {
            UIApplication.sharedApplication().openURL(url)
       }
    }

  @IBAction func ForgotPWD(sender: AnyObject) {
    /* Submits the server request */
    var MyParams = ["action":"register"]

    // Append possible search data to the parameters. Note: MyParams is changed to a var, instead of a let.
    if (USRTextField.text != nil) {
      MyParams["logid"] = USRTextField.text!
    }
    if (PWDTextField.text != nil) {
      MyParams["pwd"] = PWDTextField.text!
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

          // No errors
          if (response.text != nil)
          {
            if let datafromstring = response.text!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
            {
              let json = JSON(data: datafromstring)

              if (json["success"])
              {
                print("Successfully registered new user")
                NSOperationQueue.mainQueue().addOperationWithBlock {
                   
                let refreshAlert = UIAlertController(title: "Success", message: "Registered New User", preferredStyle: UIAlertControllerStyle.Alert)
                
                refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
                }))
                self.presentViewController(refreshAlert, animated: true, completion: nil)
              }
              }
              else
              {
                print("Failed to register new user")
                NSOperationQueue.mainQueue().addOperationWithBlock {
                    
                    let refreshAlert = UIAlertController(title: "Failed to Registered New User", message: "Username Taken", preferredStyle: UIAlertControllerStyle.Alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
                    }))
                    self.presentViewController(refreshAlert, animated: true, completion: nil)
                
                }
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
    
    struct generateIncorrectLoginAttempts
    {
        static var loginAttempts = 0
    }
    
    /* Sign in button. Will check with the database if the matching username and password
    *  are found. If they are then proceed to open the app. If not, then halt.
    */
    @IBAction func MyButton(sender: AnyObject)
    {
      var wait = true
      var next = false

      /* Submits the server request */
      var MyParams = ["action":"login"]

      // Append possible search data to the parameters. Note: MyParams is changed to a var, instead of a let.
      if (USRTextField.text != nil) {
        MyParams["logid"] = USRTextField.text!
      }
      if (PWDTextField.text != nil) {
        MyParams["pwd"] = PWDTextField.text!
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
            print("\ngot an error: \(error)\n") /* if error, prints the error code saved on server */
          }

          // No errors
          if (response.text != nil)
          {
            print(response.text!)
            if let datafromstring = response.text!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
            {
              let json = JSON(data: datafromstring)

              if (json["success"])
              {
                let retString = json["return"].string!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
                let retJSON = JSON(data: retString!)
                  //if adminJSON.isExists()
                //{
                  if let adminRet = retJSON[0]["admin"].string {
                    newOrderTextFieldStruct.admin = adminRet == "Y"
                  }
                //}

                next = true
                generateIncorrectLoginAttempts.loginAttempts = 0
                newOrderTextFieldStruct.USRname = self.USRTextField.text!
              }
              else
              {
                next = false
                generateIncorrectLoginAttempts.loginAttempts += 1
                if(generateIncorrectLoginAttempts.loginAttempts >= 5)
                {
                    NSOperationQueue.mainQueue().addOperationWithBlock {
                        
                        let refreshAlert = UIAlertController(title: "Incorrect Username or Password, No remaining attempts left!", message: "Try Clicking \"Forgot Password\" Below", preferredStyle: UIAlertControllerStyle.Alert)
                        
                        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
                        }))
                        self.presentViewController(refreshAlert, animated: true, completion: nil)
                    }
                    
                }
                else
                {
                NSOperationQueue.mainQueue().addOperationWithBlock {
                    
                    let refreshAlert = UIAlertController(title: "Incorrect Username or Password", message: "Try Again", preferredStyle: UIAlertControllerStyle.Alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
                    }))
                    self.presentViewController(refreshAlert, animated: true, completion: nil)
                    
                }
                }
              }
            }
          }
          wait = false;
        }
      }
      catch let error
      {
        print("got an error creating the request: \(error)")
      }
      while (wait) {}
      
      // Leaving the login page
      newOrderTextFieldStruct.loginPage = !next
    }
}
