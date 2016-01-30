//
//  SignInPage.swift
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
    
    /* Will remain commented becuase it is not implemented yet */
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
              print("got an error: \(error)") /* if error, prints the error code saved on server */
            }

            // No errors
            if (response.text != nil)
            {
              if let datafromstring = response.text!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
              {
                let json = JSON(data: datafromstring)

                if (json["success"])
                {
                  next = true
                }
                else
                {
                  next = false
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
