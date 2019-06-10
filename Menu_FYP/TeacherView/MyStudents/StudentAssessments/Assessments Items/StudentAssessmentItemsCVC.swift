//
//  StudentAssessmentItemsCVC.swift
//  Alif_Laam_Meem
//
//  Created by Amir Mughal on 06/12/2018.
//  Copyright © 2018 Bilal Shahid. All rights reserved.
//

import UIKit

class StudentAssessmentItemsCVC: UICollectionViewCell {
    
    @IBOutlet weak var itemValue: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.isUserInteractionEnabled = false
    }
}
