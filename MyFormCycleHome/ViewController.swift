//
//  ViewController.swift
//  MyFormCycleHome
//
//  Created by Merrill Lines on 11/5/15.
//  Copyright © 2015 Merrill Lines. All rights reserved.
//

import UIKit
import SwiftHTTP

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
        var firstName: String
        static var lastName = "Rag"
        static var myAddress = ""
        static var myAddress2 = ""
        static var myCity = ""
        static var myState = ""
        static var myZip = ""
        static var myPhone = ""
        static var myEmail = ""
    }
    
    var applyAllVars = MyVariables(firstName:"")
    
    
    //MARK: Variables from first New Order Page
    
    
    @IBAction func nextPage(sender: AnyObject) {
    
       // applyAllVars.firstName = fname.text!
       // MyVariables.firstName = fname.text!
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
        //print(MyVariables.lastName)
    }
    
    //Bike Information Vars
    @IBOutlet weak var brand: UITextField!
    @IBOutlet weak var model: UITextField!
    @IBOutlet weak var color: UITextField!
    @IBOutlet weak var notes: UITextView!
    @IBOutlet weak var tagNumber: UITextField!
    
    
    
    @IBAction func SubmitButton(sender: AnyObject) {
        print(MyVariables.lastName)
        let NewParams = ["action":"workOrder","fname":"john", "lname":MyVariables.lastName, "address":MyVariables.myAddress, "address2":MyVariables.myAddress2, "city":MyVariables.myCity, "state":MyVariables.myState, "zip":MyVariables.myZip, "phone":MyVariables.myPhone, "email":MyVariables.myEmail, "brand":brand.text!, "model":model.text!, "color":color.text!, "notes":notes.text!]
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

