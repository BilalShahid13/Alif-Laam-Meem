//
//  MenuViewController.swift
//  Menu_FYP
//
//  Created by Bilal Shahid on 11/8/18.
//  Copyright © 2018 Bilal Shahid. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Dashboard"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func segueQaida(_ sender: Any) {
        self.performSegue(withIdentifier: "DashboardToQaida", sender: nil)
    }
    
    @IBAction func segueQuran(_ sender: Any) {
        self.performSegue(withIdentifier: "DashboardToQuran", sender: nil)
    }
    @IBAction func segueAssessment(_ sender: Any) {
        self.performSegue(withIdentifier: "DashboardToMyAssessments", sender: nil)
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
