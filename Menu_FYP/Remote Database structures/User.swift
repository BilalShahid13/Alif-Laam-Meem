//
//  User.swift
//  Alif_Laam_Meem
//
//  Created by Amir Mughal on 24/11/2018.
//  Copyright © 2018 Bilal Shahid. All rights reserved.
//

import Foundation

struct User : Encodable,Decodable{
    var name: String
    var password:String
    var userType:String
    var id: Int
}
