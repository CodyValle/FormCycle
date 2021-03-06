//
//  EditTune.swift
//  FormCycle
//
//  Created by Merrill Lines on 4/2/16.
//  Copyright © 2016 Merrill Lines. All rights reserved.
//

import UIKit

class EditTune
{
    //MARK: Properties
    
    let name: String
    let cost: Int
    let id: Int
    let time: Float
    let tune: String
    
    
    //MARK: Initialize properties
    init(name: String, cost: Int, id: Int, time: Float, tune: String)
    {
        self.id = id
        self.name = name
        self.cost = cost
        self.time = time
        self.tune = tune
        
    }
}
