//
//  RegisterUserViewController.swift
//  FormCycle
//
//  Created by Merrill Lines on 3/16/16.
//  Copyright © 2016 Merrill Lines. All rights reserved.
//

import UIKit
import SwiftHTTP
import SwiftyJSON

class RegisterUserViewController: UIViewController
{
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var admin: UISegmentedControl!

    @IBAction func registerUser(sender: AnyObject) {
        /* Submits the server request */
        var MyParams = ["action":"register"]
        
        // Append possible search data to the parameters. Note: MyParams is changed to a var, instead of a let.
        if (userName.text != nil) {
            MyParams["logid"] = userName.text!
        }
        if (password.text != nil) {
            MyParams["pwd"] = Crypto.encrypt(password.text!)
        }
        
        ServerCom.send(MyParams, f: {(succ: Bool, retjson: JSON) in
            if succ //if request to server was successful
            {
                NSOperationQueue.mainQueue().addOperationWithBlock
                    {
                        let refreshAlert = UIAlertController(title: "Success", message: "Registered New User", preferredStyle: UIAlertControllerStyle.Alert)
                        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in }))
                        self.presentViewController(refreshAlert, animated: true, completion: nil)
                }
                return true
            }
            else //if request to server was unsuccessful
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
}