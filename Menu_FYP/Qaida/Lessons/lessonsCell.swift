//
//  lessonsCell.swift
//  Menu_FYP
//
//  Created by Amir Mughal on 11/11/2018.
//  Copyright © 2018 Bilal Shahid. All rights reserved.
//

import UIKit

class lessonsCell: UICollectionViewCell {
    var cell_ID = 0
    @IBOutlet weak var subLessonCell: UIButton!
    @IBAction func gridCell(_ sender: Any) {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.isUserInteractionEnabled = false
    }
}
