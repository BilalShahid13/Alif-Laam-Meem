//
//  MyStudentsCollectionViewCell.swift
//  Alif_Laam_Meem
//
//  Created by Bilal Shahid on 02/12/2018.
//  Copyright © 2018 Bilal Shahid. All rights reserved.
//

import UIKit

class MyStudentsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var studentName: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.isUserInteractionEnabled = false
    }
}
