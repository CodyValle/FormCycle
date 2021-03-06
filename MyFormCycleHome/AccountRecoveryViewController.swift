//
//  AccountRecoveryViewController.swift
//  FormCycle
//
//  Created by Merrill Lines on 3/16/16.
//  Copyright © 2016 Merrill Lines. All rights reserved.
//

import UIKit
import SwiftHTTP
import SwiftyJSON 

class AccountRecoveryViewController: UIViewController
{
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    @IBAction func sendRecoveryRequest(sender: AnyObject) {
    
        /* Submits the server request */
        var MyParams = ["action":"updateLogin"]
        
        // Append possible search data to the parameters. Note: MyParams is changed to a var, instead of a let.
        if (userName.text != nil) {
            MyParams["logid"] = userName.text!
        }
        if (password.text != nil) {
            MyParams["pwd"] = Crypto.encrypt(password.text!)
        }

        
        ServerCom.send(MyParams, f: {(succ: Bool, retjson: JSON) in
            
                NSOperationQueue.mainQueue().addOperationWithBlock
                    {
                        let refreshAlert = UIAlertController(title: "Success", message: "Changed Password for User", preferredStyle: UIAlertControllerStyle.Alert)
                        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
                        
                        self.performSegueWithIdentifier("segueToLoginPage", sender: self)
                        }))
                        self.presentViewController(refreshAlert, animated: true, completion: nil)
                        
                }
                return true
            
        
        })
        
    }

}
