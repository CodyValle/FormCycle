//
//  LoadInvoice.swift
//  FormCycle
//
//  Created by Valle, Cody J on 1/21/16.
//  Copyright © 2016 FormCycle Developers. All rights reserved.
//

import UIKit
import SwiftHTTP
import SwiftyJSON 
import MessageUI

extension ViewController
{
  /*+-------------------------------- LOAD INVOICE PAGE ------------------------------------+
  | Load invoice page displays all recorded information collected through the customer      |
  | information page, and bike information page. This allows the tech to see if all info    |
  | was correctly collected and presents the tech with the option to generate a PDF. This   |                                                   
  | PDF is saved to the local photos app inside the iPad and can there be accessed to print |
  | or be emailed.                                                                          |
  | MARK: Variables and functions for Load Invoice Page.                                    |
  +-----------------------------------------------------------------------------------------+*/
  
  /* generatePDF() This function runs when the user presses the "PDF" button on the invoice
  *  page. This code creates a virtual "screenshot" of this page and then saves it to the
  *  local photos saved on the phone. This will ask for permission before allowing it to
  *  save a photo. Once permission is granted, the user will no be prompted again to save
  *  additional photos/PDFs.
  */
  @IBAction func generatePDF(sender: AnyObject)
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
      
      mailComposerVC.setToRecipients([newOrderTextFieldStruct.myEmail])
      mailComposerVC.setSubject("This Bike Life: Email Confirmation of Bicycle Order")
      mailComposerVC.setMessageBody("Please find the attached invoice for your records. Should you have any questions, feel free to call our office. Thank you!", isHTML: false)
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

}