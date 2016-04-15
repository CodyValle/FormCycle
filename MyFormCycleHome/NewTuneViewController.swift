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

class NewTuneViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate
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
    
    func textField(textField: UITextField,shouldChangeCharactersInRange range: NSRange, replacementString string: String)-> Bool
    {
        /* We ignore any change that doesn't add characters to the text field.
        * These changes are things like character deletions and cuts, as well
        * as moving the insertion point.
        *
        * We still return true to allow the change to take place.
        */
        if string.characters.count == 0 {
            return true
        }
        
        /* Check to see if the text field's contents still fit the constraints
        * with the new content added to it.
        * If the contents still fit the constraints, allow the change
        * by returning true; otherwise disallow the change by returning false.
        */
        let currentText = textField.text ?? ""
        let prospectiveText = (currentText as NSString).stringByReplacingCharactersInRange(range, withString: string)
        
        switch textField
        {
        case name:
            return prospectiveText.characters.count <= 65
        case serviceCost:
            return prospectiveText.containsOnlyCharactersIn("0123456789") && prospectiveText.characters.count <= 4
            
            /* Allow only digits in this field,and limit its contents to 7, 10, or 11 characters. */
        case serviceTime:
            return prospectiveText.containsOnlyCharactersIn("0123456789") && prospectiveText.characters.count <= 3
        case serviceTitle:
            return prospectiveText.characters.count <= 65
        case cost:
            return prospectiveText.containsOnlyCharactersIn("0123456789") && prospectiveText.characters.count <= 4
            
            /* Allow only digits in this field,and limit its contents to 7, 10, or 11 characters. */
        case time:
            return prospectiveText.containsOnlyCharactersIn("0123456789") && prospectiveText.characters.count <= 3
            
            
            
        default:
            return true

        }
    }
    
    /*+------------------------------ textFieldShouldReturn --------------------------------+
    | Checks which text box is currently in the view of the user. Then                    |
    | will either set the next appropiate text box that should be active                  |
    | or dismisses the keyboard if at the last text box.                                  |
    | Dismisses the keyboard when the user taps the "Return" key or its equivalent        |
    | while editing a text field.                                                         |
    | MARK: textFieldShouldReturn() Function                                              |
    +-------------------------------------------------------------------------------------+*/
    /* textFieldShouldReturn: controls the movement between text boxes. */
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        
        
        if (textField == name) {
            cost.becomeFirstResponder()
        }
        if (textField == cost) {
            time.becomeFirstResponder()
        }
        if (textField == time) {
            time.resignFirstResponder()
        }
        if (textField == serviceTitle) {
            serviceCost.becomeFirstResponder()
        }
        if (textField == serviceCost) {
            serviceTime.becomeFirstResponder()
        }
        if (textField == serviceTime) {
            serviceTime.resignFirstResponder()
        }
        return true
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        name.delegate = self
        name.clearButtonMode = .WhileEditing
        cost.delegate = self
        cost.keyboardType = UIKeyboardType.Alphabet
        cost.clearButtonMode = .WhileEditing
        time.delegate = self
        time.keyboardType = UIKeyboardType.Alphabet
        time.clearButtonMode = .WhileEditing
        serviceTitle.delegate = self
        serviceTitle.clearButtonMode = .WhileEditing
        serviceCost.delegate = self
        serviceCost.keyboardType = UIKeyboardType.Alphabet
        serviceCost.clearButtonMode = .WhileEditing
        serviceTime.delegate = self
        serviceTime.keyboardType = UIKeyboardType.Alphabet
        serviceTime.clearButtonMode = .WhileEditing
        
    }

    
    
  }
