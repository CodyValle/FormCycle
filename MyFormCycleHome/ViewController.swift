//
//  ViewController.swift
//  FormCycle
//
//  Created by Merrill Lines on 11/5/15.
//  Copyright © 2015 Merrill Lines and FormCycle. All rights reserved.
//


import UIKit
import SwiftHTTP

class ViewController: UIViewController, UITextFieldDelegate
{
	
	
//******************** SIGN IN PAGE *****************************************
  /* This is the Login Page which will be implemented at a later date. 
   * Due to this, the section referred to as MARK: Login Page text and Server Request
   * will remain commented out until finally becoming implemented.
   */
  //MARK: Login Page text and Server Request
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
  
//**************************************************************************
    
//******************** NEW ORDER PAGE **************************************
  
  //MARK: New Order Page Text and Server Request
  
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
    static var firstName = " "
    static var lastName = " "
    static var myAddress = " "
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
		
  }
  
    
  /* New Order Page: Customer Information. This section denotes the variables
   * as well as the functions that pretain to the Customer Information Page.
   */
  //MARK: Variables and functions for Customer Information Page.
  @IBAction func submitCustInfo(sender: AnyObject)
  {
    
    newOrderTextFieldStruct.firstName = fname.text! + " "
    newOrderTextFieldStruct.lastName = lname.text! + " "
    newOrderTextFieldStruct.myAddress = address.text! + " "
    newOrderTextFieldStruct.myAddress2 = address2.text! + " "
    newOrderTextFieldStruct.myCity = city.text! + " "
    newOrderTextFieldStruct.myState = state.text! + " "
    newOrderTextFieldStruct.myZip = zip.text!
    newOrderTextFieldStruct.myPhone = phone.text!
    newOrderTextFieldStruct.myEmail = email.text!
  }
	
	
	override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool
	{
		// Checks to make sure that all Customer Info is filled out before moving onto next page.
		if newOrderTextFieldStruct.neworderpage == true
		{
		
			if fname.text?.utf16.count == 0
			{
				let refreshAlert = UIAlertController(title: "Did Not Enter First Name", message: "Try Again", preferredStyle: UIAlertControllerStyle.Alert)
				
				refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
				}))
				presentViewController(refreshAlert, animated: true, completion: nil)
				return false
			}
			else if lname.text?.utf16.count == 0 //Checks last name restrictions
			{
				let alertView = UIAlertView(title: "Did Not Enter Last Name", message: "Try Again", delegate: self, cancelButtonTitle: "Dismiss")
				alertView.show()
				return false
			}
			else if address.text?.utf16.count == 0 //Checks address restrictions
			{
				let alertView = UIAlertView(title: "Did Not Enter Address", message: "Try Again", delegate: self, cancelButtonTitle: "Dismiss")
				alertView.show()
				return false
			}
			else if city.text?.utf16.count == 0 //Checks city restrictions
			{
				let alertView = UIAlertView(title: "Did Not Enter City", message: "Try Again", delegate: self, cancelButtonTitle: "Dismiss")
				alertView.show()
				return false
			}
			else if state.text?.utf16.count < 2 //Checks state restrictions
			{
				let alertView = UIAlertView(title: "Did Not Enter State", message: "Try Again", delegate: self, cancelButtonTitle: "Dismiss")
				alertView.show()
				return false
			}
			else if zip.text?.utf16.count < 5 //Checks zip restrictions
			{
				let alertView = UIAlertView(title: "Did Not Enter Zip", message: "Try Again", delegate: self, cancelButtonTitle: "Dismiss")
				alertView.show()
				return false
			}
			else if phone.text?.utf16.count == 0 //Checks phone restrictions
			{
				let alertView = UIAlertView(title: "Did Not Enter Phone", message: "Try Again", delegate: self, cancelButtonTitle: "Dismiss")
				alertView.show()
				return false
			}
			else if email.text?.utf16.count == 0 //Checks email restrictions
			{
				let alertView = UIAlertView(title: "Did Not Enter Email", message: "Try Again", delegate: self, cancelButtonTitle: "Dismiss")
				alertView.show()
				return false
			}
			else
			{
				return true
			}
		}
		return true
	}
	

//***************************************************************************
	
