//
//  StudentAssessmentLessonsCollectionViewCell.swift
//  Alif_Laam_Meem
//
//  Created by Bilal Shahid on 29/11/2018.
//  Copyright © 2018 Bilal Shahid. All rights reserved.
//

import UIKit

class StudentAssessmentLessonsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var assessmentCell: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.isUserInteractionEnabled = false
    }
}
