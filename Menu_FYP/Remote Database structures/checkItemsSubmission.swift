//
//  checkItemsSubmission.swift
//  Alif_Laam_Meem
//
//  Created by Amir Mughal on 07/03/2019.
//  Copyright © 2019 Bilal Shahid. All rights reserved.
//

import Foundation

struct checkItemsSubmission: Encodable,Decodable{
    var studentId :String
    var lessonId :String
    var itemsDetail:[itemDetails]
}