//********************** BIKE INFO PAGE *************************************
  /* New Order Page: Bike Information. This section denotes the variables
   * as well as the functions that pretain to the Bike Information Page.
   */
  //MARK: Variables and functions for Bike Information Page.
  @IBOutlet weak var brand: UITextField!
  @IBOutlet weak var model: UITextField!
  @IBOutlet weak var color: UITextField!
  @IBOutlet weak var notes: UITextView!
  @IBOutlet weak var tagNumber: UITextField!
  
  
  //Takes the user back to the Home Page
  @IBAction func OrderCompleteSubmitButtonTop(sender: UIBarButtonItem)
	{
    let MyParams = ["DEBUG":"true","action":"workOrder","fname":newOrderTextFieldStruct.firstName, "lname":newOrderTextFieldStruct.lastName, "address":newOrderTextFieldStruct.myAddress, "address2":newOrderTextFieldStruct.myAddress2, "city":newOrderTextFieldStruct.myCity, "state":newOrderTextFieldStruct.myState, "zip":newOrderTextFieldStruct.myZip, "phone":newOrderTextFieldStruct.myPhone, "email":newOrderTextFieldStruct.myEmail, "brand":brand.text!, "model":model.text!, "color":color.text!,
      "tagNum":tagNumber.text!,
      "notes":notes.text!]
		do
		{
			let opt = try HTTP.POST("http://107.170.219.218/Capstone/delegate.php", parameters: MyParams)
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
    }
    /* takes the user back a page... NEED TO FIX THIS TO GO BACK TO HOME PAGE. */
		//self.presentingViewController; self.dismissViewControllerAnimated(true, completion:nil)
    //dismissViewControllerAnimated(true, completion: nil)
  }
  
  /* Made to set the text pre-populated in the text
   * boxes when the user pressed back on the
   * RepairInfo Page.
   */
  @IBAction func backToCustInfo(sender: AnyObject) {
    
    dismissViewControllerAnimated(true, completion: nil)
		newOrderTextFieldStruct.neworderpage = true
    
  }
 //************************************************************************
    
//*********************** LOAD INVOICE PAGE *******************************
    
    
    @IBOutlet weak var invNotes: UILabel!
    @IBOutlet weak var invTagNum: UILabel!
    @IBOutlet weak var makeModelColor: UILabel!
    @IBOutlet weak var invEmail: UILabel!
    @IBOutlet weak var invPhone: UILabel!
    @IBOutlet weak var CityStateZip: UILabel!
    @IBOutlet weak var address3: UILabel!
    @IBOutlet weak var address1: UILabel!
    @IBOutlet weak var Name: UILabel!
    @IBAction func loadInvoice(sender: AnyObject) {
        Name.text = newOrderTextFieldStruct.firstName +  newOrderTextFieldStruct.lastName
        address1.text = newOrderTextFieldStruct.myAddress
        address3.text = newOrderTextFieldStruct.myAddress2
        CityStateZip.text = newOrderTextFieldStruct.myCity + newOrderTextFieldStruct.myState + newOrderTextFieldStruct.myZip
        invPhone.text = newOrderTextFieldStruct.myPhone
        invEmail.text = newOrderTextFieldStruct.myEmail
       makeModelColor.text = newOrderTextFieldStruct.myBrand + newOrderTextFieldStruct.myModel + "(" + newOrderTextFieldStruct.myColor + ")"
        invTagNum.text = newOrderTextFieldStruct.myTagNumber
        invNotes.text = newOrderTextFieldStruct.myNotes
    }
    
