//
//  MenuViewController.swift
//  Menu_FYP
//
//  Created by Bilal Shahid on 11/8/18.
//  Copyright © 2018 Bilal Shahid. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController{
    var Student: User?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Dashboard"
        navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.black,
             NSAttributedString.Key.font: UIFont(name: "Apple SD Gothic Neo",size: 21)!]
    }
    @IBAction func segueQaida(_ sender: Any) {
        let destinationVC = storyboard?.instantiateViewController(withIdentifier: "QaidaMain") as! QaidaViewController
        destinationVC.Student = self.Student
        self.navigationController?.pushViewController(destinationVC, animated: true)
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
