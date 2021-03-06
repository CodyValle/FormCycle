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
    var editUser = [EditUser]()
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var admin: UISegmentedControl!
    
    var useridPassed = ""
    var adminPassed = ""
    
    @IBAction func backToEditRemoveTable(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil) /* dismisses the current view */
        
    }
    
    
    @IBAction func submitEditUserBtn(sender: AnyObject) {
        /* Submits the server request */
        var MyParams = ["action":"updateLogin"]
        
        // Append possible search data to the parameters. Note: MyParams is changed to a var, instead of a let.
        if (username.text != nil) {
            MyParams["logid"] = username.text!
        }
        //if (password.text != nil) {
        if (password.text?.characters.count > 0) {
            MyParams["pwd"] = Crypto.encrypt(password.text!)
        }
        MyParams["admin"] = admin.selectedSegmentIndex == 1 ? "Y" : "N"
        
        ServerCom.send(MyParams, f: {(succ: Bool, retjson: JSON) in
            if succ //if request to server was successful
            {
                self.dismissViewControllerAnimated(true, completion: nil) /* dismisses the current view */
                return true
                
            }
             
            else //if request to server was unsuccessful
            {
                NSOperationQueue.mainQueue().addOperationWithBlock
                    {
                        let refreshAlert = UIAlertController(title: "Failed to Edit User", message: "Please Try Again", preferredStyle: UIAlertControllerStyle.Alert)
                        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in }))
                        self.presentViewController(refreshAlert, animated: true, completion: nil)
                }
            }
            return false
        })
        
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        username.text = useridPassed
        
        if adminPassed == "Y"
        {
            admin.selectedSegmentIndex = 1
        }
        else if adminPassed == "N"
        {
            admin.selectedSegmentIndex = 0
        }
    }
    

}
    
