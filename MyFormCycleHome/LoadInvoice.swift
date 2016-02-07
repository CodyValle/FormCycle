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
        let layer = UIApplication.sharedApplication().keyWindow!.layer
        let scale = UIScreen.mainScreen().scale
        
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
        layer.renderInContext(UIGraphicsGetCurrentContext()!)
        
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        UIImageWriteToSavedPhotosAlbum(screenshot, nil, nil, nil)
        
        let refreshAlert = UIAlertController(title: "PDF Created Successfully", message: "Saved to Photo Album", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
        }))
        self.presentViewController(refreshAlert, animated: true, completion: nil)
    }
}
