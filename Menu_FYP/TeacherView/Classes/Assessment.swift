//
//  Assessment.swift
//  Alif_Laam_Meem
//
//  Created by Amir Mughal on 06/12/2018.
//  Copyright © 2018 Bilal Shahid. All rights reserved.
//

import Foundation

struct Assessment:Encodable,Decodable {
    var lessonId:Int
    var lessonTitle:String
    var submitted:Bool
}
