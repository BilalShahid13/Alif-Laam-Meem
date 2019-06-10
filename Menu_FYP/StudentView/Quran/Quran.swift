//
//  Quran.swift
//  Alif_Laam_Meem
//
//  Created by Bilal Shahid on 2/12/19.
//  Copyright © 2019 Bilal Shahid. All rights reserved.
//

import Foundation

class quran {
    
    private var csvRows=[[String]]()
    
    private(set) var surahName=[String]()
    
    private(set) var surahPage=[String]()
    
    init()
    {
        self.readQuran()
    }
    
    func readDataFromCSV(fileName:String, fileType: String)-> String!{
        guard let filepath = Bundle.main.path(forResource: fileName, ofType: fileType)
            else {
                return nil
        }
        do {
            var contents = try String(contentsOfFile: filepath, encoding: .utf8)
            contents = contents.replacingOccurrences(of: "\"", with: "")
            return contents
        } catch {
            print("File Read Error for file \(filepath)")
            return nil
        }
    }
    
    func csv(data: String) -> [[String]] {
        var result: [[String]] = []
        let rows = data.components(separatedBy: "\n")
        for row in rows {
            let columns = row.components(separatedBy: ",")
            result.append(columns)
        }
        return result
    }
    
    func readQuran(){
        let surahData=readDataFromCSV(fileName: "surahPages", fileType: "csv")
        let surahRows = csv(data: surahData!)
        var row:Int=1
        while row<(surahRows.count-1){
                surahName.append(surahRows[row][2])
            surahPage.append(surahRows[row][0])
                row += 1
            }
        }
}
