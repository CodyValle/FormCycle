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

class ViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIPickerViewDelegate, MFMailComposeViewControllerDelegate
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
    @IBOutlet weak var invNotes: UILabel!
    @IBOutlet weak var invTagNum: UILabel!
    @IBOutlet weak var makeModelColor: UILabel!
    @IBOutlet weak var invEmail: UILabel!
    @IBOutlet weak var invPhone: UILabel!
    @IBOutlet weak var CityStateZip: UILabel!
    @IBOutlet weak var address3: UILabel!
    @IBOutlet weak var address1: UILabel!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var invTuneType: UILabel!

	
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
		/* if user is on the Login page set flag to true */
        if newOrderTextFieldStruct.loginPage == true
        {
            newOrderTextFieldStruct.neworderpage = false
            newOrderTextFieldStruct.bikeInfoPage = false
            newOrderTextFieldStruct.invoicePage = false
            USRTextField.delegate = self
            USRTextField.clearButtonMode = .WhileEditing
            PWDTextField.delegate = self
            PWDTextField.clearButtonMode = .WhileEditing
        }
        /* if user is on the new order page set flag to true */
		else if newOrderTextFieldStruct.neworderpage == true
		{
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

      if newOrderTextFieldStruct.custid != ""
      {
        /* Submits the server request */
        var MyParams = ["action":"bikeSearch"]

        // Append possible search data to the parameters. Note: MyParams is changed to a var, instead of a let.
        MyParams["custid"] = newOrderTextFieldStruct.custid

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

            // No errors 
            if (response.text != nil)
            {
              //print("Response string: \(response.text!)\n\n\n")
              if let datafromstring = response.text!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
              {
                let json = JSON(data: datafromstring)

                if (json["success"])
                {
                  // Probably needs more error checks.
                  let retString = json["return"].string!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
                  let bikes = JSON(data: retString!)

                  if (bikes.count > 0) // Fill the form
                  {
                    // UI updates should not occur on a non-main thread. So call it on the main thread.
                    dispatch_async(dispatch_get_main_queue())
                    {
                      // Write all the data to the text fields. We first check to make sure the textfield does not already contain data and that the wanted value exists in the JSON string.
                      // The [0] is the index of the row that we want to auto fill with.
                      if (bikes[0]["brand"].isExists()) {
                        self.brand.text = bikes[0]["brand"].string!
                      }
                      if (bikes[0]["model"].isExists()) {
                        self.model.text = bikes[0]["model"].string!
                      }
                      if (bikes[0]["color"].isExists()) {
                        self.color.text = bikes[0]["color"].string!
                      }
                      newOrderTextFieldStruct.bikeid = bikes[0]["bikeid"].string!
                    } // dispatch_async
                  } // if (bikes.count > 0)
                } // if (json["success"])
              } //if let datastring = ...
            } // if (response.text != null)
          } // opt.start
        } // do
        catch let error
        {
          print("got an error creating the request: \(error)")
        } // catch
      }
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
			invTuneType.text = newOrderTextFieldStruct.tunePicker
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
        case fname: fallthrough
        case lname: fallthrough
        case email:
          return string.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).characters.count != 0

        case address: fallthrough
        case address2: fallthrough
        case city:
          if string.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).characters.count == 0
          {
            if currentText.characters.count == 0
            {
              return false
            }
            else
            {
              return currentText.characters.last != " "
            }
          }

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
      case model: fallthrough
      case brand: fallthrough
      case color:
        if string.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).characters.count == 0
        {
          if currentText.characters.count == 0
          {
            return false
          }
          else
          {
            return currentText.characters.last != " "
          }
        }
				/* Allow only upper-case letters in this field, and must have only 2 characters. */
				case tagNumber:
					return prospectiveText.containsOnlyCharactersIn("0123456789")
				default:
					return true
			}
		}
		else if newOrderTextFieldStruct.invoicePage == true
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
            if (textField == USRTextField)
            {
                PWDTextField.becomeFirstResponder()
            }
            if (textField == PWDTextField)
            {
                PWDTextField.resignFirstResponder()
            }
        }
        else if newOrderTextFieldStruct.neworderpage == true
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
        }
        else if (newOrderTextFieldStruct.bikeInfoPage == true)
        {
            if(textField == brand)
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
        newOrderTextFieldStruct.loginPage = false
		/* checks if the user pressed the "new order" button, if so then move to
		 * new order: customer information page.
		 */
		if segue.identifier == "moveToCustInfo"
		{
			newOrderTextFieldStruct.neworderpage = true /* on new order page, set flag to true. */
		}
		else if segue.identifier == "backToLoginPage"
        {
            newOrderTextFieldStruct.loginPage = true
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
            
			/* Submits the server request */
			let MyParams = ["DEBUG":"true","action":"workOrder","fname":newOrderTextFieldStruct.firstName, "lname":newOrderTextFieldStruct.lastName, "address":newOrderTextFieldStruct.myAddress, "address2":newOrderTextFieldStruct.myAddress2, "city":newOrderTextFieldStruct.myCity, "state":newOrderTextFieldStruct.myState, "zip":newOrderTextFieldStruct.myZip, "phone":newOrderTextFieldStruct.myPhone, "email":newOrderTextFieldStruct.myEmail, "brand":newOrderTextFieldStruct.myBrand, "model":newOrderTextFieldStruct.myModel, "color":newOrderTextFieldStruct.myColor,
                "tagNum":newOrderTextFieldStruct.myTagNumber,
                "notes":newOrderTextFieldStruct.myNotes,
                "tune":newOrderTextFieldStruct.tunePicker]
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
        if (newOrderTextFieldStruct.loginPage == true)
        {
          return false
        }
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
	//*************************** Tune Selection Picker *************************//
    var tuneType = ["Basic Tune: $70","ATD: $120","Complete Overhaul: $199","Race & Event Prep: $50","Find the Creak Service: $50-$95","Front Suspension Service: $80","Rear Air Shock Service: $45","Rear Suspension Linkage Services: $125","Dropper Post Service: $60-$95"]

    /* creates picker for tune type and sets the number of selections to the length of the tuneType array */
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        
        return tuneType.count
        
    }
    /* sets the number of columns in the picker to one */
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        
        return 1
    }
    /* pikcerView sets the text for each tune type in the selection picker and then sets the
       text color to white so it can be more easily displayed on the interface. */
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? { 
        let attributedString = NSAttributedString(string: tuneType[row], attributes: [NSForegroundColorAttributeName : UIColor.whiteColor()])
        return attributedString
    }
    /*
    takes the selection from the picker and sends it to the newOrderTectFieldStrunct so it can be displayed on the
    invoice page.
    */
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        newOrderTextFieldStruct.tunePicker = tuneType[row]
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

