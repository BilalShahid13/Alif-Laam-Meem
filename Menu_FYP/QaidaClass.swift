//
//  QaidaClass.swift
//  Alif_Laam_Meem
//
//  Created by Amir Mughal on 18/11/2018.
//  Copyright © 2018 Bilal Shahid. All rights reserved.
//

import Foundation

class activity{
    private var name:String
    private var words = [String]()
    init(){
        self.name = ""
        self.words = [""]
    }
    init(name: String, words: [String]) {
        self.name = name
        self.words = words
    }
    func getName()->String{
        return name
    }
    func getWords()->[String]{
        return words
    }
    func setName(name:String){
        self.name=name
    }
    func setwords(words:[String]){
        self.words=words
    }
}
class Qaida{
    private var activityLevel = [activity]()
    init(){
        
    }
    init(level: activity) {
        activityLevel.append(level)
    }
    func addActivity(level: activity){
        activityLevel.append(level)
    }
    func getActivities()->[String]{
        var activityNames=[String]()
        for i in 0..<activityLevel.count{
            activityNames.append(activityLevel[i].getName())
        }
        return activityNames
    }
    func getwords(index: Int)->[String]{
        return activityLevel[index].getWords()
    }
}
