//
//  NewAssessmentCollectionViewCell.swift
//  Alif_Laam_Meem
//
//  Created by Amir Mughal on 14/11/2018.
//  Copyright © 2018 Bilal Shahid. All rights reserved.
//

import UIKit

class NewAssessmentCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var word: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.isUserInteractionEnabled = false
        
    }
}
