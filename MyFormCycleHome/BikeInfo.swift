//
//  BikeInfo.swift
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
    /*+------------------------------------ BIKE INFO PAGE ------------------------------------+
    | Bike info page collects all revelant info pertaining to the bike itself. Here we       |
    | collect the Model, Brand, Color, Tag Number, and Notes about the bike.                 |
    | MARK: Variables and functions for Bike Information Page.                               |
    +----------------------------------------------------------------------------------------+*/
    
    /* New Order Page: Bike Information. This section denotes the variables
    * as well as the functions that pretain to the Bike Information Page.
    */
    
    /* Made to set the text pre-populated in the text
    * boxes when the user pressed back on the
    * RepairInfo Page.
    */
    @IBAction func backToCustInfo(sender: AnyObject) {
    
        newOrderTextFieldStruct.bikeInfoPage = false /* sets current view to false */
        dismissViewControllerAnimated(true, completion: nil) /* dismisses the current view */
        newOrderTextFieldStruct.neworderpage = true /* sets the new order page view to true since
        user just pressed the "back" button */
    }
  

}
