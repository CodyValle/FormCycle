//
//  ViewController.swift
//  MyFormCycleHome
//
//  Created by Merrill Lines on 11/5/15.
//  Copyright © 2015 Merrill Lines. All rights reserved.
//

import UIKit
import SwiftHTTP
import Foundation

class ViewController: UIViewController {

    //MARK: Login Page text and Server Request
    @IBOutlet weak var USRTextField: UITextField!
    @IBOutlet weak var PWDTextField: UITextField!
    @IBAction func MyButton(sender: AnyObject) {
        let params = ["action": USRTextField.text!, "pwd": PWDTextField.text!]
        do {
            let opt = try HTTP.POST("http://107.170.219.218/Capstone/delegate.php", parameters: params)
            opt.start {response in
                if let error = response.error {
                    print("got an error: \(error)")
                    return
                }
                print(response.text!)
                
            }
            
        } catch let error {
            print("got an error creating the request: \(error)")
        }
    }
    
    
    
    //MARK: New Order Page Text and Server Request
    
    @IBOutlet weak var fname: UITextField!
    @IBOutlet weak var lname: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var address2: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var zip: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var email: UITextField!
    
    struct MyVariables {
        static var firstName = ""
        static var lastName = ""
        static var myAddress = ""
        static var myAddress2 = ""
        static var myCity = ""
        static var myState = ""
        static var myZip = ""
        static var myPhone = ""
        static var myEmail = ""
    }
    
   // var applyAllVars = MyVariables(firstName:"")
    
    
    //MARK: Variables from first New Order Page
    
    
    @IBAction func nextButton(sender: AnyObject) {
    }
        
    
    @IBAction func submitCustInfo(sender: AnyObject) {
       // applyAllVars.firstName = fname.text!
        MyVariables.firstName = fname.text!
        MyVariables.lastName = lname.text!
        MyVariables.myAddress = address.text!
        MyVariables.myAddress2 = address2.text!
        MyVariables.myCity = city.text!
        MyVariables.myState = state.text!
        MyVariables.myZip = zip.text!
        MyVariables.myPhone = phone.text!
        MyVariables.myEmail = email.text!
        //print("hello World")
        //print(applyAllVars.firstName)
        //print(lname)
        //print(MyVariables.firstName)
        //print(MyVariables.lastName)
    }
    
    //override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
     //   if (segue.identifier == "Load View") {
            // pass data to next view
     //   }
    //}
    
    //Bike Information Vars
    @IBOutlet weak var brand: UITextField!
    @IBOutlet weak var model: UITextField!
    @IBOutlet weak var color: UITextField!
    @IBOutlet weak var notes: UITextView!
    @IBOutlet weak var tagNumber: UITextField!
    
    
    //Takes the user back to the Home Page
    @IBAction func SubmitButton(sender: AnyObject) {
        
        let MyParams = ["action":"workOrder","fname":MyVariables.firstName, "lname":MyVariables.lastName, "address":MyVariables.myAddress, "address2":MyVariables.myAddress2, "city":MyVariables.myCity, "state":MyVariables.myState, "zip":MyVariables.myZip, "phone":MyVariables.myPhone, "email":MyVariables.myEmail, "brand":brand.text!, "model":model.text!, "color":color.text!,
            "tagNum":tagNumber.text!,
            "notes":notes.text!]
        do {
            let opt = try HTTP.POST("http://107.170.219.218/Capstone/delegate.php", parameters: MyParams)
            opt.start {response in
                if let error = response.error {
                    print("got an error: \(error)")
                    return
                }
                print(response.text!)
                
            }
            
        } catch let error {
            print("got an error creating the request: \(error)")
        }
        
        //takes the user back a page... NEED TO FIX THIS TO GO BACK TO HOME PAGE.
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    @IBAction func SendBikeData(sender: AnyObject) {
        //print(Fname.text)
        //print(MyVariables.myCity)
        let NewParams = ["action":"workOrder","fname":MyVariables.firstName, "lname":MyVariables.lastName, "address":MyVariables.myAddress, "address2":MyVariables.myAddress2, "city":MyVariables.myCity, "state":MyVariables.myState, "zip":MyVariables.myZip, "phone":MyVariables.myPhone, "email":MyVariables.myEmail, "brand":brand.text!, "model":model.text!, "color":color.text!,
            "tagNum":tagNumber.text!,
            "notes":notes.text!]
        do {
            let opt = try HTTP.POST("http://107.170.219.218/Capstone/delegate.php", parameters: NewParams)
            opt.start {response in
                if let error = response.error {
                    print("got an error: \(error)")
                    return
                }
                print(response.text!)
                
            }
            
        } catch let error {
            print("got an error creating the request: \(error)")
        }
        
        //takes the user back to the home page.
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //Made to set the text pre-populated in the text
    //boxes when the user pressed back on the 
    //RepairInfo Page.
    
    
    @IBAction func backToCustInfo(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    //MARK: Pre-Defined functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

