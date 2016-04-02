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
	class Service
  {
    var sID:   Int
    var sName: String
    var sCost: Int
    var sTime: Float

    init(id: Int, name: String, cost: Int, time: Float)
    {
      sID = id
      sName = name
      sCost = cost
      sTime = time
    }
  }
  
  private static var Services : [Service] = []

  static func populateTunes()
  {
    Services = []

    // Get and display all tunes
    let MyParams = ["action":"retrieveTunes"]

    ServerCom.send(MyParams, f: {(succ: Bool, retjson: JSON) in
      if succ {
        print("Loading \(retjson.count) tunes from the server")
        for (var i = 0; i < retjson.count; i++) {
          Services.append(Service(id: Int(retjson[i]["tune"].string!)!,
                                  name: retjson[i]["name"].string!,
                                  cost: Int(retjson[i]["cost"].string!)!,
                                  time: retjson[i]["time"].string!.floatValue))
        }
      }
      else {
        print("Failed to retrieve tunes.")
      }
      return succ
    })
  }

  static func ID(id: Int) -> String?
  {
    for s in Services
    {
      if s.sID == id
      {
        return s.sName
      }
    }
		return nil
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

    // Change the local copy of the Service
    if let s = Tune.getTune(id)
    {
			if name != "" { s.sName = name }
    	if cost != "" { s.sCost = Int(cost)! }
    	if time != "" { s.sTime = time.floatValue }
    }
  }

  static func getServices() -> [Service]
  {
    return Services
  }

  static func numberOfTunes() -> Int
  {
    return Services.count
  }

  static func getTune(id: Int) -> Service?
  {
    for s in Services
    {
      if s.sID == id
      {
        return s
      }
    }
    return nil
  }

  static func getTune(name: String) -> Service?
  {
    for s in Services
    {
      if s.sName == name
      {
        return s
      }
    }
    return nil
  }

}