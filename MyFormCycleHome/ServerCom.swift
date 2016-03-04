//
//  ServerCom.swift
//  FormCycle
//
//  Created by Valle, Cody J on 2/27/16.
//  Copyright © 2016 Merrill Lines. All rights reserved.
//

import SwiftHTTP
import SwiftyJSON

class ServerCom
{
  private static var succ = false
  private static var done = false
  private static var theURL = "http://107.170.219.218/Capstone/delegate.php"

  private static var customAllowedSet =  NSCharacterSet(charactersInString:"+\"#%/<>?@\\^`{|}").invertedSet

  internal static func send(d:Dictionary<String,String>, f: ((succ: Bool, retjson: JSON) -> Bool))
  {
    self.succ = false
    self.done = false

    var NewParams = [String:String]()

    for (key, value) in d {
      NewParams[key] = value.stringByAddingPercentEncodingWithAllowedCharacters(customAllowedSet)
    }

    do
    {
      /* tries to submit to server */
      let opt = try HTTP.POST(self.theURL, parameters: NewParams)
      opt.start
      {
        response in
        if let error = response.error
        {
          print("got an error: \(error)") /* if error, prints the error code saved on server */
          self.succ = false
          self.done = true
          return
        }

        // No errors
        if (response.text != nil)
        {
          if let datafromstring = response.text!.stringByRemovingPercentEncoding!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
          {
            let json = JSON(data: datafromstring)
            let retString = json["return"].isExists() ? json["return"].string!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) : NSData()

            self.succ = f(succ: json["success"].bool!, retjson: JSON(data: retString!))
            self.done = true
          } //if let datastring = ...
          else {
            print("ERROR: The server returned completely unrecognized stuff.")
            print(response.text!)
          }
        } // if (response.text != null)
        else {
          print("ERROR: The server did not return anything.")
        }
      } // opt.start
    } // do
    catch let error
    {
      print("Got an error creating the request: \(error)")
      self.succ = false
    } // catch
  }

  internal static func open()
  {
    do
    {
      let opt = try HTTP.POST(self.theURL)
      opt.start
        {
          response in
          if let error = response.error
          {
            print("\nGot an error: \(error)\n")
          }
      }
    }
    catch let error
    {
      print("Got an error creating the request: \(error)")
    }
  }

  internal static func getDebug() -> String
  {
    return "Empty"
  }

internal static func waiting() -> Bool
  {
    return !self.done
  }

internal static func success() -> Bool
  {
    return self.succ
  }
}