//*************************************************************************
    
	
    
    //MARK: Pre-Defined functions
    override func viewDidLoad() {
			super.viewDidLoad()
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
			else if newOrderTextFieldStruct.bikeInfoPage == true
			{
				brand.delegate = self
				model.delegate = self
				color.delegate = self
				tagNumber.delegate = self
				
				
			}
    
        // Do any additional setup after loading the view, typically from a nib.
    }
	
	//**************
  // Tap outside a text field to dismiss the keyboard
  // ------------------------------------------------
  // By changing the underlying class of the view from UIView to UIControl,
  // the view can respond to events, including Touch Down, which is
  // wired to this method.
  @IBAction func userTappedBackground(sender: AnyObject) {
		view.endEditing(true)
  }
  
  
  // MARK: UITextFieldDelegate events and related methods
  func textField(textField: UITextField,
		shouldChangeCharactersInRange range: NSRange,
		replacementString string: String)
		-> Bool
	{
		
		// We ignore any change that doesn't add characters to the text field.
		// These changes are things like character deletions and cuts, as well
		// as moving the insertion point.
		//
		// We still return true to allow the change to take place.
		if string.characters.count == 0 {
			return true
		}
		if newOrderTextFieldStruct.neworderpage == true
		{
		// Check to see if the text field's contents still fit the constraints
		// with the new content added to it.
		// If the contents still fit the constraints, allow the change
		// by returning true; otherwise disallow the change by returning false.
		let currentText = textField.text ?? ""
		let prospectiveText = (currentText as NSString).stringByReplacingCharactersInRange(range, withString: string)
  
		switch textField {
			
			// Allow only upper-case letters in this field,
			// and must have only 2 characters.
		case state:
			return prospectiveText.containsOnlyCharactersIn("ABCDEFGHIJKLMNOPQRSTUVWXYZ") &&
				prospectiveText.characters.count <= 2
			
			// Allow only digits in this field,
			// and limit its contents to 7, 10, or 11 characters.
		case phone:
			return prospectiveText.containsOnlyCharactersIn("0123456789") &&
				prospectiveText.characters.count <= 10
			
			// Allow only digits in this field,
			// and must have only 5 characters.
		case zip:
			return prospectiveText.containsOnlyCharactersIn("0123456789") &&
				prospectiveText.characters.count <= 5
			
			
		default:
			return true
		}
			
		}
		return true
  }
	
	
	/* Checks which text box is currently in the view of the user. Then
	*  will either set the next appropiate text box that should be active
	*  or dismisses the keyboard if at the last text box.
	*  Dismiss the keyboard when the user taps the "Return" key or its equivalent
	* while editing a text field.
  */
	func textFieldShouldReturn(textField: UITextField) -> Bool {
		if (textField === fname)
		{
			lname.becomeFirstResponder()
		}
		else if (textField === lname)
		{
				address.becomeFirstResponder()
		}
		else if (textField === address)
		{
			address2.becomeFirstResponder()
		}
		else if (textField === address2)
		{
			city.becomeFirstResponder()
		}
		else if (textField === city)
		{
			state.becomeFirstResponder()
		}
		else if (textField === state)
		{
			zip.becomeFirstResponder()
		}
		else if (textField === zip)
		{
			phone.becomeFirstResponder()
		}
		else if (textField === phone)
		{
			email.becomeFirstResponder()
		}
		else if (textField === email)
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
			tagNumber.resignFirstResponder()
		}
	
		return true
	}
	
	  /* Overrides the seque function which allows us to preload pages with
    *  with text before loading the page.
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
			newOrderTextFieldStruct.neworderpage = false
			newOrderTextFieldStruct.bikeInfoPage = false
			if segue.identifier == "moveToCustInfo"
			{
				
				newOrderTextFieldStruct.neworderpage = true
				
			}
			
        if segue.identifier == "moveToInvoice"{
            newOrderTextFieldStruct.myBrand = brand.text! + " "
            newOrderTextFieldStruct.myModel = model.text! + " "
            newOrderTextFieldStruct.myColor = color.text!
            newOrderTextFieldStruct.myNotes = notes.text!
            newOrderTextFieldStruct.myTagNumber = tagNumber.text!
           
            let MyParams = ["DEBUG":"true","action":"workOrder","fname":newOrderTextFieldStruct.firstName, "lname":newOrderTextFieldStruct.lastName, "address":newOrderTextFieldStruct.myAddress, "address2":newOrderTextFieldStruct.myAddress2, "city":newOrderTextFieldStruct.myCity, "state":newOrderTextFieldStruct.myState, "zip":newOrderTextFieldStruct.myZip, "phone":newOrderTextFieldStruct.myPhone, "email":newOrderTextFieldStruct.myEmail, "brand":newOrderTextFieldStruct.myBrand, "model":newOrderTextFieldStruct.myModel, "color":newOrderTextFieldStruct.myColor,
                "tagNum":newOrderTextFieldStruct.myTagNumber,
                "notes":newOrderTextFieldStruct.myNotes]
            do
            {
                let opt = try HTTP.POST("http://107.170.219.218/Capstone/delegate.php", parameters: MyParams)
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
            }

            
					
        }
        if segue.identifier == "loadCustomerInfo"{
					newOrderTextFieldStruct.bikeInfoPage = true;
            newOrderTextFieldStruct.firstName = fname.text! + " "
            newOrderTextFieldStruct.lastName = lname.text! + " "
            newOrderTextFieldStruct.myAddress = address.text! + " "
            newOrderTextFieldStruct.myAddress2 = address2.text! + " "
            newOrderTextFieldStruct.myCity = city.text! + " "
            newOrderTextFieldStruct.myState = state.text! + " "
            newOrderTextFieldStruct.myZip = zip.text!
            newOrderTextFieldStruct.myPhone = phone.text!
            newOrderTextFieldStruct.myEmail = email.text!
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

