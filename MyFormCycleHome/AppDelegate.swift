//
//  AppDelegate.swift
//  MyFormCycleHome
//
//  Created by Merrill Lines on 11/5/15.
//  Copyright © 2015 FormCycle Developers. All rights reserved.
//

import UIKit 

let defaults = NSUserDefaults.standardUserDefaults()
struct AddServices {
    
    static var serviceName:[String] = []
    static var workOrderId = ""
    static var editServiceArray:[String] = []
}
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {
    
    var window: UIWindow?  
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        let splitViewController =  window!.rootViewController as! UISplitViewController
        
        let navigationController = splitViewController.viewControllers[splitViewController.viewControllers.count-1] as! UINavigationController
        navigationController.topViewController!.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem()
        splitViewController.delegate = self
        
        UISearchBar.appearance().barTintColor = UIColor.robinRed()
        UISearchBar.appearance().tintColor = UIColor.whiteColor()
        UITextField.appearanceWhenContainedInInstancesOfClasses([UISearchBar.self]).tintColor = UIColor.robinRed()
        
        return true
    }
    
    // MARK: - Split view
//    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController:UIViewController, ontoPrimaryViewController primaryViewController:UIViewController) -> Bool {
        //guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
        //guard let topAsDetailController = secondaryAsNavController.topViewController as? DetailViewController else { return false }
        //if topAsDetailController.detailRecord == nil {
            // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
        //    return true
        //}
        //return false
   // }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
      BinPacker.saveToday()
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
      // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
      BinPacker.saveToday()
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
      // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
      BinPacker.saveToday()
    }
}

extension UIColor {
    static func robinRed() -> UIColor {
        return UIColor(red: 0.0706, green: 0.4235, blue: 0.61, alpha: 0.75)
    }
}




