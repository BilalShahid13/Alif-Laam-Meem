//
//  MenuViewController.swift
//  Menu_FYP
//
//  Created by Bilal Shahid on 11/8/18.
//  Copyright © 2018 Bilal Shahid. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Dashboard"
        navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.black,
             NSAttributedString.Key.font: UIFont(name: "Apple SD Gothic Neo",size: 21)!]
//        let jsonUrlString = "http://192.168.8.100:8080/rest/TestService/Hi"
//        guard let url = URL(string: jsonUrlString) else {return}
//        URLSession.shared.dataTask(with: url) { (data, response, err) in
//            guard let data = data else {return}
//            let dataAsString = String(data: data, encoding: .utf8)
//            print(dataAsString ?? "null")
//            do {
//                let course = try JSONDecoder().decode(Course.self, from: data)
//                print(course.name)
//
//            } catch let JsonErr{
//                print("Error decoding",JsonErr)
//            }
//
//        }.resume()
    }
    @IBAction func segueQaida(_ sender: Any) {
        self.performSegue(withIdentifier: "DashboardToQaida", sender: nil)
    }
    
    @IBAction func segueQuran(_ sender: Any) {
        self.performSegue(withIdentifier: "DashboardToQuran", sender: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
