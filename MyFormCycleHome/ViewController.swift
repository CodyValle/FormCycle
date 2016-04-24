//
//  ViewController.swift
//  FormCycle
//
//  Created by FormCycle on 11/5/15.
//  Copyright © 2015 FormCycle Developers. All rights reserved.
//

import Foundation
import UIKit
import SwiftHTTP
import SwiftyJSON
import MessageUI

class ViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIPickerViewDelegate, MFMailComposeViewControllerDelegate, AutoFillTableViewControllerDelegate
{
    
    /* List all Text Fields imported from Sign In Page */
    @IBOutlet weak var USRTextField: UITextField!
    @IBOutlet weak var PWDTextField: UITextField!
    
    
    /* List all Text Fields imported from New Order Page */
    @IBOutlet weak var fname: UITextField!
    @IBOutlet weak var lname: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var address2: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var zip: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var email: UITextField!
    
    /* List all Text Fields imported from Bike Information Page */
    @IBOutlet weak var brand: UITextField!
    @IBOutlet weak var model: UITextField!
    @IBOutlet weak var color: UITextField!
    @IBOutlet weak var notes: UITextView!
    @IBOutlet weak var tagNumber: UITextField!
    @IBOutlet weak var pickerTuneSelection: UIPickerView!
    
    
    /* List all Text Fields imported from Load Invoice Page */
    @IBOutlet weak var invNotes: UITextView!
    @IBOutlet weak var invTagNum: UILabel!
    @IBOutlet weak var makeModelColor: UILabel!
    @IBOutlet weak var invEmail: UILabel!
    @IBOutlet weak var invPhone: UILabel!
    @IBOutlet weak var CityStateZip: UILabel!
    @IBOutlet weak var address3: UILabel!
    @IBOutlet weak var address1: UILabel!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var invTuneType: UILabel!
    @IBOutlet weak var currentDate: UILabel!
    
    //    @IBOutlet weak var custSig: YPDrawSignatureView!
    //    @IBOutlet weak var techSig: YPDrawSignatureView!
    
    // Weekly Glance Day Selectors
    @IBOutlet weak var Day0Button: UIButton?
    @IBOutlet weak var Day1Button: UIButton?
    @IBOutlet weak var Day2Button: UIButton?
    @IBOutlet weak var Day3Button: UIButton?
    @IBOutlet weak var Day4Button: UIButton?
    @IBOutlet weak var Day0Name: UILabel?
    @IBOutlet weak var Day1Name: UILabel?
    @IBOutlet weak var Day2Name: UILabel?
    @IBOutlet weak var Day3Name: UILabel?
    @IBOutlet weak var Day4Name: UILabel?
    @IBOutlet weak var Day0Hours: UILabel?
    @IBOutlet weak var Day1Hours: UILabel?
    @IBOutlet weak var Day2Hours: UILabel?
    @IBOutlet weak var Day3Hours: UILabel?
    @IBOutlet weak var Day4Hours: UILabel?
    
    func updateWeeklyGlanceData()
    {
        dispatch_async(dispatch_get_main_queue())
        {
            self.Day0Button?.backgroundColor = WGData.Day0Color
            self.Day1Button?.backgroundColor = WGData.Day1Color
            self.Day2Button?.backgroundColor = WGData.Day2Color
            self.Day3Button?.backgroundColor = WGData.Day3Color
            self.Day4Button?.backgroundColor = WGData.Day4Color
            
            self.Day0Name?.text = WGData.Day0Name
            self.Day1Name?.text = WGData.Day1Name
            self.Day2Name?.text = WGData.Day2Name
            self.Day3Name?.text = WGData.Day3Name
            self.Day4Name?.text = WGData.Day4Name
            
            self.Day0Hours?.text = WGData.Day0Hours
            self.Day1Hours?.text = WGData.Day1Hours
            self.Day2Hours?.text = WGData.Day2Hours
            self.Day3Hours?.text = WGData.Day3Hours
            self.Day4Hours?.text = WGData.Day4Hours
            
            if WeeklyGlance.getDaySelected() == 0
            {
                self.Day0Name?.textColor = UIColor(white: 1, alpha: 1)
                self.Day0Hours?.textColor = UIColor(white: 1, alpha: 1)
            }
            else
            {
                self.Day0Name?.textColor = UIColor(white: 0, alpha: 1)
                self.Day0Hours?.textColor = UIColor(white: 0, alpha: 1)
            }
            if WeeklyGlance.getDaySelected() == 1
            {
                self.Day1Name?.textColor = UIColor(white: 1, alpha: 1)
                self.Day1Hours?.textColor = UIColor(white: 1, alpha: 1)
            }
            else
            {
                self.Day1Name?.textColor = UIColor(white: 0, alpha: 1)
                self.Day1Hours?.textColor = UIColor(white: 0, alpha: 1)
            }
            if WeeklyGlance.getDaySelected() == 2
            {
                self.Day2Name?.textColor = UIColor(white: 1, alpha: 1)
                self.Day2Hours?.textColor = UIColor(white: 1, alpha: 1)
            }
            else
            {
                self.Day2Name?.textColor = UIColor(white: 0, alpha: 1)
                self.Day2Hours?.textColor = UIColor(white: 0, alpha: 1)
            }
            if WeeklyGlance.getDaySelected() == 3
            {
                self.Day3Name?.textColor = UIColor(white: 1, alpha: 1)
                self.Day3Hours?.textColor = UIColor(white: 1, alpha: 1)
            }
            else
            {
                self.Day3Name?.textColor = UIColor(white: 0, alpha: 1)
                self.Day3Hours?.textColor = UIColor(white: 0, alpha: 1)
            }
            if WeeklyGlance.getDaySelected() == 4
            {
                self.Day4Name?.textColor = UIColor(white: 1, alpha: 1)
                self.Day4Hours?.textColor = UIColor(white: 1, alpha: 1)
            }
            else
            {
                self.Day4Name?.textColor = UIColor(white: 0, alpha: 1)
                self.Day4Hours?.textColor = UIColor(white: 0, alpha: 1)
            }
        }
    }
    
