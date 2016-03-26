//
//  TuneTests.swift
//  FormCycle
//
//  Created by Valle, Cody J on 3/26/16.
//  Copyright © 2016 Merrill Lines. All rights reserved.
//

import SwiftyJSON

class TuneTests
{
  func go() {
    // Add a new tune
    var MyParams2 = ["action":"addTune"]
    MyParams2["tunename"] = "Cody's Service"
    MyParams2["tunecost"] = "400.00"
    MyParams2["tunetime"] = "365"

    ServerCom.send(MyParams2, f: {(succ: Bool, retjson: JSON) in
    if succ {
    print("Successfully added a tune")
    }
    else {
    print("Failed to add tune.")
    }
    return succ
    })

    while ServerCom.waiting() {} // Not neccesarily needed, but is for this example

    // Get and display all tunes
    let MyParams = ["action":"retrieveTunes"]

    ServerCom.send(MyParams, f: {(succ: Bool, retjson: JSON) in
    if succ {
    print("There are \(retjson.count) tunes on the server")
    for (var i = 0; i < retjson.count; i++) {
    print("Tune \(i)")
    print("tune: \(retjson[i]["tune"].string!)")
    print("name: \(retjson[i]["name"].string!)")
    print("time: \(retjson[i]["time"].string!)")
    print("cost: \(retjson[i]["cost"].string!)")
    print("\n")
    }
    }
    else {
    print("Failed to retrieve tunes.")
    }
    return succ
    })

    while ServerCom.waiting() {} // Not neccesarily needed, but is for this example

    // Edit an existing tune
    var MyParams3 = ["action":"editTune"]
    MyParams3["tune"] = "12" // This is the tune ID.
    MyParams3["tunename"] = "Cody's Service is Best"
    MyParams3["tunecost"] = "800.00"
    MyParams3["tunetime"] = "700"

    ServerCom.send(MyParams3, f: {(succ: Bool, retjson: JSON) in
    if succ {
    print("Successfully edited a tune")
    }
    else {
    print("Failed to edit tune.")
    }
    return succ
    })

    while ServerCom.waiting() {} // Not neccesarily needed, but is for this example

    // Get and display all tunes again
    let MyParams4 = ["action":"retrieveTunes"]

    ServerCom.send(MyParams4, f: {(succ: Bool, retjson: JSON) in
    if succ {
    print("There are \(retjson.count) tunes on the server")
    for (var i = 0; i < retjson.count; i++) {
    print("Tune \(i)")
    print("tune: \(retjson[i]["tune"].string!)")
    print("name: \(retjson[i]["name"].string!)")
    print("time: \(retjson[i]["time"].string!)")
    print("cost: \(retjson[i]["cost"].string!)")
    print("\n")
    }
    }
    else {
    print("Failed to retrieve tunes.")
    }
    return succ
    })

    while ServerCom.waiting() {} // Not neccesarily needed, but is for this example
  }
  
}
