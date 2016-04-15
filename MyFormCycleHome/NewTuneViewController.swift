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

class NewTuneViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate
{
    /** CREATE TUNE: **/
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var cost: UITextField!
    @IBOutlet weak var time: UITextField!
    
    
    /** CREATE SERVICE **/

    @IBOutlet weak var serviceTitle: UITextField!
    @IBOutlet weak var serviceCost: UITextField!
    @IBOutlet weak var serviceTime: UITextField!
    
    struct servtype {
        static var typetransfer = 0
    }
    
     let serviceType: [String] =
     [ "Brakes", "Wheels", "Stem, Bars, & Headset", "Derailleurs & Shifters", "Chain & Cranks", "Computer", "Boxing", "Misc"];
     
     func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString?
     {
     let attributedString = NSAttributedString(string: serviceType[row], attributes: [NSForegroundColorAttributeName : UIColor.whiteColor()])
     return attributedString
     }
     
     func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
     return 1
     }
     
     func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component:Int) -> Int {
     return serviceType.count
     }
     
     func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
     return serviceType[row]
     }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            servtype.typetransfer = row + 2
        //print(row)
        //print(servtype.typetransfer)
    }
    /** SUBMIT INFOR TO SERVER **/
    
    @IBAction func submitNewTuneBtn(sender: AnyObject) {
        /* Submits the server request */
        var MyParams = ["action":"addTune"]
        
        //MyParams["tune"] = String(Tune.numberOfTunes())
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
        MyParams["tunetype"] = "1"
        
        
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
   
    @IBAction func submitService(sender: AnyObject) {
        
        var MyParams = ["action":"addTune"]
        if (serviceTitle.text?.characters.count > 0) {
            MyParams["tunename"] = serviceTitle.text
        }
        if (serviceCost.text?.characters.count > 0) {
            MyParams["tunecost"] = serviceCost.text
        }
        if (serviceTime.text?.characters.count > 0) {
            MyParams["tunetime"] = serviceTime.text
        }
        
        MyParams["tunetype"] = String(servtype.typetransfer)
        
        ServerCom.send(MyParams, f: {(succ: Bool, retjson: JSON) in
            if succ //if request to server was successful
            {
                //print("\n\nSuccess\n\n")
                self.dismissViewControllerAnimated(true, completion: nil) /* dismisses the current view */
                return true
                
            }
                
            else //if request to server was unsuccessful
            {
               /* NSOperationQueue.mainQueue().addOperationWithBlock
                    {
                        let refreshAlert = UIAlertController(title: "Failed to Creat New Tune", message: "Please Try Again", preferredStyle: UIAlertControllerStyle.Alert)
                        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in }))
                        self.presentViewController(refreshAlert, animated: true, completion: nil)
                } */
            }
            return false
        })
        


    }
    
  }
