//
//  TaskManager.swift
//  Alif_Laam_Meem
//
//  Created by Amir Mughal on 05/12/2018.
//  Copyright © 2018 Bilal Shahid. All rights reserved.
//

import Foundation

class TaskManager {
    static let shared = TaskManager()
    static let serverIP = "http://192.168.8.100:8080/rest/"
    let session = URLSession.shared
    
    typealias completionHandler = (Data?, URLResponse?, Error?) -> Void
    
    func dataTask(withRequest url: URLRequest, completion: @escaping completionHandler) {
        let _ = session.dataTask(with: url, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                print("Finished network task")
                completion(data,response,error)
            }
        }).resume()
    }
}
