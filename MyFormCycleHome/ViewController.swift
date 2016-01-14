//
//  ViewController.swift
//  FormCycle
//
//  Created by FormCycle on 11/5/15.
//  Copyright © 2015 FormCycle. All rights reserved.
//


import UIKit
import SwiftHTTP
import SwiftyJSON

class ViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate
{
/*+------------------------------------ SIGN IN PAGE ------------------------------------+
  | This is the Login Page which will be implemented at a later date.                    |
  | Due to this, the section referred to as MARK: Login Page text and Server Request     |
  | will remain commented out until finally becoming implemented.                        |
	| MARK: Login Page text and Server Request                                             |
  +--------------------------------------------------------------------------------------+*/
  @IBOutlet weak var USRTextField: UITextField!
  @IBOutlet weak var PWDTextField: UITextField!
	
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
  {/*
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
  
/*+------------------------------------ NEW ORDER PAGE ------------------------------------+
  | New Order Page is the hub for a new order. This will collect all the customer info     |
  | and save those values to a global struct. This struct allows us to access the saved    |
  | values from this page on any other page in the app.                                    |
  | MARK: New Order Page Text and Server Request                                           |
  +----------------------------------------------------------------------------------------+*/
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
  
  /* newOrderTextFieldStruct is a struct made to store text in Text Fields for
  *  use when submitting the order on the Bike Info Page.
  *  Initially sets all values in struct to the empty
  *  string. */
  struct newOrderTextFieldStruct
  {
    static var firstName = ""
    static var lastName = ""
    static var myAddress = ""
    static var myAddress2 = ""
    static var myCity = ""
    static var myState = ""
    static var myZip = ""
    static var myPhone = ""
    static var myEmail = ""
    static var myBrand = ""
    static var myModel = ""
    static var myColor = ""
    static var myNotes = ""
    static var myTagNumber = ""
		static var neworderpage = false
		static var bikeInfoPage = false
		static var invoicePage = false
  }
  
	/* Sends the user back to the Home Page if currently on the Customer Information page. */
	@IBAction func backToHomePageBtn(sender: AnyObject)
	{
		newOrderTextFieldStruct.neworderpage = false /* sets current view to false */
		dismissViewControllerAnimated(true, completion: nil) /* dismisses the view controller */
	}
  /* New Order Page: Customer Information. This section denotes the variables
   * as well as the functions that pretain to the Customer Information Page.
   */
  //MARK: Variables and functions for Customer Information Page.
  @IBAction func submitCustInfo(sender: AnyObject)
  {
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
	
    @IBAction func RetrieveCustomerInfo(sender: AnyObject)
    {
        /* Submits the server request */
        var MyParams = ["action":"custSearch"]
        
        // Append possible search data to the parameters. Note: MyParams is changed to a var, instead of a let.
        /*if (DEBUG) {
            MyParams["DEBUG"] = "true"
        }*/
        if (fname.text != nil) {
            MyParams["fname"] = fname.text!
        }
        if (lname.text != nil) {
            MyParams["lname"] = lname.text!
        }
        if (address.text != nil) {
            MyParams["address"] = address.text!
        }
        if (address2.text != nil) {
            MyParams["address2"] = address2.text!
        }
        if (city.text != nil) {
            MyParams["city"] = city.text!
        }
        if (state.text != nil) {
            MyParams["state"] = state.text!
        }
        if (zip.text != nil) {
            MyParams["zip"] = zip.text!
        }
        if (phone.text != nil) {
            MyParams["phone"] = phone.text!
        }
        if (email.text != nil) {
            MyParams["email"] = email.text!
        }

        do
        {
            /* tries to submit to server */
            let opt = try HTTP.POST("http://107.170.219.218/Capstone/delegate.php", parameters: MyParams)
            opt.start
            {
                response in
                if let error = response.error
                {
                    print("got an error: \(error)") /* if error, prints the error code saved on server */
                    return
                }
                if (response.text != nil)
                {
                    if let datafromstring = response.text!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
                    {
                        let json = JSON(data: datafromstring)
                        
                        // Some helpful debug data for use when needing to place in table.
                        print("There are \(json.count) rows matching the supplied data.")
                        if (json.count > 0)
                        {
                            // Write all the data to the text fields. We first check to make sure the textfield does not already contain data and that the wanted value exists in the JSON string.
                            // The [0] is the index of the row that we want to auto fill with.
                            if (self.fname.text == "" && json[0]["fname"].isExists()) {
                                self.fname.text = json[0]["fname"].string
                            }
                            if (self.lname.text == "" && json[0]["lname"].isExists()) {
                                self.lname.text = json[0]["lname"].string
                            }
                            if (self.address.text == "" && json[0]["address"].isExists()) {
                                self.address.text = json[0]["address"].string
                            }
                            if (self.address2.text == "" && json[0]["address2"].isExists()) {
                                self.address2.text = json[0]["address2"].string
                            }
                            if (self.city.text == "" && json[0]["city"].isExists()) {
                                self.city.text = json[0]["city"].string
                            }
                            if (self.state.text == "" && json[0]["state"].isExists()) {
                                self.state.text = json[0]["state"].string
                            }
                            if (self.zip.text == "" && json[0]["zip"].isExists()) {
                                self.zip.text = json[0]["zip"].string
                            }
                            if (self.phone.text == "" && json[0]["phone"].isExists()) {
                                self.phone.text = json[0]["phone"].string
                            }
                            if (self.email.text == "" && json[0]["email"].isExists()) {
                                self.email.text = json[0]["email"].string
                            }
                        }
                    }
                }
            }
        }
        catch let error
        {
            print("got an error creating the request: \(error)")
        }
    }

/*+------------------------------------ BIKE INFO PAGE ------------------------------------+
  | Bike info page collects all revelant info pertaining to the bike itself. Here we       |
  | collect the Model, Brand, Color, Tag Number, and Notes about the bike.                 |
  | MARK: Variables and functions for Bike Information Page.                               |
  +----------------------------------------------------------------------------------------+*/
  /* New Order Page: Bike Information. This section denotes the variables
   * as well as the functions that pretain to the Bike Information Page.
   */
  @IBOutlet weak var brand: UITextField!
  @IBOutlet weak var model: UITextField!
  @IBOutlet weak var color: UITextField!
  @IBOutlet weak var notes: UITextView!
  @IBOutlet weak var tagNumber: UITextField!
	
  /* Made to set the text pre-populated in the text
   * boxes when the user pressed back on the
   * RepairInfo Page.
   */
  @IBAction func backToCustInfo(sender: AnyObject)
	{
    newOrderTextFieldStruct.bikeInfoPage = false /* sets current view to false */
    dismissViewControllerAnimated(true, completion: nil) /* dismisses the current view */
		newOrderTextFieldStruct.neworderpage = true /* sets the new order page view to true since
																									 user just pressed the "back" button */
  }

/*+-------------------------------- LOAD INVOICE PAGE ------------------------------------+
  | Load invoice page displays all recorded information collected through the customer    |
  | information page, and bike information page. This allows the tech to see if all info  |
  | was correctly collected.                                                              |
  | MARK: Variables and functions for Load Invoice Page.                                  |
  +---------------------------------------------------------------------------------------+*/
	/* Load Invoice Page. This section denotes the variables as well as the functions that
   * pertain to the Load Invoice Page. The goal for this page is to have the information
   * automatically load when the view is loaded to the page.
   * !!! STILL IN PROGRESS !!!
   */
	
	
	@IBOutlet weak var invNotes: UILabel!
	@IBOutlet weak var invTagNum: UILabel!
	@IBOutlet weak var makeModelColor: UILabel!
	@IBOutlet weak var invEmail: UILabel!
	@IBOutlet weak var invPhone: UILabel!
	@IBOutlet weak var CityStateZip: UILabel!
	@IBOutlet weak var address3: UILabel!
	@IBOutlet weak var address1: UILabel!
	@IBOutlet weak var Name: UILabel!
	/* Loads all values from struct into text fields on this page */
//	@IBAction func loadInvoice(sender: AnyObject)
//	{
//		Name.text = newOrderTextFieldStruct.firstName +  newOrderTextFieldStruct.lastName
//		address1.text = newOrderTextFieldStruct.myAddress
//		address3.text = newOrderTextFieldStruct.myAddress2
//		CityStateZip.text = newOrderTextFieldStruct.myCity + newOrderTextFieldStruct.myState + newOrderTextFieldStruct.myZip
//		invPhone.text = newOrderTextFieldStruct.myPhone
//		invEmail.text = newOrderTextFieldStruct.myEmail
//		makeModelColor.text = newOrderTextFieldStruct.myBrand + newOrderTextFieldStruct.myModel + "(" + newOrderTextFieldStruct.myColor + ")"
//		invTagNum.text = newOrderTextFieldStruct.myTagNumber
//		invNotes.text = newOrderTextFieldStruct.myNotes
//	}
	
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
		/* if user is on the new order page set flag to true */
		if newOrderTextFieldStruct.neworderpage == true
		{
				
			fname.delegate = self
			lname.delegate = self
			address.delegate = self
			address2.delegate = self
			city.delegate = self
			state.delegate = self
			state.keyboardType = UIKeyboardType.Alphabet
			zip.delegate = self
			zip.keyboardType = UIKeyboardType.NumberPad
			phone.delegate = self
			phone.keyboardType = UIKeyboardType.NumberPad
			email.delegate = self
		}
		/* else if user is on the bike info page, set this flag to true */
		else if newOrderTextFieldStruct.bikeInfoPage == true
		{
			brand.delegate = self
			model.delegate = self
			color.delegate = self
			tagNumber.delegate = self
			notes.delegate = self
		}
		else if newOrderTextFieldStruct.invoicePage == true
		{
			
				Name.text = newOrderTextFieldStruct.firstName + " " + newOrderTextFieldStruct.lastName
				address1.text = newOrderTextFieldStruct.myAddress
				address3.text = newOrderTextFieldStruct.myAddress2
			CityStateZip.text = newOrderTextFieldStruct.myCity + " " + newOrderTextFieldStruct.myState + " "+newOrderTextFieldStruct.myZip
				invPhone.text = newOrderTextFieldStruct.myPhone
				invEmail.text = newOrderTextFieldStruct.myEmail
				makeModelColor.text = newOrderTextFieldStruct.myBrand + " " + newOrderTextFieldStruct.myModel + "(" + newOrderTextFieldStruct.myColor + ")"
				invTagNum.text = newOrderTextFieldStruct.myTagNumber
				invNotes.text = newOrderTextFieldStruct.myNotes
			
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
  func textField(textField: UITextField,shouldChangeCharactersInRange range: NSRange,
		replacementString string: String)-> Bool
	{
		/* We ignore any change that doesn't add characters to the text field.
		 * These changes are things like character deletions and cuts, as well
		 * as moving the insertion point.
		 *
		 * We still return true to allow the change to take place.
     */
		if string.characters.count == 0
		{
			return true
		}
		/* if current view is on new order page do this: */
		if newOrderTextFieldStruct.neworderpage == true
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
				/* Allow only upper-case letters in this field, and must have only 2 characters. */
				case state:
					return prospectiveText.containsOnlyCharactersIn("ABCDEFGHIJKLMNOPQRSTUVWXYZ") &&
						prospectiveText.characters.count <= 2
			
				/* Allow only digits in this field,and limit its contents to 7, 10, or 11 characters. */
				case phone:
					return prospectiveText.containsOnlyCharactersIn("0123456789") &&
						prospectiveText.characters.count <= 10
			
				/* Allow only digits in this field, and must have only 5 characters. */
				case zip:
					return prospectiveText.containsOnlyCharactersIn("0123456789") &&
						prospectiveText.characters.count <= 5
				default:
					return true
			}
		}
		/* else if current view is on the bike info page do this: */
		else if newOrderTextFieldStruct.bikeInfoPage == true
		{
			let currentText = textField.text ?? ""
			let prospectiveText = (currentText as NSString).stringByReplacingCharactersInRange(range, withString: string)
			
			switch textField
			{
				/* Allow only upper-case letters in this field, and must have only 2 characters. */
				case tagNumber:
					return prospectiveText.containsOnlyCharactersIn("0123456789")
				default:
					return true
			}
		}
		else if newOrderTextFieldStruct.invoicePage != true
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
		if (textField == fname)
		{
			lname.becomeFirstResponder()
		}
		else if (textField == lname)
		{
			address.becomeFirstResponder()
		}
		else if (textField == address)
		{
			address2.becomeFirstResponder()
		}
		else if (textField == address2)
		{
			city.becomeFirstResponder()
		}
		else if (textField == city)
		{
			state.becomeFirstResponder()
		}
		else if (textField == state)
		{
			zip.becomeFirstResponder()
		}
		else if (textField == zip)
		{
			phone.becomeFirstResponder()
		}
		else if (textField == phone)
		{
			email.becomeFirstResponder()
		}
		else if (textField == email)
		{
			email.resignFirstResponder()
		}
		else if(textField == brand)
		{
			model.becomeFirstResponder()
		}
		else if(textField == model)
		{
			color.becomeFirstResponder()
		}
		else if(textField == color)
		{
			tagNumber.becomeFirstResponder()
		}
		else if(textField == tagNumber)
		{
			notes.becomeFirstResponder()
		}
		else if(textField == notes)
		{
			notes.resignFirstResponder()
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
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!)
	{
		newOrderTextFieldStruct.neworderpage = false /* set current page to nothing */
		newOrderTextFieldStruct.bikeInfoPage = false /* sets current page to nothing */
		newOrderTextFieldStruct.invoicePage = false /* sets current page to nothing */
		/* checks if the user pressed the "new order" button, if so then move to
		 * new order: customer information page.
		 */
		if segue.identifier == "moveToCustInfo"
		{
			newOrderTextFieldStruct.neworderpage = true /* on new order page, set flag to true. */
		}
		
		/* checks if the user pressed the submit button on the bike info page */
		else if segue.identifier == "moveToInvoice"
		{
			newOrderTextFieldStruct.invoicePage = true
			print("inside of segue identifier!\n")
			/* on invoice page, set flag to true. */
			newOrderTextFieldStruct.myBrand = brand.text!
			newOrderTextFieldStruct.myModel = model.text!
			newOrderTextFieldStruct.myColor = color.text!
			newOrderTextFieldStruct.myNotes = notes.text!
			newOrderTextFieldStruct.myTagNumber = tagNumber.text!
			
			/* Submits the server request */
			let MyParams = ["DEBUG":"true","action":"workOrder","fname":newOrderTextFieldStruct.firstName, "lname":newOrderTextFieldStruct.lastName, "address":newOrderTextFieldStruct.myAddress, "address2":newOrderTextFieldStruct.myAddress2, "city":newOrderTextFieldStruct.myCity, "state":newOrderTextFieldStruct.myState, "zip":newOrderTextFieldStruct.myZip, "phone":newOrderTextFieldStruct.myPhone, "email":newOrderTextFieldStruct.myEmail, "brand":newOrderTextFieldStruct.myBrand, "model":newOrderTextFieldStruct.myModel, "color":newOrderTextFieldStruct.myColor,
                "tagNum":newOrderTextFieldStruct.myTagNumber,
                "notes":newOrderTextFieldStruct.myNotes]
			do
			{
				/* tries to submit to server */
				let opt = try HTTP.POST("http://107.170.219.218/Capstone/delegate.php", parameters: MyParams)
				opt.start
				{
					response in
					if let error = response.error
					{
						print("got an error: \(error)") /* if error, prints the error code saved on server */
						return
						}
					if (response.text != nil)
					{
						print(response.text!)
					}
				}
			}
			catch let error
			{
				print("got an error creating the request: \(error)")
			}
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
		/* Checks to make sure that all Customer Info is filled out before moving onto next page. */
		if newOrderTextFieldStruct.neworderpage == true
		{
			if fname.text?.utf16.count == 0 /* constraint for first name, if empty then prompt user. */
			{
				let refreshAlert = UIAlertController(title: "Did Not Enter First Name", message: "Try Again", preferredStyle: UIAlertControllerStyle.Alert)
				
				refreshAlert.addAction(UIAlertAction(title: "Dismiss", style: .Default, handler: { (action: UIAlertAction!) in
				}))
				presentViewController(refreshAlert, animated: true, completion: nil)
				return false
			}
			else if lname.text?.utf16.count == 0 /* Checks last name restrictions */
			{
				let refreshAlert = UIAlertController(title: "Did Not Enter Last Name", message: "Try Again", preferredStyle: UIAlertControllerStyle.Alert)
				
				refreshAlert.addAction(UIAlertAction(title: "Dismiss", style: .Default, handler: { (action: UIAlertAction!) in
				}))
				presentViewController(refreshAlert, animated: true, completion: nil)
				return false
			}
			else if address.text?.utf16.count == 0 /* Checks address restrictions */
			{
				let refreshAlert = UIAlertController(title: "Did Not Enter Address", message: "Try Again", preferredStyle: UIAlertControllerStyle.Alert)
				
				refreshAlert.addAction(UIAlertAction(title: "Dismiss", style: .Default, handler: { (action: UIAlertAction!) in
				}))
				presentViewController(refreshAlert, animated: true, completion: nil)
				return false
			}
			else if city.text?.utf16.count == 0 /* Checks city restrictions */
			{
				let refreshAlert = UIAlertController(title: "Did Not Enter City", message: "Try Again", preferredStyle: UIAlertControllerStyle.Alert)
				
				refreshAlert.addAction(UIAlertAction(title: "Dismiss", style: .Default, handler: { (action: UIAlertAction!) in
				}))
				presentViewController(refreshAlert, animated: true, completion: nil)
				return false
			}
			else if state.text?.utf16.count < 2 /* Checks state restrictions */
			{
				let refreshAlert = UIAlertController(title: "Did Not Enter State", message: "Try Again", preferredStyle: UIAlertControllerStyle.Alert)
				
				refreshAlert.addAction(UIAlertAction(title: "Dismiss", style: .Default, handler: { (action: UIAlertAction!) in
				}))
				presentViewController(refreshAlert, animated: true, completion: nil)
				return false
			}
			else if zip.text?.utf16.count < 5 /* Checks zip restrictions */
			{
				let refreshAlert = UIAlertController(title: "Incorrect Number of Digits for ZIP", message: "ZIP requires 5 digits (e.g. XXXXX), Try Again", preferredStyle: UIAlertControllerStyle.Alert)
				
				refreshAlert.addAction(UIAlertAction(title: "Dismiss", style: .Default, handler: { (action: UIAlertAction!) in
				}))
				presentViewController(refreshAlert, animated: true, completion: nil)
				return false
			}
			else if phone.text?.utf16.count < 10 /* Checks phone number restrictions */
			{
				let refreshAlert = UIAlertController(title: "Incorrect Number of Digits for Phone Number", message: "Requires 10 digits (e.g. XXX-XXX-XXXX), Try Again", preferredStyle: UIAlertControllerStyle.Alert)
				
				refreshAlert.addAction(UIAlertAction(title: "Dismiss", style: .Default, handler: { (action: UIAlertAction!) in
				}))
				presentViewController(refreshAlert, animated: true, completion: nil)
				return false
			}
			else if phone.text?.utf16.count == 0 /* Checks phone restrictions */
			{
				let refreshAlert = UIAlertController(title: "Did Not Enter Phone Number", message: "Try Again", preferredStyle: UIAlertControllerStyle.Alert)
				
				refreshAlert.addAction(UIAlertAction(title: "Dismiss", style: .Default, handler: { (action: UIAlertAction!) in
				}))
				presentViewController(refreshAlert, animated: true, completion: nil)
				return false
			}
			/* Commented out for now. Email should be optional for now.
				//			else if email.text?.utf16.count == 0 //Checks email restrictions
				//			{
				//				let refreshAlert = UIAlertController(title: "Did Not Enter Email", message: "Try Again", preferredStyle: UIAlertControllerStyle.Alert)
				//
				//				refreshAlert.addAction(UIAlertAction(title: "Dismiss", style: .Default, handler: { (action: UIAlertAction!) in
				//				}))
				//				presentViewController(refreshAlert, animated: true, completion: nil)
				//				return false
				//			} 
			*/
			else
			{
				return true
			}
		}
		/* Check if currently on bike info page */
		else if newOrderTextFieldStruct.bikeInfoPage == true
		{
			if brand.text?.utf16.count == 0 /* Checks brand restrictions */
			{
				let refreshAlert = UIAlertController(title: "Did Not Enter Brand", message: "Try Again", preferredStyle: UIAlertControllerStyle.Alert)
				
				refreshAlert.addAction(UIAlertAction(title: "Dismiss", style: .Default, handler: { (action: UIAlertAction!) in
				}))
				presentViewController(refreshAlert, animated: true, completion: nil)
				return false
			}
			else if model.text?.utf16.count == 0 /* Checks model restrictions */
			{
				let refreshAlert = UIAlertController(title: "Did Not Enter Model", message: "Try Again", preferredStyle: UIAlertControllerStyle.Alert)
				
				refreshAlert.addAction(UIAlertAction(title: "Dismiss", style: .Default, handler: { (action: UIAlertAction!) in
				}))
				presentViewController(refreshAlert, animated: true, completion: nil)
				return false
			}
			else if color.text?.utf16.count == 0 /* Checks color restrictions */
			{
				let refreshAlert = UIAlertController(title: "Did Not Enter Color", message: "Try Again", preferredStyle: UIAlertControllerStyle.Alert)
				
				refreshAlert.addAction(UIAlertAction(title: "Dismiss", style: .Default, handler: { (action: UIAlertAction!) in
				}))
				presentViewController(refreshAlert, animated: true, completion: nil)
				return false
			}
			else if tagNumber.text?.utf16.count == 0 /* Checks tag number restrictions */
			{
				let refreshAlert = UIAlertController(title: "Did Not Enter Tag Number", message: "Try Again", preferredStyle: UIAlertControllerStyle.Alert)
				
				refreshAlert.addAction(UIAlertAction(title: "Dismiss", style: .Default, handler: { (action: UIAlertAction!) in
				}))
				presentViewController(refreshAlert, animated: true, completion: nil)
				return false
			}
			/* Could also be optional value for notes.
				//			else if notes.text?.utf16.count == 0
				//			{
				//				let refreshAlert = UIAlertController(title: "Did Not Enter Notes", message: "Try Again", preferredStyle: UIAlertControllerStyle.Alert)
				//
				//				refreshAlert.addAction(UIAlertAction(title: "Dismiss", style: .Default, handler: { (action: UIAlertAction!) in
				//				}))
				//				presentViewController(refreshAlert, animated: true, completion: nil)
				//				return false
				//			}
			*/
		}
		return true
	}
	
//********************* PRACTICE TEST FUNCTIONS *********************
    
    func somefuncReturnsTrue() -> Bool {
    return true
    }
    func funcDoesntExistsYet() {
 //   @IBOutlet weak int x = 25
    }
    
//*******************************************************************
    
}

