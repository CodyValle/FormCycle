//
//  AwaitingOrderViewController.swift
//  FormCycle
//
//  Created by Merrill Lines on 2/6/16.
//  Copyright © 2016 Merrill Lines. All rights reserved.
//

import Foundation
import UIKit
import SwiftHTTP
import SwiftyJSON

class AwaitingOrderViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIPickerViewDelegate
{
    @IBAction func generateOrderPDF(sender: AnyObject)
    {
        let layer = UIApplication.sharedApplication().keyWindow!.layer
        let scale = UIScreen.mainScreen().scale
        
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
        layer.renderInContext(UIGraphicsGetCurrentContext()!)
        
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        UIImageWriteToSavedPhotosAlbum(screenshot, nil, nil, nil)
        
        let refreshAlert = UIAlertController(title: "PDF Created Successfully", message: "Saved to Photo Album", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in self.dismissViewControllerAnimated(true, completion: nil) /* dismisses the current view */
        }))
        self.presentViewController(refreshAlert, animated: true, completion: nil)
        
    }

}
