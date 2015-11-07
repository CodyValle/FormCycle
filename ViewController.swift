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
    
    @IBAction func OrderNext(sender: AnyObject) {
        let NewParams = ["fname": fname.text!, "lname": lname.text!, "address":address.text!, "address2":address2.text!, "city":city.text!, "state":state.text!, "zip":zip.text!, "phone":phone.text!, "email":email.text!]
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

