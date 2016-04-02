//
//  EditUserViewController.swift
//  FormCycle
//
//  Created by Merrill Lines on 3/29/16.
//  Copyright © 2016 Merrill Lines. All rights reserved.
//

import UIKit
import SwiftHTTP
import SwiftyJSON

class EditUserViewController: UIViewController 
{
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var admin: UISegmentedControl!
    
    var useridPassed = ""
    
    @IBOutlet weak var signatureField: YPDrawSignatureView!
    @IBAction func backToEditRemoveTable(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil) /* dismisses the current view */
    }
    
    @IBAction func clearSignature(sender: AnyObject) {
        signatureField.clearSignature()
    }
    
    @IBAction func submitEditUserBtn(sender: AnyObject) {
        /* Submits the server request */
        var MyParams = ["action":"register"]
        
        // Append possible search data to the parameters. Note: MyParams is changed to a var, instead of a let.
        if (username.text != nil) {
            MyParams["logid"] = username.text!
        }
        if (password.text != nil) {
            MyParams["pwd"] = Crypto.encrypt(password.text!)
        }
        MyParams["admin"] = admin.selectedSegmentIndex == 1 ? "Y" : "N"
        
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
    override func viewDidLoad()
    {
        super.viewDidLoad()
        username.text = useridPassed
    }
    

}
    
