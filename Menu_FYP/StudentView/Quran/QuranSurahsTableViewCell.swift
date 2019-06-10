//
//  QuranSurahsCollectionViewCell.swift
//  Alif_Laam_Meem
//
//  Created by Fahd on 01/03/2019.
//  Copyright © 2019 Bilal Shahid. All rights reserved.
//

import UIKit
class QuranSurahsTableViewCell: UITableViewCell{
    @IBOutlet weak var surahName: UILabel!
    @IBOutlet weak var surahPage: UILabel!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
