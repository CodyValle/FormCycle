//
//  ModifyTuneViewController.swift
//  FormCycle
//
//  Created by Merrill Lines on 4/4/16.
//  Copyright © 2016 Merrill Lines. All rights reserved.
//

import UIKit
import SwiftHTTP
import SwiftyJSON

class ModifyTuneViewController: UIViewController, UITextFieldDelegate
{
    @IBOutlet weak var tunename: UILabel!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var cost: UITextField!
    @IBOutlet weak var time: UITextField!
    
    var idPassed = 0
    var namePassed = ""
    var costPassed = 0
    var timePassed = Float()
    var myText = ""
    var tunePassed = ""
     
    
    @IBAction func backToEditTuneTablePage(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil) /* dismisses the current view */
    }
    
    /* Sends the request to the server to modify
     * an exisiting tune.
     */
    @IBAction func submitBtnEditTune(sender: AnyObject) {
        /* Submits the server request */
        var MyParams = ["action":"editTune"]
        MyParams["tune"] = tunePassed
        MyParams["tunename"] = namePassed
        MyParams["tunecost"] = String(costPassed)
        MyParams["tunetime"] = String(timePassed)
        if (name.text?.characters.count > 0) {
            MyParams["tunename"] = name.text
        }
        if (cost.text?.characters.count > 0) {
            MyParams["tunecost"] = cost.text
        }
        if (time.text?.characters.count > 0) {
            MyParams["tunetime"] = time.text
        }
        
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
                        let refreshAlert = UIAlertController(title: "Failed to Edit Tune", message: "Please Try Again", preferredStyle: UIAlertControllerStyle.Alert)
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
        tunename.text = namePassed
        name.delegate = self
        name.clearButtonMode = .WhileEditing
        cost.delegate = self
        cost.keyboardType = UIKeyboardType.Alphabet
        cost.clearButtonMode = .WhileEditing
        time.delegate = self
        time.keyboardType = UIKeyboardType.Alphabet
        time.clearButtonMode = .WhileEditing
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
        return true
    }

    
    
}