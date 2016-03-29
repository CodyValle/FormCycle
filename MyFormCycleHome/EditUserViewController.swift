//
//  EditUserViewController.swift
//  FormCycle
//
//  Created by Merrill Lines on 3/29/16.
//  Copyright © 2016 Merrill Lines. All rights reserved.
//

import UIKit

class EditUserViewController: UIViewController
{
    
    @IBOutlet weak var signatureField: YPDrawSignatureView!
    @IBAction func backToEditRemoveTable(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil) /* dismisses the current view */
    }
    
    @IBAction func clearSignature(sender: AnyObject) {
        signatureField.clearSignature()
    }
    
    
}