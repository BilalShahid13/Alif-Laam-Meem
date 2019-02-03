//
//  Test.swift
//  Alif_Laam_Meem
//
//  Created by Amir Mughal on 24/11/2018.
//  Copyright © 2018 Bilal Shahid. All rights reserved.
//

import Foundation

struct Rule: Decodable{
    var articulationPoint: String
    var characteristic: String
    var correct: String?
    
}
struct Item: Decodable{
    var itemId:Int
    var itemType:Int
    var itemValue:String
    var rules:[Rule]
}
struct Test: Decodable{
    var items : [Item]
}
