//
//  ViewController.swift
//  FormCycle
//
//  Created by Merrill Lines on 11/5/15.
//  Copyright © 2015 Merrill Lines and FormCycle. All rights reserved.
//

import UIKit
import SwiftHTTP

class ViewController: UIViewController
{
//******************** SIGN IN PAGE *****************************************
  /* This is the Login Page which will be implemented at a later date. 
   * Due to this, the section referred to as MARK: Login Page text and Server Request
   * will remain commented out until finally becoming implemented.
   */
  //MARK: Login Page text and Server Request
  @IBOutlet weak var USRTextField: UITextField!
  @IBOutlet weak var PWDTextField: UITextField!
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
  }
  
    
  /* New Order Page: Customer Information. This section denotes the variables
   * as well as the functions that pretain to the Customer Information Page.
   */
  //MARK: Variables and functions for Customer Information Page.
  @IBAction func submitCustInfo(sender: AnyObject)
  {/*
    
    newOrderTextFieldStruct.firstName = fname.text! + " "
    newOrderTextFieldStruct.lastName = lname.text! + " "
    newOrderTextFieldStruct.myAddress = address.text! + " "
    newOrderTextFieldStruct.myAddress2 = address2.text! + " "
    newOrderTextFieldStruct.myCity = city.text! + " "
    newOrderTextFieldStruct.myState = state.text! + " "
    newOrderTextFieldStruct.myZip = zip.text!
    newOrderTextFieldStruct.myPhone = phone.text!
    newOrderTextFieldStruct.myEmail = email.text!*/
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
      /*
        newOrderTextFieldStruct.myBrand = brand.text! + " "
        newOrderTextFieldStruct.myModel = model.text! + " "
        newOrderTextFieldStruct.myColor = color.text!
        newOrderTextFieldStruct.myNotes = notes.text!
        newOrderTextFieldStruct.myTagNumber = tagNumber.text!
        */
    let MyParams = ["action":"workOrder","fname":newOrderTextFieldStruct.firstName, "lname":newOrderTextFieldStruct.lastName, "address":newOrderTextFieldStruct.myAddress, "address2":newOrderTextFieldStruct.myAddress2, "city":newOrderTextFieldStruct.myCity, "state":newOrderTextFieldStruct.myState, "zip":newOrderTextFieldStruct.myZip, "phone":newOrderTextFieldStruct.myPhone, "email":newOrderTextFieldStruct.myEmail, "brand":brand.text!, "model":model.text!, "color":color.text!,
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
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  /* Made to set the text pre-populated in the text
   * boxes when the user pressed back on the
   * RepairInfo Page.
   */
  @IBAction func backToCustInfo(sender: AnyObject) {
    
    dismissViewControllerAnimated(true, completion: nil)
    
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
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "moveToInvoice"{
            newOrderTextFieldStruct.myBrand = brand.text! + " "
            newOrderTextFieldStruct.myModel = model.text! + " "
            newOrderTextFieldStruct.myColor = color.text!
            newOrderTextFieldStruct.myNotes = notes.text!
            newOrderTextFieldStruct.myTagNumber = tagNumber.text!
            
        }
        if segue.identifier == "loadCustomerInfo"{
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
    
    
}

