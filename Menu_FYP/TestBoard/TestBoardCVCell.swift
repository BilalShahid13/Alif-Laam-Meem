//
//  TestBoardCVCell.swift
//  Alif_Laam_Meem
//
//  Created by Amir Mughal on 27/11/2018.
//  Copyright © 2018 Bilal Shahid. All rights reserved.
//

import UIKit

class TestBoardCVCell: UICollectionViewCell {
    
    @IBOutlet weak var TestBoardButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.isUserInteractionEnabled = false
        
    }
}
