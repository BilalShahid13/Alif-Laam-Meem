//
//  AppliedRulesCell.swift
//  Alif_Laam_Meem
//
//  Created by Amir Mughal on 07/02/2019.
//  Copyright © 2019 Bilal Shahid. All rights reserved.
//

import UIKit

class AppliedRulesCell: UITableViewCell {

    var itemID = 0
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
