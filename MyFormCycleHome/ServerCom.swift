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
  static var succ = false
  static var done = false
  static var theURL = "http://107.170.219.218/Capstone/delegate.php"

  static func send(d:Dictionary<String,String>, f: ((succ: Bool, retjson: JSON) -> Bool))
  {
    self.succ = false
    self.done = false

    do
    {
      /* tries to submit to server */
      let opt = try HTTP.POST(self.theURL, parameters: d)
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
            if let datafromstring = response.text!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
            {
              let json = JSON(data: datafromstring)
              let retString = json["return"].string!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)

              self.succ = f(succ: json["success"].bool!, retjson: JSON(data: retString!))
              self.done = true
            } //if let datastring = ...
          } // if (response.text != null)
      } // opt.start
    } // do
    catch let error
    {
      print("Got an error creating the request: \(error)")
      self.succ = false
    } // catch
  }

  static func open()
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

  static func getDebug() -> String
  {
    return "Empty"
  }

  static func waiting() -> Bool
  {
    return !self.done
  }

  static func success() -> Bool
  {
    return self.succ
  }
}
