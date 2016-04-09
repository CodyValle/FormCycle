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
    @IBOutlet weak var custSig: YPDrawSignatureView!
    @IBOutlet weak var techSig: YPDrawSignatureView!

    @IBAction func clearCustSig(sender: AnyObject) {
        custSig.clearSignature()
    }
    @IBAction func clearTechSig(sender: AnyObject) {
        techSig.clearSignature()
    }
    
    
  /* local variables for passing the workID between view controllers */
  var workidPassedWait = ""
  var workidWait = ""
  var emailUsr = ""
    
  /* printTimestamp() creates a variable to store the current time and date. This can then
  *  be used anywhere in this class to display the current time stamp.
  */
  func printTimestamp()->String
  {
    let timestamp = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .ShortStyle)
    return timestamp
  }

  override func viewDidLoad()
  {
    self.workidWait = workidPassedWait

    //Load data
    /* Submits the server request */
    var MyParams = ["action":"workSearch"]

    // Append possible search data to the parameters. Note: MyParams is changed to a var, instead of a let.
    MyParams["workid"] = workidWait

    ServerCom.send(MyParams, f: {(succ: Bool, retjson: JSON) in
      if (succ)
      {
        if (retjson.count > 0) // Fill the form
        {
          dispatch_async(dispatch_get_main_queue())
            {
              self.name.text = Crypto.decrypt(retjson[0]["fname"].string!) + " " + Crypto.decrypt(retjson[0]["lname"].string!)

              if(retjson[0]["address2"] != nil)
              {
                self.address1.text = Crypto.decrypt(retjson[0]["address"].string!)
                self.address2.text = Crypto.decrypt(retjson[0]["address2"].string!)
              }
              else if(retjson[0]["address2"] == nil)
              {
                self.address1.text = ""
                self.address2.text = Crypto.decrypt(retjson[0]["address"].string!)
              }
              self.cityStateZip.text = Crypto.decrypt(retjson[0]["city"].string!) + ", " + retjson[0]["state"].string! + ", " + Crypto.decrypt(retjson[0]["zip"].string!)
              self.makeModelColor.text = retjson[0]["brand"].string! + " " + retjson[0]["model"].string! + ", " + retjson[0]["color"].string!

              var tuneString = retjson[0]["tune"].string!
              if let tuneID = Int(tuneString)
              {
                tuneString = Tune.ID(tuneID)!
              }
              self.tune.text = tuneString
              self.tagNum.text = retjson[0]["tagnum"].string!
              self.phone.text = Crypto.decrypt(retjson[0]["phone"].string!)
              if(retjson[0]["email"] != nil)
              {
                let email = Crypto.decrypt(retjson[0]["email"].string!)
                self.email.text = email
                self.emailUsr = email
              }
              //self.userNotes.text = order[0]["notes"].string!
          }
        }
        //else you are done- TO DO LATER
        return true
      }
      return false
    })

    while ServerCom.waiting() {}

    currentDate.text = printTimestamp()
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
    }
    else {
      self.showSendMailErrorAlert()
    }
  }
    
  func configuredMailComposeViewController() -> MFMailComposeViewController
  {
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
    
    mailComposerVC.setToRecipients([emailUsr])
    mailComposerVC.setSubject("This Bike Life: Email Confirmation of Bicycle Order")
    mailComposerVC.setMessageBody("Please find the attached invoice for your records. Should you have any questions, feel free to call our office. Thank you for your business!", isHTML: false)
    mailComposerVC.addAttachmentData(imageData!, mimeType: "image/jpeg", fileName: "My Invoice.jpeg")
    
    return mailComposerVC
  }
    
  func showSendMailErrorAlert()
  {
    let refreshAlert = UIAlertController(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", preferredStyle: UIAlertControllerStyle.Alert)
    
    refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in }))
    self.presentViewController(refreshAlert, animated: true, completion: nil)
  }
    
  // MARK: MFMailComposeViewControllerDelegate Method
  func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?)
  {
    controller.dismissViewControllerAnimated(true, completion: nil)
  }

  func submitServerRequest()
  {
    /* Submits the server request */
    var MyParams = ["action":"workUpdate"] 
    MyParams["workid"] = workidWait
    MyParams["open"] = "P"

    ServerCom.send(MyParams, f: {(succ: Bool, retjson: JSON) in return succ})
  }
    
  /* This function: pickedUp, will run when the user presses the "Picked Up" button on the Awaiting
  *  Order Page. This sends a request to the server to set the 'open' variable for this order
  *  to now be closed.
  */
  @IBAction func pickedUp(sender: AnyObject)
  {
    let refreshAlert = UIAlertController(title: "Confirmation", message: "Order will be submitted as picked up.", preferredStyle: UIAlertControllerStyle.Alert)
    
    refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
      self.submitServerRequest()
      self.performSegueWithIdentifier("pickedUpSegue", sender: self)
    }))
    
    refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in }))
    
    presentViewController(refreshAlert, animated: true, completion: nil)
  }
    
} //END OF: AwaitingOrderViewController.swift
