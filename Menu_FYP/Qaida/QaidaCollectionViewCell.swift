//
//  QaidaCollectionViewCell.swift
//  Menu_FYP
//
//  Created by Bilal Shahid on 11/8/18.
//  Copyright © 2018 Bilal Shahid. All rights reserved.
//

import UIKit

class QaidaCollectionViewCell: UICollectionViewCell {
    
    var cell_ID = 0
    
    @IBOutlet weak var button: UIButton!
    @IBAction func gridCell(_ sender: Any) {
            }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.isUserInteractionEnabled = false

    }
}
