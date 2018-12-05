//
//  PopUpVC.swift
//  Alif_Laam_Meem
//
//  Created by Amir Mughal on 03/12/2018.
//  Copyright © 2018 Bilal Shahid. All rights reserved.
//

import UIKit

class violatedRulesVC: UIViewController, UITableViewDelegate, UITableViewDataSource ,SBCardPopupContent{
    var popupViewController: SBCardPopupViewController?
    var allowsTapToDismissPopupCard: Bool = true
    var allowsSwipeToDismissPopupCard: Bool = true
    
    let reuseableIdentifier = "ruleViolationCell"
    @IBOutlet weak var wordName: UILabel!
    @IBOutlet weak var ruleViolationTable: UITableView!
    var names: [String] = ["1","2","3","4","5","6"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ruleViolationTable.dequeueReusableCell(withIdentifier: reuseableIdentifier, for: indexPath)
        cell.textLabel?.text = names[indexPath.row]
        return cell
    }
    @IBAction func okButton(_ sender: Any) {
        self.popupViewController?.close()
    }
    
}
