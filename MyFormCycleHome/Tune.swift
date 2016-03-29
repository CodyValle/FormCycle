//
//  Tune.swift
//  FormCycle
//
//  Created by Valle, Cody J on 3/29/16.
//  Copyright © 2016 Merrill Lines. All rights reserved.
//

import SwiftyJSON

class Tune
{
  private static var tunes : [String] = []
  private static var num = 0

  static func populateTunes()
  {
    tunes = []
    num = 0

    // Get and display all tunes
    let MyParams = ["action":"retrieveTunes"]

    ServerCom.send(MyParams, f: {(succ: Bool, retjson: JSON) in
      if succ {
        print("Loading \(retjson.count) tunes from the server")
        num = retjson.count
        for (var i = 0; i < retjson.count; i++) {
          print("Tune \(i)")
          print("tune: \(retjson[i]["tune"].string!)")
          print("name: \(retjson[i]["name"].string!)")
          print("time: \(retjson[i]["time"].string!)")
          print("cost: \(retjson[i]["cost"].string!)")
          print("\n")

          tunes.append(retjson[i]["name"].string!)
        }
      }
      else {
        print("Failed to retrieve tunes.")
      }
      return succ
    })
  }

  static func ID(id: Int) -> String
  {
		return tunes[id]
  }

  static func editTune(id: Int, name: String = "", cost: String = "", time: String = "")
  {
    // Edit an existing tune
    var MyParams = ["action":"editTune"]
    MyParams["tune"] = String(id) // This is the tune ID.
    if name != "" { MyParams["tunename"] = name }
    if cost != "" { MyParams["tunecost"] = cost }
    if time != "" { MyParams["tunetime"] = time }

    ServerCom.send(MyParams, f: {(succ: Bool, retjson: JSON) in
      if succ {
        print("Successfully edited a tune")
      }
      else {
        print("Failed to edit tune.")
      }
      return succ
    })

    while ServerCom.waiting() {}
    
    self.populateTunes()
  }

  static func numberOfTunes() -> Int
  {
    return num
  }

}
