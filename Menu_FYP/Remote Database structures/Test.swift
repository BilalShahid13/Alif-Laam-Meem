//
//  Test.swift
//  Alif_Laam_Meem
//
//  Created by Amir Mughal on 24/11/2018.
//  Copyright © 2018 Bilal Shahid. All rights reserved.
//

import Foundation

struct Rule{
    var ruleTitle: String?
    var ruleDescription: String?
}
struct Item {
    var itemId:Int?
    var itemType:String?
    var itemValue:String?
    var rules = [Rule]()
}
struct Test {
    var itemId: Int?
    var items = [Item]()
    var submitted: Bool?
}