    @IBAction func Day0Select(sender: AnyObject) {
        WeeklyGlance.setDaySelected(0)
    }
    
    @IBAction func Day1Select(sender: AnyObject) {
        WeeklyGlance.setDaySelected(1)
    }
    
    @IBAction func Day2Select(sender: AnyObject) {
        WeeklyGlance.setDaySelected(2)
    }
    
    @IBAction func Day3Select(sender: AnyObject) {
        WeeklyGlance.setDaySelected(3)
    }
    
    @IBAction func Day4Select(sender: AnyObject) {
        WeeklyGlance.setDaySelected(4)
    }
    
    @IBAction func moveToSearchPage(sender: AnyObject) {
        
        performSegueWithIdentifier("nextView", sender: self)
        
        defaults.setBool(false, forKey: "searchPressed")
        
    }
    
    @IBAction func backToTechEditPage(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil) /* dismisses the current view */
    }
    
    
    var customers = JSON(data:"".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!)
    var results = [CustomerAutoFill]()
    
    @IBAction func backToEditOrder(sender: AnyObject)
    {
        dismissViewControllerAnimated(true, completion: nil) /* dismisses the current view */
    }
    
    @IBAction func submitAddServices(sender: AnyObject)
    {
        dismissViewControllerAnimated(true, completion: nil) /* dismisses the current view */
    }
    
    /* ViewDidAppear() is a function that is overwritten here. This allows us to display
     *   an alert view while still on the same view controller. This is also confronting
     *   a problem that occured when trying to load more items in a single view controller
     */
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func viewDidAppear(animated: Bool)
    {
        self.updateWeeklyGlanceData()
        //super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateWeeklyGlanceData",name:"refreshWeeklyGlance", object: nil)
        if (newOrderTextFieldStruct.bikeInfoPage)
        {
            pickerTuneSelection.reloadAllComponents()
            //        dispatch_async(dispatch_get_main_queue()) {
            //            self.pickerTuneSelection.reloadAllComponents()
            //        }
            
        }
        if newOrderTextFieldStruct.mainPage
        {
            NSNotificationCenter.defaultCenter().postNotificationName("refreshWeeklyGlance", object: nil)
            
            if newOrderTextFieldStruct.welcomePopup
            {
                let myrefreshAlert = UIAlertController(title: "Welcome!", message:newOrderTextFieldStruct.USRname, preferredStyle: UIAlertControllerStyle.Alert)
                
                myrefreshAlert.addAction(UIAlertAction(title: "Dismiss", style: .Cancel, handler: { (action: UIAlertAction!) in }))
                presentViewController(myrefreshAlert, animated: false, completion: nil)
                
                newOrderTextFieldStruct.welcomePopup = false
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidLoad()
        
        if newOrderTextFieldStruct.invoicePage
        {
            self.invNotes.text = newOrderTextFieldStruct.myNotes
        }
    }
    
    /*+------------------------------- viewDidLoad() --------------------------------------+
     | viewDidLoad() is a function that is overwritten here. Here we modify the view to   |
     | display information on a current page. Because we have only implemented a single   |
     | view controller for this app we have to set flags for each page. This will allows  |
     | us to access the correct values from a current view.                               |
     | MARK: viewDidLoad () Function																											 |
     +------------------------------------------------------------------------------------+*/
    /* viewDidLoad. This function allows the view to be flagged based on the current
     * page that is loaded.
     */
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if newOrderTextFieldStruct.mainPage
        {
            generateListForTunes()
            //myListOfTunes = generateListForTunes()
            
            newOrderTextFieldStruct.loginPage = false
        }
            
        else if newOrderTextFieldStruct.addServicesPage
        {
            newOrderTextFieldStruct.mainPage = false
        }
        if newOrderTextFieldStruct.loginPage
        {
            //Looks for single or multiple taps.
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
            view.addGestureRecognizer(tap)
            newOrderTextFieldStruct.mainPage = false
            newOrderTextFieldStruct.neworderpage = false
            newOrderTextFieldStruct.bikeInfoPage = false
            newOrderTextFieldStruct.invoicePage = false
            USRTextField.delegate = self
            USRTextField.clearButtonMode = .WhileEditing
            PWDTextField.delegate = self
            PWDTextField.clearButtonMode = .WhileEditing
            
            // Open the connection to the database.
            ServerCom.open()
            // Load the tunes into the app
            Tune.populateTunes()
            
            // Set default defaults
            let defaults = NSUserDefaults.standardUserDefaults()
            if defaults.stringForKey("TodaysOrders") == nil {
                defaults.setValue("", forKey: "TodaysOrders")
            }
            if defaults.stringForKey("LockedDay") == nil {
                defaults.setValue("false", forKey: "LockedDay")
            }
            if defaults.stringForKey("LastLoaded") == nil {
                defaults.setValue("01-01-1900", forKey: "LastLoaded")
            }
            
            // Uncomment this code to make the BinPacker think that this is the first time the app was loaded today
            defaults.setValue("01-01-1900", forKey: "LastLoaded")
            
            defaults.synchronize()
            
        }
            /* if user is on the new order page set flag to true */
        else if newOrderTextFieldStruct.neworderpage
        {
            //Looks for single or multiple taps.
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
            view.addGestureRecognizer(tap)
            // Open the connection to the database.
            //ServerCom.open()
            // Load the tunes into the app
            //Tune.populateTunes()
            
            newOrderTextFieldStruct.mainPage = false
            newOrderTextFieldStruct.loginPage = false
            newOrderTextFieldStruct.bikeInfoPage = false
            newOrderTextFieldStruct.invoicePage = false
            fname.delegate = self
            fname.clearButtonMode = .WhileEditing
            lname.delegate = self
            lname.clearButtonMode = .WhileEditing
            address.delegate = self
            address.clearButtonMode = .WhileEditing
            address2.delegate = self
            address2.clearButtonMode = .WhileEditing
            city.delegate = self
            city.clearButtonMode = .WhileEditing
            state.delegate = self
            state.keyboardType = UIKeyboardType.Alphabet
            state.clearButtonMode = .WhileEditing
            zip.delegate = self
            zip.keyboardType = UIKeyboardType.NumberPad
            zip.clearButtonMode = .WhileEditing
            phone.delegate = self
            phone.keyboardType = UIKeyboardType.NumberPad
            phone.clearButtonMode = .WhileEditing
            email.delegate = self
            email.clearButtonMode = .WhileEditing
        }
            /* else if user is on the bike info page, set this flag to true */
        else if newOrderTextFieldStruct.bikeInfoPage == true
        {
            //Looks for single or multiple taps.
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
            view.addGestureRecognizer(tap)
            pickerTuneSelection.reloadAllComponents()
            //            dispatch_async(dispatch_get_main_queue()) {
            //            self.pickerTuneSelection.reloadAllComponents()
            //            }
            newOrderTextFieldStruct.neworderpage = false
            newOrderTextFieldStruct.loginPage = false
            newOrderTextFieldStruct.invoicePage = false
            brand.delegate = self
            brand.clearButtonMode = .WhileEditing
            model.delegate = self
            model.clearButtonMode = .WhileEditing
            color.delegate = self
            color.clearButtonMode = .WhileEditing
            tagNumber.delegate = self
            tagNumber.clearButtonMode = .WhileEditing
            notes.delegate = self
            brand.text = BikeAutoFillStruct.brand
            color.text = BikeAutoFillStruct.color
            model.text = BikeAutoFillStruct.model
            
            
        }
        else if newOrderTextFieldStruct.invoicePage == true
        {
            newOrderTextFieldStruct.neworderpage = false
            newOrderTextFieldStruct.bikeInfoPage = false
            newOrderTextFieldStruct.loginPage = false
            Name.text = newOrderTextFieldStruct.firstName + " " + newOrderTextFieldStruct.lastName
            address1.text = newOrderTextFieldStruct.myAddress
            address3.text = newOrderTextFieldStruct.myAddress2
            CityStateZip.text = newOrderTextFieldStruct.myCity + " " + newOrderTextFieldStruct.myState + " "+newOrderTextFieldStruct.myZip
            invPhone.text = newOrderTextFieldStruct.myPhone
            invEmail.text = newOrderTextFieldStruct.myEmail
            makeModelColor.text = newOrderTextFieldStruct.myBrand + " " + newOrderTextFieldStruct.myModel + "  (" + newOrderTextFieldStruct.myColor + ")"
            invTagNum.text = newOrderTextFieldStruct.myTagNumber
            invNotes.text = newOrderTextFieldStruct.myNotes
            var myString = ""
            var myStringArr:[String] = []
            myStringArr = newOrderTextFieldStruct.listOfServices[0].componentsSeparatedByString(",")
            for var i = 0; i < myStringArr.count ; i++
            {
                myStringArr[i] = Tune.ID(Int(myStringArr[i])!)!
                if( i == 0)
                {
                    myString = myString + myStringArr[i]
                }
                else
                {
                    myString = myString + ", " + myStringArr[i]
                }
            }
            
            invTuneType.text = myString
            currentDate.text = printTimestamp()
        }
    }
    
    /*+--------------------------------- textField() ---------------------------------------+
     | textField() is a function that checks the constraints on the current text. First it |
     | checks to see which page is loaded in the current view. Then it begins to allow the |
     | user to enter text. If the text being entered conflicts with a constraint it will   |
     | end the app from collecting that information. This checks for more global           |
     | constraints such as length not the specific characters being entered.               |
     | MARK: UITextFieldDelegate events and related methods                                |
     +-------------------------------------------------------------------------------------+*/
    /* textField(): Takes in the current text field as well as a string and returns a
     * boolean value.
     */
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
        
        /* if current view is on new order page do this: */
        if newOrderTextFieldStruct.neworderpage
        {
            /* Check to see if the text field's contents still fit the constraints
             * with the new content added to it.
             * If the contents still fit the constraints, allow the change
             * by returning true; otherwise disallow the change by returning false.
             */
            let currentText = textField.text ?? ""
            let prospectiveText = (currentText as NSString).stringByReplacingCharactersInRange(range, withString: string)
            
            switch textField
            {
            case fname: fallthrough
            case lname: fallthrough
            case email:
                return string.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).characters.count != 0
                
            case address: fallthrough
            case address2: fallthrough
            case city:
                if string.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).characters.count == 0
                {
                    if currentText.characters.count == 0 {
                        return false
                    }
                    else {
                        return currentText.characters.last != " "
                    }
                }
                
                /* Allow only upper-case letters in this field, and must have only 2 characters. */
            case state:
                return prospectiveText.containsOnlyCharactersIn("ABCDEFGHIJKLMNOPQRSTUVWXYZ") && prospectiveText.characters.count <= 2
                
                /* Allow only digits in this field,and limit its contents to 7, 10, or 11 characters. */
            case phone:
                return prospectiveText.containsOnlyCharactersIn("0123456789") && prospectiveText.characters.count <= 10
                
                /* Allow only digits in this field, and must have only 5 characters. */
            case zip:
                return prospectiveText.containsOnlyCharactersIn("0123456789") && prospectiveText.characters.count <= 5
                
            default:
                return true
            }
        }
            /* else if current view is on the bike info page do this: */
        else if newOrderTextFieldStruct.bikeInfoPage
        {
            let currentText = textField.text ?? ""
            let prospectiveText = (currentText as NSString).stringByReplacingCharactersInRange(range, withString: string)
            
            switch textField
            {
            case model: fallthrough
            case brand: fallthrough
            case color:
                if string.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).characters.count == 0
                {
                    if currentText.characters.count == 0 {
                        return false
                    }
                    else {
                        return currentText.characters.last != " "
                    }
                }
                
            case tagNumber:
                return prospectiveText.containsOnlyCharactersIn("0123456789")
                
            default:
                return true
            }
        }
        else if newOrderTextFieldStruct.invoicePage
        {
            myFirstNameDisplay.text = newOrderTextFieldStruct.firstName
        }
        
        return true
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
        if newOrderTextFieldStruct.loginPage == true
        {
            if (textField == USRTextField) {
                PWDTextField.becomeFirstResponder()
            }
            if (textField == PWDTextField) {
                PWDTextField.resignFirstResponder()
            }
        }
        else if newOrderTextFieldStruct.neworderpage
        {
            if (textField == fname) {
                lname.becomeFirstResponder()
            }
            else if (textField == lname) {
                address.becomeFirstResponder()
            }
            else if (textField == address) {
                address2.becomeFirstResponder()
            }
            else if (textField == address2) {
                city.becomeFirstResponder()
            }
            else if (textField == city) {
                state.becomeFirstResponder()
            }
            else if (textField == state) {
                zip.becomeFirstResponder()
            }
            else if (textField == zip) {
                phone.becomeFirstResponder()
            }
            else if (textField == phone) {
                email.becomeFirstResponder()
            }
            else if (textField == email) {
                email.resignFirstResponder()
            }
        }
        else if (newOrderTextFieldStruct.bikeInfoPage)
        {
            if(textField == brand) {
                model.becomeFirstResponder()
            }
            else if(textField == model) {
                color.becomeFirstResponder()
            }
            else if(textField == color) {
                tagNumber.becomeFirstResponder()
            }
            else if(textField == tagNumber) {
                notes.becomeFirstResponder()
            }
            else if(textField == notes) {
                notes.resignFirstResponder()
            }
        }
        
        return true
    }
    
    /*+-------------------------------- prepareForSegue() ----------------------------------+
     | Overrides the seque function which allows us to preload pages with                  |
     | with text before loading the page. This is the major action that allows this        |
     | program app to load the correct information based on the current page. If on the    |
     | correct page and values are entered correctly this will also submit the form        |
     | to the database.                                                                    |
     | MARK: prepareForSegue() Function                                                    |
     +-------------------------------------------------------------------------------------+*/
    /* prepareForSegue: if on correct page and info collected correctly, submits
     * the information from the app to the server via an http request.
     */
    /* text field for displaying first name */
    
    @IBOutlet weak var myFirstNameDisplay: UILabel!
    @IBOutlet weak var partsWaiting: UISegmentedControl!
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!)
    {
        newOrderTextFieldStruct.neworderpage = false /* set current page to nothing */
        newOrderTextFieldStruct.bikeInfoPage = false /* sets current page to nothing */
        newOrderTextFieldStruct.invoicePage = false /* sets current page to nothing */
        newOrderTextFieldStruct.loginPage = false
        /* checks if the user pressed the "new order" button, if so then move to
         * new order: customer information page.
         */
        if segue.identifier == "AddlServices"
        {
            newOrderTextFieldStruct.addServicesPage = true
        }
        else if segue.identifier == "moveToCustInfo"
        {
            newOrderTextFieldStruct.neworderpage = true /* on new order page, set flag to true. */
        }
        else if segue.identifier == "backToLoginPage"
        {
            newOrderTextFieldStruct.loginPage = true
        }
        else if segue.identifier == "fromInvoicetoMain"
        {
            AddServices.serviceName = []
        }
        else if segue.identifier == "toBikeInfo"
        {
            // pickerTuneSelection.reloadAllComponents()
        }
        else if segue.identifier == "autoFill"
        {
            
            if let destination = segue.destinationViewController as? AutoFillTableViewController
            {
                destination.preferredContentSize = CGSize(width: 450, height: 500)
                if (customers.count > 0) // Fill the form
                {
                    for var i = 0; i < customers.count; i++
                    {
                        if customers[i]["address2"] == nil {  //checking for null values on optional fields
                            customers[i]["address2"] = ""
                        }
                        if customers[i]["email"] == nil {
                            customers[i]["email"] = ""
                        }
                        self.results.append(CustomerAutoFill(fname:    Crypto.decrypt(customers[i]["fname"].string!),
                            lname:    Crypto.decrypt(customers[i]["lname"].string!),
                            address:  Crypto.decrypt(customers[i]["address"].string!),
                            address2: customers[i]["address2"].string == "" ? "" : Crypto.decrypt(customers[i]["address2"].string!),
                            city:     Crypto.decrypt(customers[i]["city"].string!),
                            state:    customers[i]["state"].string!,
                            phone:    Crypto.decrypt(customers[i]["phone"].string!),
                            zip:      Crypto.decrypt(customers[i]["zip"].string!),
                            email:    customers[i]["email"].string == "" ? "" : Crypto.decrypt(customers[i]["email"].string!),
                            model: customers[i]["model"].string!,
                            brand: customers[i]["brand"].string!,
                            color: customers[i]["color"].string!))  //filling the results array with all information from the customer array
                        /* Is this line needed? */ dispatch_async(dispatch_get_main_queue(), { () -> Void in })
                    }
                }
                destination.delegate = self
                destination.resultSet = results
                results.removeAll()
            }
            newOrderTextFieldStruct.neworderpage = true
        }
            
            /* checks if the user pressed the submit button on the bike info page */
        else if segue.identifier == "moveToInvoice"
        {
            newOrderTextFieldStruct.invoicePage = true
            /* on invoice page, set flag to true. */
            newOrderTextFieldStruct.myBrand = brand.text!
            newOrderTextFieldStruct.myModel = model.text!
            newOrderTextFieldStruct.myColor = color.text!
            newOrderTextFieldStruct.myNotes = notes.text!
            newOrderTextFieldStruct.myTagNumber = tagNumber.text!
            newOrderTextFieldStruct.waiting = partsWaiting.selectedSegmentIndex == 0 ? "N" : "Y"
            
            /* Submits the server request */
            var MyParams = ["action": "workOrder"]
            var myArray:[String] = AddServices.serviceName
            var newArray:[String] = [newOrderTextFieldStruct.tunePicker == "0" ? "1" : newOrderTextFieldStruct.tunePicker]
            var myString = ""
            for (var i = 0; i < myArray.count; i++)
            {
                newArray[0] = newArray[0] + "," + myArray[i]
            }
            newOrderTextFieldStruct.listOfServices = newArray
            
            MyParams["fname"] = Crypto.encrypt(newOrderTextFieldStruct.firstName)
            MyParams["lname"] = Crypto.encrypt(newOrderTextFieldStruct.lastName)
            MyParams["address"] = Crypto.encrypt(newOrderTextFieldStruct.myAddress)
            MyParams["address2"] = Crypto.encrypt(newOrderTextFieldStruct.myAddress2)
            MyParams["city"] = Crypto.encrypt(newOrderTextFieldStruct.myCity)
            MyParams["state"] = newOrderTextFieldStruct.myState
            MyParams["zip"] = Crypto.encrypt(newOrderTextFieldStruct.myZip)
            MyParams["phone"] = Crypto.encrypt(newOrderTextFieldStruct.myPhone)
            MyParams["email"] = Crypto.encrypt(newOrderTextFieldStruct.myEmail)
            MyParams["brand"] = newOrderTextFieldStruct.myBrand
            MyParams["model"] = newOrderTextFieldStruct.myModel
            MyParams["color"] = newOrderTextFieldStruct.myColor
            MyParams["tagNum"] = newOrderTextFieldStruct.myTagNumber
            MyParams["notes"] = newOrderTextFieldStruct.myNotes
            MyParams["tune"] = newArray[0]
            MyParams["userID"] = newOrderTextFieldStruct.USRname
            MyParams["waiting"] = newOrderTextFieldStruct.waiting
            
            ServerCom.send(MyParams, f: {(succ: Bool, retjson: JSON) in return succ})
            
            newOrderTextFieldStruct.custid = ""
            AddServices.serviceName = []
        }
            
            /* check if the user pressed the next button
             on the cust info page. */
        else if segue.identifier == "loadCustomerInfo"
        {
            newOrderTextFieldStruct.bikeInfoPage = true;
            newOrderTextFieldStruct.firstName = fname.text!
            newOrderTextFieldStruct.lastName = lname.text!
            newOrderTextFieldStruct.myAddress = address.text!
            newOrderTextFieldStruct.myAddress2 = address2.text!
            newOrderTextFieldStruct.myCity = city.text!
            newOrderTextFieldStruct.myState = state.text!
            newOrderTextFieldStruct.myZip = zip.text!
            newOrderTextFieldStruct.myPhone = phone.text!
            newOrderTextFieldStruct.myEmail = email.text!
        }
        else if segue.identifier == "moveToMainPageSegue"
        {
            newOrderTextFieldStruct.mainPage = true;
        }
    }
    
    /*+------------------------- shouldPerformSegueWithIdentifier ---------------------------+
     | This function controls the bulk requirements for each page that must be met before   |
     | moving to the next view/page. This allows us to set specific constraints for each    |
     | page. This is a continuation of prepareForSegue(). If the user tries to enter        |
     | incorrect info or does not fill out the required box they will be prompted with      |
     | an error message as well as not allowed to proceed until no errors remain.           |
     | MARK: shouldPerformSegueWithIdentifier																							 |
     +--------------------------------------------------------------------------------------+*/
    /* shouldPerformSegueWithIdentifier: This function controls the requirements for each
     * page that must be met before moving to the next view/page.
     */
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool
    {
        if (newOrderTextFieldStruct.loginPage) {
            return false
        }
        /* Checks to make sure that all Customer Info is filled out before moving onto next page. */
        if identifier == "loadCustomerInfo"
        {
            if fname.text?.utf16.count == 0 || fname.text == ""/* constraint for first name, if empty then prompt user. */
            {
                let refreshAlert = UIAlertController(title: "Did Not Enter First Name", message: "Try Again", preferredStyle: UIAlertControllerStyle.Alert)
                
                refreshAlert.addAction(UIAlertAction(title: "Dismiss", style: .Default, handler: { (action: UIAlertAction!) in }))
                presentViewController(refreshAlert, animated: true, completion: nil)
                
                return false
            }
            else if lname.text?.utf16.count == 0 /* Checks last name restrictions */
            {
                let refreshAlert = UIAlertController(title: "Did Not Enter Last Name", message: "Try Again", preferredStyle: UIAlertControllerStyle.Alert)
                
                refreshAlert.addAction(UIAlertAction(title: "Dismiss", style: .Default, handler: { (action: UIAlertAction!) in }))
                presentViewController(refreshAlert, animated: true, completion: nil)
                
                return false
            }
            else if address.text?.utf16.count == 0 /* Checks address restrictions */
            {
                let refreshAlert = UIAlertController(title: "Did Not Enter Address", message: "Try Again", preferredStyle: UIAlertControllerStyle.Alert)
                
                refreshAlert.addAction(UIAlertAction(title: "Dismiss", style: .Default, handler: { (action: UIAlertAction!) in }))
                presentViewController(refreshAlert, animated: true, completion: nil)
                
                return false
            }
            else if city.text?.utf16.count == 0 /* Checks city restrictions */
            {
                let refreshAlert = UIAlertController(title: "Did Not Enter City", message: "Try Again", preferredStyle: UIAlertControllerStyle.Alert)
                
                refreshAlert.addAction(UIAlertAction(title: "Dismiss", style: .Default, handler: { (action: UIAlertAction!) in }))
                presentViewController(refreshAlert, animated: true, completion: nil)
                
                return false
            }
            else if state.text?.utf16.count < 2 /* Checks state restrictions */
            {
                let refreshAlert = UIAlertController(title: "Did Not Enter State", message: "Try Again", preferredStyle: UIAlertControllerStyle.Alert)
                
                refreshAlert.addAction(UIAlertAction(title: "Dismiss", style: .Default, handler: { (action: UIAlertAction!) in }))
                presentViewController(refreshAlert, animated: true, completion: nil)
                
                return false
            }
            else if zip.text?.utf16.count < 5 /* Checks zip restrictions */
            {
                let refreshAlert = UIAlertController(title: "Incorrect Number of Digits for ZIP", message: "ZIP requires 5 digits (e.g. XXXXX), Try Again", preferredStyle: UIAlertControllerStyle.Alert)
                
                refreshAlert.addAction(UIAlertAction(title: "Dismiss", style: .Default, handler: { (action: UIAlertAction!) in }))
                presentViewController(refreshAlert, animated: true, completion: nil)
                
                return false
            }
            else if phone.text?.utf16.count < 10 /* Checks phone number restrictions */
            {
                let refreshAlert = UIAlertController(title: "Incorrect Number of Digits for Phone Number", message: "Requires 10 digits (e.g. XXX-XXX-XXXX), Try Again", preferredStyle: UIAlertControllerStyle.Alert)
                
                refreshAlert.addAction(UIAlertAction(title: "Dismiss", style: .Default, handler: { (action: UIAlertAction!) in }))
                presentViewController(refreshAlert, animated: true, completion: nil)
                
                return false
            }
            else if phone.text?.utf16.count == 0 /* Checks phone restrictions */
            {
                let refreshAlert = UIAlertController(title: "Did Not Enter Phone Number", message: "Try Again", preferredStyle: UIAlertControllerStyle.Alert)
                
                refreshAlert.addAction(UIAlertAction(title: "Dismiss", style: .Default, handler: { (action: UIAlertAction!) in }))
                presentViewController(refreshAlert, animated: true, completion: nil)
                
                return false
            }
            return true
        }
            /* Check if currently on bike info page */
        else if newOrderTextFieldStruct.bikeInfoPage
        {
            
            if brand.text?.utf16.count == 0 /* Checks brand restrictions */
            {
                let refreshAlert = UIAlertController(title: "Did Not Enter Brand", message: "Try Again", preferredStyle: UIAlertControllerStyle.Alert)
                
                refreshAlert.addAction(UIAlertAction(title: "Dismiss", style: .Default, handler: { (action: UIAlertAction!) in }))
                presentViewController(refreshAlert, animated: true, completion: nil)
                
                return false
            }
            else if model.text?.utf16.count == 0 /* Checks model restrictions */
            {
                let refreshAlert = UIAlertController(title: "Did Not Enter Model", message: "Try Again", preferredStyle: UIAlertControllerStyle.Alert)
                
                refreshAlert.addAction(UIAlertAction(title: "Dismiss", style: .Default, handler: { (action: UIAlertAction!) in }))
                presentViewController(refreshAlert, animated: true, completion: nil)
                
                return false
            }
            else if color.text?.utf16.count == 0 /* Checks color restrictions */
            {
                let refreshAlert = UIAlertController(title: "Did Not Enter Color", message: "Try Again", preferredStyle: UIAlertControllerStyle.Alert)
                
                refreshAlert.addAction(UIAlertAction(title: "Dismiss", style: .Default, handler: { (action: UIAlertAction!) in }))
                presentViewController(refreshAlert, animated: true, completion: nil)
                
                return false
            }
            else if tagNumber.text?.utf16.count == 0 /* Checks tag number restrictions */
            {
                let refreshAlert = UIAlertController(title: "Did Not Enter Tag Number", message: "Try Again", preferredStyle: UIAlertControllerStyle.Alert)
                
                refreshAlert.addAction(UIAlertAction(title: "Dismiss", style: .Default, handler: { (action: UIAlertAction!) in }))
                presentViewController(refreshAlert, animated: true, completion: nil)
                
                return false
            }
        }
        
        return true
    }
    
    var tField: UITextField!
    var pField: UITextField!
    
    /* Storing the username from the alertview text field */
    func configurationTextField(textField: UITextField!)
    {
        textField.placeholder = "Username"
        tField = textField
    }
    
    /* Storing the password from the alertview text field */
    func passwordTextField(textField: UITextField!)
    {
        textField.placeholder = "Password"
        textField.secureTextEntry = true
        pField = textField
    }
    
    /* Runs this function when the alertview  handles the cancel button */
    func handleCancel(alertView: UIAlertAction!)
    {
        /* Do nothing but cancel the alert view */
    }
    
    /* Admin login button to transition to admin page */
    @IBAction func adminButton(sender: AnyObject)
    {
        let alert = UIAlertController(title: "Admin Login", message: "Enter Username and Password", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addTextFieldWithConfigurationHandler(configurationTextField)
        alert.addTextFieldWithConfigurationHandler(passwordTextField)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: handleCancel))
        alert.addAction(UIAlertAction(title: "Submit", style: UIAlertActionStyle.Default, handler:{(UIAlertAction) in
            /* Submits the server request */
            var MyParams = ["action":"login"]
            
            // Append possible search data to the parameters.
            if (self.tField.text != nil) {
                MyParams["logid"] = self.tField.text
            }
            if (self.pField.text != nil) {
                MyParams["pwd"] = Crypto.encrypt(self.pField.text!)
            }
            
            ServerCom.send(MyParams, f: {(succ: Bool, retjson: JSON) in
                if (succ)
                {
                    if let retjson = retjson[0]["admin"].string {
                        
                        if retjson == "Y" {
                            generateIncorrectLoginAttempts.loginAttempts = 0
                            newOrderTextFieldStruct.USRname = self.tField.text!
                            self.performSegueWithIdentifier("segueToAdminPage", sender: self)
                            return true
                        }
                    }
                    NSOperationQueue.mainQueue().addOperationWithBlock
                        {
                            /* Displays this error message if the user exists but does not
                             * have admin access
                             */
                            alert.title = "This username does not have admin access"
                            alert.message = "Contact an admin"
                            
                            self.presentViewController(alert, animated: true, completion: { })
                    }
                    return false
                }
                else
                {
                    NSOperationQueue.mainQueue().addOperationWithBlock
                        {
                            /* Displays this error message if the user does not exist or an
                             * incorrect password is entered.
                             */
                            alert.title = "Incorrect Username or Password"
                            alert.message = "Try Again"
                            
                            self.presentViewController(alert, animated: true, completion: { })
                    }
                    return false
                }
            }) // ServerCom...
            
            while ServerCom.waiting() {}
        })) // add Action..."Submit"...
        
        self.presentViewController(alert, animated: true, completion: { })
    }
    
    //*************************** Tune Selection Picker *************************//
    /* creates picker for tune type and sets the number of selections to the length of the tuneType array */
    func generateListForTunes()
    {
        var editTune = [EditTune]()
        var myTunes: [String] = []
        //Get and display all users
        var getTunes = ["action":"retrieveTunes"]
        getTunes["tunetype"] = "1"
        ServerCom.send(getTunes, f: {(succ: Bool, retjson: JSON) in
            if succ {
                for (var i = 0; i < retjson.count; i++) {
                    editTune.append(EditTune(name: retjson[i]["name"].string!,
                        cost: Int(retjson[i]["cost"].string!)!,
                        id: Int(retjson[i]["tune"].string!)!,
                        time: retjson[i]["time"].string!.floatValue,
                        tune: retjson[i]["tune"].string!))
                    
                    myTunes.append(retjson[i]["name"].string!)
                }
                newOrderTextFieldStruct.myListOfTunes = myTunes
                //return myTunes
            }
                
            else {
                print("Failed to retrieve tunes.")
            }
            return succ
        })
        //return myTunes
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return newOrderTextFieldStruct.myListOfTunes.count
    }
    
    /* sets the number of columns in the picker to one */
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    /* pikcerView sets the text for each tune type in the selection picker and then sets the
     text color to white so it can be more easily displayed on the interface. */
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString?
    {
        //let myServices = Tune.getServices()
        //pickerTuneSelection.reloadAllComponents()
        let attributedString = NSAttributedString(string: newOrderTextFieldStruct.myListOfTunes[row], attributes: [NSForegroundColorAttributeName : UIColor.whiteColor()])
        return attributedString
    }
    
    /*
     takes the selection from the picker and sends it to the newOrderTectFieldStrunct so it can be displayed on the
     invoice page.
     */
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        pickerTuneSelection.reloadAllComponents()
        newOrderTextFieldStruct.tunePicker = String(Tune.getTunefromName(newOrderTextFieldStruct.myListOfTunes[row])!.sID)
        newOrderTextFieldStruct.tuneName = newOrderTextFieldStruct.myListOfTunes[row]
    }
    
    //********************* PRACTICE TEST FUNCTIONS *********************
    
    func somefuncReturnsTrue() -> Bool
    {
        return true
    }
    
    func funcDoesntExistsYet()
    {
        //@IBOutlet weak int x = 25
    }
    
    //*******************************************************************
}

