//
//  GridViewCell.swift
//  Menu_FYP
//
//  Created by Amir Mughal on 11/11/2018.
//  Copyright © 2018 Bilal Shahid. All rights reserved.
//

import UIKit

class GridViewCell: UICollectionViewCell {
    
    @IBOutlet weak var GridButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.isUserInteractionEnabled = false
        
    }
}
