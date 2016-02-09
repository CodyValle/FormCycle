//
//  AwaitingOrderViewController.swift
//  FormCycle
//
//  Created by Merrill Lines on 2/6/16.
//  Copyright © 2016 FormCycle Developers. All rights reserved.
//

import Foundation
import UIKit
import SwiftHTTP
import SwiftyJSON
import MessageUI

class AwaitingOrderViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIPickerViewDelegate, MFMailComposeViewControllerDelegate
{
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address1: UILabel!
    @IBOutlet weak var address2: UILabel!
    @IBOutlet weak var cityStateZip: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var makeModelColor: UILabel!
    @IBOutlet weak var tagNum: UILabel!
    @IBOutlet weak var tune: UILabel!
    @IBOutlet weak var currentDate: UILabel!
    @IBOutlet weak var userNotes: UILabel!
    /* local variables for passing the workID between view controllers */
    var workidPassedWait = ""
    var workidWait = ""
    
    
    func printTimestamp()->String {
        let timestamp = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .ShortStyle)
        return timestamp
    }
    
    
    
    
    func loadData()
    {
        /* Submits the server request */
        var MyParams = ["action":"workSearch"]
        var isDoneLoading = false //using for concurrency
        
        // Append possible search data to the parameters. Note: MyParams is changed to a var, instead of a let.
        MyParams["workid"] = workidWait
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
                            if (json["success"])
                            {
                                // Probably needs more error checks.
                                let retString = json["return"].string!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
                                let order = JSON(data: retString!)
                                if (order.count > 0) // Fill the form
                                {
                                    self.name.text = order[0]["fname"].string! + " " + order[0]["lname"].string!
                                    self.address1.text = order[0]["address"].string!
                                    if(order[0]["address2"] != nil)
                                    {
                                        self.address2.text =  order[0]["address2"].string!
                                    }
                                    self.cityStateZip.text = order[0]["city"].string! + ", " + order[0]["state"].string! + ", " + order[0]["zip"].string!
                                    self.makeModelColor.text = order[0]["brand"].string! + " " + order[0]["model"].string! + ", " + order[0]["color"].string!
                                    self.tune.text = "Bronze"
                                    self.tagNum.text = order[0]["tagnum"].string!
                                    self.phone.text = order[0]["phone"].string!
                                    self.email.text = order[0]["email"].string!
                                    //self.userNotes.text = order[0]["notes"].string!
                                    
                                }
                                //else you are done- TO DO LATER
                            }
                        }
                    }
                    // Some helpful debug data for use when needing to place in table.
                    isDoneLoading = true
            }
        }
        catch let error
        {
            print("got an error creating the request: \(error)")
        }
        while(!isDoneLoading){} //Pretty stinky, forcing our app to wait for the data to come back from the server before loading the table
        
    }
    
    override func viewDidLoad()
    {
        self.workidWait = workidPassedWait
        //Load data
        loadData()
        currentDate.text = printTimestamp()
        //printTimestamp() // Prints "Sep 9, 2014, 4:30 AM"
        
    }

    
    /* generateOrderPDF: creates a PDF or screenshot of this page when the button is clicked.
    *  This will save the photo to the Photos app in the phone and can then be emailed or
    *  printed for records. This will also show an alert saying that the PDF was created
    *  successfully. Once the user hits "ok" on the alert message, it will take the user
    *  directly back to the main page.
    */
    @IBAction func generateOrderPDF(sender: AnyObject)
    {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let layer = UIApplication.sharedApplication().keyWindow!.layer
        let scale = UIScreen.mainScreen().scale
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale)
        layer.renderInContext(UIGraphicsGetCurrentContext()!)
        //view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let imageData = UIImageJPEGRepresentation(image, 1.0)
        
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(["someone@somewhere.com"])
        mailComposerVC.setSubject("Sending you an in-app e-mail...")
        mailComposerVC.setMessageBody("Sending e-mail in-app is not so bad!", isHTML: false)
        mailComposerVC.addAttachmentData(imageData!, mimeType: "image/jpeg", fileName: "My Invoice.jpeg")
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let refreshAlert = UIAlertController(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in 
        }))
        self.presentViewController(refreshAlert, animated: true, completion: nil)
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }

    
    
    
//        let layer = UIApplication.sharedApplication().keyWindow!.layer
//        let scale = UIScreen.mainScreen().scale
//        
//        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
//        layer.renderInContext(UIGraphicsGetCurrentContext()!)
//        
//        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
//        
//        UIGraphicsEndImageContext()
//        UIImageWriteToSavedPhotosAlbum(screenshot, nil, nil, nil)
//        
//        let refreshAlert = UIAlertController(title: "PDF Created Successfully", message: "Saved to Photo Album", preferredStyle: UIAlertControllerStyle.Alert)
//        
//        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in self.dismissViewControllerAnimated(true, completion: nil) /* dismisses the current view */
//        }))
//        self.presentViewController(refreshAlert, animated: true, completion: nil)
        
    

}
