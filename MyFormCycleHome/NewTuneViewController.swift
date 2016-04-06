//
//  NewTuneViewController.swift
//  FormCycle
//
//  Created by Merrill Lines on 4/4/16.
//  Copyright © 2016 Merrill Lines. All rights reserved.
//

import UIKit
import SwiftHTTP
import SwiftyJSON

class NewTuneViewController: UIViewController
{
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var cost: UITextField!
    @IBOutlet weak var time: UITextField!
    
    @IBAction func submitNewTuneBtn(sender: AnyObject) {
        /* Submits the server request */
        var MyParams = ["action":"addTune"]
        MyParams["tunetype"] = "1"
        MyParams["tune"] = String(Tune.numberOfTunes())
        //MyParams["tune"] = String(idPassed)
        // Append possible search data to the parameters. Note: MyParams is changed to a var, instead of a let.
        if (name.text?.characters.count > 0) {
            MyParams["tunename"] = name.text
        }
        if (cost.text?.characters.count > 0) {
            MyParams["tunecost"] = cost.text
        }
        if (time.text?.characters.count > 0) {
            MyParams["tunetime"] = time.text
        }
        
        //        MyParams["admin"] = admin.selectedSegmentIndex == 1 ? "Y" : "N"
        
        ServerCom.send(MyParams, f: {(succ: Bool, retjson: JSON) in
            if succ //if request to server was successful
            {
                //print("\n\nSuccess\n\n")
                self.dismissViewControllerAnimated(true, completion: nil) /* dismisses the current view */
                return true
                
            }
                
            else //if request to server was unsuccessful
            {
                NSOperationQueue.mainQueue().addOperationWithBlock
                    {
                        let refreshAlert = UIAlertController(title: "Failed to Creat New Tune", message: "Please Try Again", preferredStyle: UIAlertControllerStyle.Alert)
                        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in }))
                        self.presentViewController(refreshAlert, animated: true, completion: nil)
                }
            }
            return false
        })

        
        
    }
}
