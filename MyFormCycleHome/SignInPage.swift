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
        newOrderTextFieldStruct.loginPage = false
        /*
        let params = ["action": USRTextField.text!, "pwd": PWDTextField.text!]
        do
        {
        let opt = try HTTP.POST("http://107.170.219.218/Capstone/delegate.php", parameters: params)
        opt.start
        {
        response in
        if let error = response.error
        {
        print("got an error: \(error)")
        return
        }
        print(response.text!)
        }
        }
        catch let error
        {
        print("got an error creating the request: \(error)")
        }*/
    }
}
