//
//  PageCollectionViewCell.swift
//  Menu_FYP
//
//  Created by Bilal Shahid on 11/8/18.
//  Copyright © 2018 Bilal Shahid. All rights reserved.
//

import UIKit

class PageCollectionViewCell: UICollectionViewCell {
      
    override func awakeFromNib() {
        //super.awakeFromNib()
        // Initialization code
        // setup your Collection View B
    }
    
    
}


extension UICollectionViewCell:UICollectionViewDelegate,UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  =  collectionView.dequeueReusableCell(withReuseIdentifier: "AssessmentCell", for: indexPath) as! AssessmentCollectionViewCell
        return cell
    }
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
}
