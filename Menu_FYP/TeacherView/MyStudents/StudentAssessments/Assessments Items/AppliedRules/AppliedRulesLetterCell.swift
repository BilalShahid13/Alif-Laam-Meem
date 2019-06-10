//
//  AppliedRulesLetterCell.swift
//  Alif_Laam_Meem
//
//  Created by Bilal Shahid on 3/5/19.
//  Copyright © 2019 Bilal Shahid. All rights reserved.
//

import UIKit

class AppliedRulesLetterCell: UITableViewCell {
    
    var itemID = 0
    @IBOutlet weak var letter: UILabel!
    @IBOutlet weak var articulationPoint: UITextView!
    @IBOutlet weak var characteristic: UITextView!
    @IBOutlet weak var checkBox: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
