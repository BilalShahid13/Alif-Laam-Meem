//
//  violatedRulesLetterTVC.swift
//  Alif_Laam_Meem
//
//  Created by Bilal Shahid on 3/5/19.
//  Copyright © 2019 Bilal Shahid. All rights reserved.
//

import UIKit

class violatedRulesLetterTVC: UITableViewCell {

    @IBOutlet weak var characteristic: UITextView!
    @IBOutlet weak var articulationPoint: UITextView!
    @IBOutlet weak var letter: UILabel!
    @IBOutlet weak var checkBox: UIImageView!
    var itemID = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
