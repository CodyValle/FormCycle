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
    var sTime: Int
    var sType: Int
        
        init(id: Int, name: String, cost: Int, time: Int, type: Int)
    {
      sID = id
      sName = name
      sCost = cost
      sTime = time
      sType = type
    }
  }

  private static var Services : [Service] = []

  static func populateTunes()
  {
    Services = []

    // Get and display all tunes
    var MyParams = ["action":"retrieveTunes"]
    //MyParams["tunetype"] = "1"
    ServerCom.send(MyParams, f: {(succ: Bool, retjson: JSON) in
      if succ {
        //print("Loading \(retjson.count) tunes from the server")
        for (var i = 0; i < retjson.count; i++) {
          Services.append(Service(id: Int(retjson[i]["tune"].string!)!,
                                  name: retjson[i]["name"].string!,
                                  cost: Int(retjson[i]["cost"].string!)!,
                                  time: Int(retjson[i]["time"].string!)!,
                                  type: Int(retjson[i]["type"].string!)!))
            
            
//            print(retjson[i]["tune"].string!)
//            print("Count:",Services.count)
//            print(Tune.getTune(i))
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

    static func editTune(id: Int, name: String = "", cost: String = "", time: String = "", type: String = "")
  {
    // Edit an existing tune
    var MyParams = ["action":"editTune"] 
    MyParams["tune"] = String(id) // This is the tune ID.
    if name != "" { MyParams["tunename"] = name }
    if cost != "" { MyParams["tunecost"] = cost }
    if time != "" { MyParams["tunetime"] = time }
    if type != "" { MyParams["tunetype"] = type }

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
    if let s = Tune.getTune(id){
			if name != "" { s.sName = name }
    	if cost != "" { s.sCost = Int(cost)! }
    	if time != "" { s.sTime = Int(time)! }
        if type != "" { s.sType = Int(type)! }
      
    }
  }

  static func getServices() -> [Service]
  {
    return Services
  }

  static func numberOfTunes() -> Int
  {
    //print("Number of Services" , Services.count)
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

  static func getTunefromName(name: String) -> Service?
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